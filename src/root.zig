const std = @import("std");
const testing = std.testing;
const c = @cImport({
    @cInclude("parser_color.h");
});

pub const Color = struct{
    r:u8 = 0,
    g:u8 = 0,
    b:u8 = 0,
    a:f64 = 1.0,
    pub inline fn new(r:u8,g:u8,b:u8,a:f64) Color {
        return .{
            .r = r,
            .g = g,
            .b = b,
            .a = a,
        };
    }
};
pub fn parse(str: []const u8) Color {
    const color =  c.parse_color(str.ptr);
    return Color.new(
        @intCast(color.r),
        @intCast(color.g),
        @intCast(color.b),
        @floatCast(color.a),
    );
}
fn assert_equal(expect:Color,actual:[]const u8)!void{
    const color = parse(actual);
    std.debug.print("{any}\n",.{color});
    try testing.expect(color.r == expect.r);
    try testing.expect(color.g == expect.g);
    try testing.expect(color.b == expect.b);
    try testing.expect(color.a == expect.a);
}
test {
    try assert_equal(Color.new(255,255,255,1.0),"rgba(255,255,255,1.0)");
    try assert_equal(Color.new( 255, 255, 255, 1 ), "#fff");
    try assert_equal(Color.new( 255, 0, 17, 1 ), "#ff0011");
    try assert_equal(Color.new( 106, 90, 205, 1 ), "slateblue");
    try assert_equal(.{}, "blah");
    try assert_equal(.{}, "ffffff");
    try assert_equal(Color.new( 226, 233, 233, 0.5), "hsla(900, 15%, 90%, 0.5)");
    try assert_equal(.{}, "hsla(900, 15%, 90%)");
    try assert_equal(Color.new( 226, 233, 233, 1 ), "hsl(900, 15%, 90%)");
    try assert_equal(Color.new( 226, 233, 233, 1 ), "hsl(900, 0.15, 90%)");
    try assert_equal(Color.new( 0, 0, 0, 1 ), "hsl(9999999999999999999, 0, 0)");
    try assert_equal(Color.new( 255, 191, 0, 1 ), "hsl(45, 100%, 50%)");
    try assert_equal(Color.new( 255, 191, 0, 1 ), "hsl(-315, 100%, 50%)");
    try assert_equal(Color.new( 255, 191, 0, 1 ), "hsl(-675, 100%, 50%)");
    try assert_equal(.{}, "xxx");
    try assert_equal(Color.new( 255, 128, 12, 1 ), " rgba (255, 128, 12, 2)");
    try assert_equal(Color.new( 255, 128, 12, 1 ), " rgba (400, 128, 12, 2)");
}
