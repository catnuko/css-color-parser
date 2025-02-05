const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "css-color-parser",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    configureLib(lib, b);
    b.installArtifact(lib);

    const mod = b.addModule("root", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{},
    });
    mod.addIncludePath(b.path("src"));
    mod.addIncludePath(b.path("src/css-color-parser-cpp"));
    mod.addCSourceFiles(.{
        .files = &.{ "src/css-color-parser-cpp/csscolorparser.cpp", "src/parse_color.cpp" },
        .flags = &.{
            "-std=c++17",
            "-Wall",
            "-Wextra",
            "-Wpedantic",
            "-Wno-unused-parameter",
        },
    });

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    configureLib(lib_unit_tests, b);

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
fn configureLib(lib: *std.Build.Step.Compile, b: *std.Build) void {
    lib.linkLibCpp();
    lib.addIncludePath(b.path("src"));
    lib.addIncludePath(b.path("src/css-color-parser-cpp"));
    lib.addCSourceFiles(.{
        .files = &.{ "src/css-color-parser-cpp/csscolorparser.cpp", "src/parse_color.cpp" },
        .flags = &.{
            "-std=c++17",
            "-Wall",
            "-Wextra",
            "-Wpedantic",
            "-Wno-unused-parameter",
        },
    });
}
