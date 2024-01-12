local ffi = require("ffi")
local SDL2 = require("Game.Framework.Backend.SDL2")
local SDLTTF = require("Game.Framework.Backend.SDLTTF")
Game.Graphics = {}

Game.Graphics._bgColor = {0, 0, 0, 255}
Game.Graphics._font = SDLTTF.OpenFont("Assets/Fonts/arial.ttf", 12)
Game.Graphics._color = ffi.new("SDL_Color", {255, 255, 255, 255})

-- draw rect
function Game.Graphics.DrawRect(type, x, y, w, h)
    local type = type or "fill"
    local rect = ffi.new("SDL_Rect")
    rect.x = x or 0
    rect.y = y or 0
    rect.w = w or 25
    rect.h = h or 25
    
    if type == "fill" then
        SDL2.RenderFillRect(Game.Window._renderer, rect)
    elseif type == "draw" then
        SDL2.RenderDrawRect(Game.Window._renderer, rect)
    end
end

-- set bg color
function Game.Graphics.SetBackgroundColor(r, g, b, a)
    local r = r or 0
    local g = g or 0
    local b = b or 0
    local a = a or 255
    Game.Graphics._bgColor = {r, g, b, a}
    SDL2.SetRenderDrawColor(Game.Window._renderer, r, g, b, a)
end

-- Print
function Game.Graphics.Print(text, x, y, font, color)
    local font = font or Game.Graphics._font
    local color = color or Game.Graphics._color
    local x = x or 0
    local y = y or 0
    local text = text or "Hello World!"
    local surface = SDLTTF.RenderText_Solid(font, text, color)
    local texture = SDL2.CreateTextureFromSurface(Game.Window._renderer, surface)
    local w = ffi.new("int[1]")
    local h = ffi.new("int[1]")
    SDL2.QueryTexture(texture, nil, nil, w, h)
    SDL2.RenderCopy(Game.Window._renderer, texture, nil, ffi.new("SDL_Rect", {x, y, w[0], h[0]}))
    SDL2.FreeSurface(surface)
    SDL2.DestroyTexture(texture)
end