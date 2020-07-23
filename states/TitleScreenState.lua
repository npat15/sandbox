TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()

    map:draw()

    -- set font
    love.graphics.setFont(titleFont)

    -- print to screen
    love.graphics.printf('Sandbox', 0, 64, GAME_WIDTH, 'center')    
    love.graphics.printf('Press Enter', 0, 200, GAME_WIDTH, 'center')
end