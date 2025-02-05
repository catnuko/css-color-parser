#include "csscolorparser.hpp"
#include "parser_color.h"
#include <iostream>
#include <istream>

extern "C" struct Color parse_color(const char *css_str)
{
    auto parsed = CSSColorParser::parse(std::string(css_str));
    auto color = parsed.value_or(CSSColorParser::Color());
    return {color.r, color.g, color.b, color.a};
}