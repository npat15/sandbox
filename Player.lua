Player = Class{}

function Player:init(name, U0, V0, U1, V1, charSheet)
    self.name = name
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1

    local player_obj
    for k, object in pairs(map.objects) do
        if object.name == self.name then
            player_obj = object
            break
        end
    end

    self.player_obj = player_obj

    --[[

    layer.player = {
        sprite = sprite,
        x      = player.x,
        y      = player.y,
        ox     = sprite:getWidth() / 2,
        oy     = sprite:getHeight() / 1.35
    }

    
    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
            self.player.sprite,
            math.floor(self.player.x),
            math.floor(self.player.y),
            0,
            1,
            1,
            self.player.ox,
            self.player.oy
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end
    ]]--

    self.charSheet = love.graphics.newImage(charSheet)
    self.spriteQuad = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

end

function Player:update()
end

function Player:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.spriteQuad, self.player_obj.x, self.player_obj.y - 10)
end