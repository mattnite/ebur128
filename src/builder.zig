const std = @import("std");
const download = @import("download");

allocator: *std.mem.Allocator,
base_path: []const u8,
src_path: []const u8,
include_dir: []const u8,

const Self = @This();

const version = "v1.2.6";

pub fn init(b: *std.build.Builder) !Self {
    const base_path = try download.tar.gz(
        b.allocator,
        b.cache_root,
        "https://github.com/jiixyj/libebur128/archive/" ++ version ++ ".tar.gz",
        .{
            .name = "libebur128-" ++ version,
        },
    );
    errdefer b.allocator.free(base_path);

    const src_path = try std.fs.path.join(b.allocator, &[_][]const u8{ base_path, "ebur128", "ebur128.c" });
    errdefer b.allocator.free(src_path);

    const include_dir = try std.fs.path.join(b.allocator, &[_][]const u8{ base_path, "ebur128", "queue" });
    errdefer b.allocator.free(include_dir);

    return Self{
        .allocator = b.allocator,
        .base_path = base_path,
        .src_path = src_path,
        .include_dir = include_dir,
    };
}

pub fn deinit(self: *Self) void {
    self.allocator.free(self.base_path);
    self.allocator.free(self.src_path);
    self.allocator.free(self.include_dir);
}

pub fn link(self: Self, obj: *std.build.LibExeObjStep) void {
    obj.addCSourceFile(self.src_path, &[_][]const u8{});
    obj.addIncludeDir(self.include_dir);
    obj.linkLibC();
}
