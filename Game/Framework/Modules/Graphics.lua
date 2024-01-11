local ffi = require("ffi")
local SDL2 = require("Game.Framework.Backend.SDL2")

Game.Graphics = {}

Game.Graphics._bgColor = {0, 0, 0, 255}

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