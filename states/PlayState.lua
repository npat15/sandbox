PlayState = Class{__includes = BaseState}

function PlayState:init()
    --local layer = map:addCustomLayer("Sprites", 8)
    self.player = Player('Player', 0, 0, 16, 32, "tiles/gfx/character.png")

    -- get rid of object box
    map:removeLayer("Game Objects")
end

function PlayState:update(dt)
    map:update(dt)
end

function PlayState:render()
    map:draw()
    
    -- draw sprite
    self.player:render()
end
