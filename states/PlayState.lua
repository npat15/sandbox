PlayState = Class{__includes = BaseState}

function PlayState:update(dt)
    map:update(dt)
end

function PlayState:render()
    map:draw()
    
    -- draw sprite
    love.graphics.draw(sprite, character, 100, 100)
end
