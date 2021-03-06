TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('e') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    -- wastes time 
    local player_obj 
    for k, object in pairs(gMap.objects) do
        if object.name == 'Player' then
            player_obj = object
            break
        end
    end

    local tx = math.floor(player_obj.x - GAME_WIDTH / 2)
    local ty = math.floor(player_obj.y - GAME_HEIGHT / 2)
    love.graphics.translate(-tx, -ty)

    for k, layer in pairs(map_toDraw) do
        gMap:drawTileLayer(layer)
    end

    -- set font
    love.graphics.setFont(titleFont)

    -- print to screen
    love.graphics.printf('Sandbox', 80, 320, GAME_WIDTH, 'center')    
    love.graphics.printf('Press Enter', 80, 420, GAME_WIDTH, 'center')
end