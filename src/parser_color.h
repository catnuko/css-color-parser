#ifndef PARSER_COLOR_H
#define PARSER_COLOR_H

#ifdef __cplusplus
extern "C"
{
#endif
    struct Color
    {
        unsigned char r;
        unsigned char g;
        unsigned char b;
        float a;
    };
    struct Color parse_color(const char *css_str);

#ifdef __cplusplus
}
#endif

#endif // PARSER_COLOR_H
