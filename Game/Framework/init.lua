local ffi = require("ffi")

local Game = {}

local path = (...) .. "."

Game._sdl2 = require(path .. "Backend.SDL2")
Game.Window = require(path .. "Modules.Window")
function Game:run()
    if self.load then self:load() end

    -- events
    local event = ffi.new("SDL_Event")

    -- main loop
    while not self.Window.ShouldQuit do
        -- poll events
        while self._sdl2.PollEvent(event) ~= 0 do
            if event.type == self._sdl2.EventType.Quit then
                if self.quit then self:quit() end
                self.Window.Quit()
            end
        end

        -- update
        if self.update then self:update() end

        -- draw
        if self.draw then self:draw() end

        -- delay
        self.Window.Delay(1)
    end
end

function Game:quit()
    -- override this
end

return Game