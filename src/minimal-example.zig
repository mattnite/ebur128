const std = @import("std");
const c = @cImport({
    @cInclude("sndfile.h");
});

usingnamespace @import("ebur128");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = &gpa.allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        if (args.len > 0) {
            std.log.err("usage: {s} FILENAME...", .{args[0]});
        }

        std.process.exit(1);
    }

    const filenames = args[1..];
    var states = try std.ArrayList(*State).initCapacity(allocator, args.len - 1);
    defer {
        for (states.items) |*state| State.destroy(state);
        states.deinit();
    }

    for (filenames) |path| {
        var file_info = std.mem.zeroes(c.SF_INFO);
        const file = c.sf_open(path, c.SFM_READ, &file_info) orelse {
            std.log.err("failed to open {s}", .{path});
            return error.FailedFileOpen;
        };
        defer {
            if (c.sf_close(file) != 0) {
                std.log.err("failed to close {s}", .{path});
            }
        }

        try states.append(try State.create(@intCast(c_uint, file_info.channels), @intCast(c_uint, file_info.samplerate), .i));
        const current = states.items[states.items.len - 1];
        // TODO: set channel map

        var buffer = try allocator.alloc(f64, current.getSampleRate() * current.getChannels());
        defer allocator.free(buffer);

        while (true) {
            var frames: []f64 = undefined;
            frames.ptr = buffer.ptr;
            frames.len = @intCast(usize, c.sf_readf_double(file, buffer.ptr, @intCast(i64, current.getSampleRate())));
            if (frames.len == 0)
                break;

            try current.addFrames(f64, frames);
        }

        const loudness = try current.loudnessGlobal();
        std.log.info("{s} loudness: {} LUFS", .{ path, loudness });
    }

    if (filenames.len > 1) {
        const loudness = try loudnessGlobalMultiple(states.items);
        std.log.info("multiple loudness: {} LUFS", .{loudness});
    }
}
