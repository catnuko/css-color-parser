1. [css-color-parser-js](https://github.com/deanm/css-color-parser-js)
2. [css-color-parser-cpp](https://github.com/mapbox/css-color-parser-cpp)
3. [css-color-parser](https://github.com/catnuko/css-color-parser)

zig parser for CSS color strings.
```zig
const parse = @import("css-color-parser").parse;

fn assert_equal(expect:Color,actual:[]const u8)!void{
    const color = parse(actual);
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
```