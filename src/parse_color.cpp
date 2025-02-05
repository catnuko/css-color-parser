#include "csscolorparser.hpp"
#include "parser_color.h"
#include <iostream>
#include <istream>

extern "C" struct Color parse_color(const char *css_str)
{
    auto parsed = CSSColorParser::parse(std::string(css_str));
    if (parsed.has_value())
    {
        auto color = *parsed;
        return {color.r, color.g, color.b, color.a, 1};
    }
    else
    {
        return {0, 0, 0, 0, 0};
    }
}