package.path = package.path .. ";./?.lua;./?/init.lua;./?/?.lua;./?/?.init.lua"
package.path = package.path .. ";./Game/?.lua;./Game/?/init.lua;./Game/?/?.lua;./Game/?/?.init.lua"

-- cpath
package.cpath = package.cpath .. ";./?.dll;./?/?.dll;./?/?.so;./?/?.dylib"
package.cpath = package.cpath .. ";./Game/?.dll;./Game/?/?.dll;./Game/?/?.so;./Game/?/?.dylib"

require("Game.Framework")

local player = {
    x = 0,
    y = 0
}

function Game:load()
    Game.Window.CreateWindow("Game", nil, nil, 640, 480, 0)

end

function Game:update(dt)    
    if Game.Keyboard.IsKeyDown("W") then
        player.y = player.y - 100 * dt
    elseif Game.Keyboard.IsKeyDown("S") then
        player.y = player.y + 100 * dt
    end

    if Game.Keyboard.IsKeyDown("A") then
        player.x = player.x - 100 * dt
    elseif Game.Keyboard.IsKeyDown("D") then
        player.x = player.x + 100 * dt
    end
end

function Game:keypressed(key)
end

function Game:keyreleased(key)
end

function Game:draw()
    Game._sdl2.SetRenderDrawColor(Game.Window._renderer, 255, 255, 255, 255)
    Game.Graphics.DrawRect("fill", player.x, player.y, 100, 100)
end

Game:run()