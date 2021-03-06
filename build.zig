const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("ebur128", "src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    const exe = b.addExecutable("minimal", "src/minimal-example.zig");
    exe.setBuildMode(mode);
    exe.addPackagePath("ebur128", "src/main.zig");
    exe.linkSystemLibrary("ebur128");
    exe.linkSystemLibrary("sndfile");
    exe.linkLibC();
    exe.install();

    var main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
