local ffi = require("ffi")

-- SDLttf
ffi.cdef [[
typedef struct _TTF_Font TTF_Font;

int TTF_Init(void);
TTF_Font *TTF_OpenFont(const char *file, int ptsize);
TTF_Font *TTF_OpenFontIndex(const char *file, int ptsize, long index);
TTF_Font *TTF_OpenFontRW(SDL_RWops *src, int freesrc, int ptsize);
TTF_Font *TTF_OpenFontIndexRW(SDL_RWops *src, int freesrc, int ptsize, long index);
int TTF_GetFontStyle(TTF_Font *font);
void TTF_SetFontStyle(TTF_Font *font, int style);
int TTF_GetFontOutline(TTF_Font *font);
void TTF_SetFontOutline(TTF_Font *font, int outline);
int TTF_GetFontHinting(TTF_Font *font);
void TTF_SetFontHinting(TTF_Font *font, int hinting);
int TTF_FontHeight(TTF_Font *font);
int TTF_FontAscent(TTF_Font *font);
int TTF_FontDescent(TTF_Font *font);
int TTF_FontLineSkip(TTF_Font *font);
long TTF_FontFaces(TTF_Font *font);
int TTF_FontFaceIsFixedWidth(TTF_Font *font);

// render
SDL_Surface *TTF_RenderUTF8_Solid(TTF_Font *font, const char *text, SDL_Color fg);
SDL_Surface *TTF_RenderUTF8_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg);
SDL_Surface *TTF_RenderUTF8_Blended(TTF_Font *font, const char *text, SDL_Color fg);
SDL_Surface *TTF_RenderUTF8_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color fg, Uint32 wrapLength);
SDL_Surface *TTF_RenderGlyph_Solid(TTF_Font *font, Uint16 ch, SDL_Color fg);
SDL_Surface *TTF_RenderGlyph_Shaded(TTF_Font *font, Uint16 ch, SDL_Color fg, SDL_Color bg);
SDL_Surface *TTF_RenderGlyph_Blended(TTF_Font *font, Uint16 ch, SDL_Color fg);
SDL_Surface *TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg);
SDL_Surface *TTF_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg);
SDL_Surface *TTF_RenderText_Blended(TTF_Font *font, const char *text, SDL_Color fg);
SDL_Surface *TTF_RenderText_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color fg, Uint32 wrapLength);


void TTF_CloseFont(TTF_Font *font);
void TTF_Quit(void);
]]

local SDLttf = ffi.load("Lib/SDL2_ttf.dll")

local TTF = {}

TTFFont = {}

function TTF.Init()
    if SDLttf.TTF_Init() == -1 then
        print("TTF_Init error: " .. SDLttf.TTF_GetError())
    end
end

function TTF.OpenFont(file, ptsize)
    local file = file or ""
    local ptsize = ptsize or 16
    file = "C:/Windows/Fonts/" .. file
    local font = SDLttf.TTF_OpenFont(file, ptsize)
    if font == nil then
        print("Can't open font at " .. file)
    end
end

function TTF.OpenFontIndex(file, ptsize, index)
    local file = file or ""
    local ptsize = ptsize or 16
    local index = index or 0
    local font = SDLttf.TTF_OpenFontIndex(file, ptsize, index)
    if font == nil then
    end
    return font
end

function TTF.OpenFontRW(src, freesrc, ptsize)
    local src = src or nil
    local freesrc = freesrc or 0
    local ptsize = ptsize or 16
    local font = SDLttf.TTF_OpenFontRW(src, freesrc, ptsize)
    if font == nil then
        print("TTF_OpenFontRW error: " .. SDLttf.TTF_GetError())
    end
    return font
end

function TTF.OpenFontIndexRW(src, freesrc, ptsize, index)
    local src = src or nil
    local freesrc = freesrc or 0
    local ptsize = ptsize or 16
    local index = index or 0
    local font = SDLttf.TTF_OpenFontIndexRW(src, freesrc, ptsize, index)
    if font == nil then
        print("TTF_OpenFontIndexRW error: " .. SDLttf.TTF_GetError())
    end
    return font
end

function TTF.GetFontStyle(font)
    local font = font or nil
    local style = SDLttf.TTF_GetFontStyle(font)
    return style
end

function TTF.SetFontStyle(font, style)
    local font = font or nil
    local style = style or 0
    SDLttf.TTF_SetFontStyle(font, style)
end

function TTF.GetFontOutline(font)
    local font = font or nil
    local outline = SDLttf.TTF_GetFontOutline(font)
    return outline
end

function TTF.SetFontOutline(font, outline)
    local font = font or nil
    local outline = outline or 0
    SDLttf.TTF_SetFontOutline(font, outline)
end

function TTF.GetFontHinting(font)
    local font = font or nil
    local hinting = SDLttf.TTF_GetFontHinting(font)
    return hinting
end

function TTF.SetFontHinting(font, hinting)
    local font = font or nil
    local hinting = hinting or 0
    SDLttf.TTF_SetFontHinting(font, hinting)
end

function TTF.FontHeight(font)
    local font = font or nil
    local height = SDLttf.TTF_FontHeight(font)
    return height
end

function TTF.FontAscent(font)
    local font = font or nil
    local ascent = SDLttf.TTF_FontAscent(font)
    return ascent
end

function TTF.FontDescent(font)
    local font = font or nil
    local descent = SDLttf.TTF_FontDescent(font)
    return descent
end

function TTF.FontLineSkip(font)
    local font = font or nil
    local lineskip = SDLttf.TTF_FontLineSkip(font)
    return lineskip
end

function TTF.FontFaces(font)
    local font = font or nil
    local faces = SDLttf.TTF_FontFaces(font)
    return faces
end

function TTF.FontFaceIsFixedWidth(font)
    local font = font or nil
    local fixed = SDLttf.TTF_FontFaceIsFixedWidth(font)
    return fixed
end

function TTF.RenderUTF8_Solid(font, text, fg)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local surface = SDLttf.TTF_RenderUTF8_Solid(font, text, fg)
    if surface == nil then
        print("TTF_RenderUTF8_Solid error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderUTF8_Shaded(font, text, fg, bg)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local bg = bg or ffi.new("SDL_Color", {0, 0, 0, 255})
    local surface = SDLttf.TTF_RenderUTF8_Shaded(font, text, fg, bg)
    if surface == nil then
        print("TTF_RenderUTF8_Shaded error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderUTF8_Blended(font, text, fg)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local surface = SDLttf.TTF_RenderUTF8_Blended(font, text, fg)
    if surface == nil then
        print("TTF_RenderUTF8_Blended error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderUTF8_Blended_Wrapped(font, text, fg, wrapLength)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local wrapLength = wrapLength or 0
    local surface = SDLttf.TTF_RenderUTF8_Blended_Wrapped(font, text, fg, wrapLength)
    if surface == nil then
        print("TTF_RenderUTF8_Blended_Wrapped error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderGlyph_Solid(font, ch, fg)
    local font = font or nil
    local ch = ch or 0
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local surface = SDLttf.TTF_RenderGlyph_Solid(font, ch, fg)
    if surface == nil then
        print("TTF_RenderGlyph_Solid error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderGlyph_Shaded(font, ch, fg, bg)
    local font = font or nil
    local ch = ch or 0
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local bg = bg or ffi.new("SDL_Color", {0, 0, 0, 255})
    local surface = SDLttf.TTF_RenderGlyph_Shaded(font, ch, fg, bg)
    if surface == nil then
        print("TTF_RenderGlyph_Shaded error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderGlyph_Blended(font, ch, fg)
    local font = font or nil
    local ch = ch or 0
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local surface = SDLttf.TTF_RenderGlyph_Blended(font, ch, fg)
    if surface == nil then
        print("TTF_RenderGlyph_Blended error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

function TTF.RenderText_Solid(font, text, fg)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local surface = SDLttf.TTF_RenderText_Solid(font, text, fg)
    if surface == nil then
        print("Unable to render text surface! SDL_ttf Error :(")
    end
    return surface
end

function TTF.RenderText_Shaded(font, text, fg, bg)
    local font = font or nil
    local text = text or ""
    local fg = fg or ffi.new("SDL_Color", {255, 255, 255, 255})
    local bg = bg or ffi.new("SDL_Color", {0, 0, 0, 255})
    local surface = SDLttf.TTF_RenderText_Shaded(font, text, fg, bg)
    if surface == nil then
        print("TTF_RenderText_Shaded error: " .. SDLttf.TTF_GetError())
    end
    return surface
end

return TTF