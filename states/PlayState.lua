PlayState = Class{__includes = BaseState}

function PlayState:init()
    if g_new_map then
        -- create player and add it to world    
        player = map_player
        world:add(player, math.floor(player.x), math.floor(player.y), 16, 32)

        for k, npc in pairs(map_npcs) do
            world:add(npc, math.floor(npc.x), math.floor(npc.y), 16, 16)
        end

        g_new_map = false
    end
end

function PlayState:update(dt)
    -- update map, player, npcs
    gMap:update(dt)
    player:update(dt)

    for k, npc in pairs(map_npcs) do
        npc:update(dt)
    end
end

function PlayState:render()
    -- make world move around player
    local tx = math.floor(player.x - GAME_WIDTH / 2)
    local ty = math.floor(player.y - GAME_HEIGHT / 2)
    love.graphics.translate(-tx, -ty)

    -- draw map, player, npcs
    for k, layer in pairs(map_toDraw) do
        gMap:drawTileLayer(layer)
    end

    player:render()

    for k, npc in pairs(map_npcs) do
        npc:render()
    end
end
