PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- create player and add it to world
    self.player = Player('Player', 0, 0, 16, 32, "tiles/gfx/character.png")
    world:add(self.player, math.floor(self.player.x), math.floor(self.player.y), 16, 32)
    -- get rid of object box
    map.layers["Game Objects"].visible = false
end

function PlayState:update(dt)
    map:update(dt)
    --world:update(self.player, math.floor(self.player.x), math.floor(self.player.y), 16, 32)
    self.player:update(dt)
end

function PlayState:render()
    map:draw()
    
    -- draw sprite
    self.player:render()
end
