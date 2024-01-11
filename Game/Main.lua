package.path = package.path .. ";./?.lua;./?/init.lua;./?/?.lua;./?/?.init.lua"
package.path = package.path .. ";./Game/?.lua;./Game/?/init.lua;./Game/?/?.lua;./Game/?/?.init.lua"

-- cpath
package.cpath = package.cpath .. ";./?.dll;./?/?.dll;./?/?.so;./?/?.dylib"
package.cpath = package.cpath .. ";./Game/?.dll;./Game/?/?.dll;./Game/?/?.so;./Game/?/?.dylib"

Game = require("Game.Framework")

function Game:load()
    Game.Window.CreateWindow("Game", nil, nil, 640, 480, 0)
end

function Game:update(dt)

end

function Game:draw()

end


Game:run()