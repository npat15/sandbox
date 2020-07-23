PlayState = Class{__includes = BaseState}

function PlayState:update(dt)
    map:update(dt)
end

function PlayState:render()
    map:draw()
end
