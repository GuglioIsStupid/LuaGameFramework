local Window = {}
local SDL2 = require("Game.Framework.Backend.SDL2")
local Windows = require("Game.Framework.Backend.Windows")

function Window.CreateWindow(title, x, y, w, h, flags)
    local desktopWidth, desktopHeight = Windows.GetDesktopDimensions()
    local x = x or desktopWidth / 2 - w / 2
    local y = y or desktopHeight / 2 - h / 2
    return SDL2.CreateWindow(title, x, y, w, h, flags)
end

function Window.DestroyWindow(window)
    SDL2.DestroyWindow(window)
end

function Window.CreateRenderer(window, index, flags)
    return SDL2.CreateRenderer(window, index, flags)
end

function Window.DestroyRenderer(renderer)
    SDL2.DestroyRenderer(renderer)
end

-- should quit?
Window.ShouldQuit = false

-- close functions
function Window.Quit()
    print("Quitting...")
    Window.ShouldQuit = true
    SDL2.Quit()
end

-- delay
function Window.Delay(ms)
    SDL2.Delay(ms)
end

-- get ticks
function Window.GetTicks()
    return SDL2.GetTicks()
end

-- get window size
function Window.GetWindowSize(window)
    return SDL2.GetWindowSize(window)
end

-- get renderer output size
function Window.GetRendererOutputSize(renderer)
    return SDL2.GetRendererOutputSize(renderer)
end

-- renderer functions
function Window.RenderClear(renderer)
    SDL.SDL_RenderClear(renderer)
end


return Window