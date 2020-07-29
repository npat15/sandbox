PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- create player and add it to world
    player = Character('Player', 'player', 0, 0, 16, 32, "tiles/gfx/character.png", true)
    npc = Character('NPC', 'npc',0, 0, 16, 32, "tiles/gfx/NPC_test.png", true)

    world:add(player, math.floor(player.x), math.floor(player.y), 16, 32)
    world:add(npc, math.floor(npc.x), math.floor(npc.y), 16, 16)
end

function PlayState:update(dt)
    map:update(dt)
    player:update(dt)
    npc:update(dt)
end

function PlayState:render()
    -- make world move around player
    local tx = math.floor(player.x - GAME_WIDTH / 2)
    local ty = math.floor(player.y - GAME_HEIGHT / 2)
    love.graphics.translate(-tx, -ty)

    for k, layer in pairs(toDraw) do
        map:drawTileLayer(layer)
    end

    player:render()
    npc:render()
end
