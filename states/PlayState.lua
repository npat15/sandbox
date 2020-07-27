PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- create player and add it to world
    player = Player('Player', 0, 0, 16, 32, "tiles/gfx/character.png")
    world:add(player, math.floor(player.x), math.floor(player.y), 16, 32)
end

function PlayState:update(dt)
    map:update(dt)
    player:update(dt)
end

function PlayState:render()
    --map:draw()
    for k, layer in pairs(toDraw) do
        map:drawTileLayer(layer)
    end
    
    -- draw sprite
    player:render()
end
