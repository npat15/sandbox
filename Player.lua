Player = Class{}

local WALKING_SPEED = 40

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

    -- start timer
    self.timer = 0

    -- start player facing downward
    self.charSheet = love.graphics.newImage(charSheet)
    self.currentFrame = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

    -- load animation frames
    -- hardcoded frames for now
    FRAME_WIDTH = 16
    FRAME_HEIGHT = 32
    
    SHEET_WIDTH = self.charSheet:getWidth()
    SHEET_HEIGHT = self.charSheet:getHeight()

    function loadFrames(start_y)
        frameTable = {}
        for i = 0, 3 do
            table.insert(frameTable, love.graphics.newQuad(i * FRAME_WIDTH, start_y, FRAME_WIDTH, FRAME_HEIGHT, SHEET_WIDTH, SHEET_HEIGHT))
        end
        return frameTable
    end

    self.downFrames = loadFrames(0)
    self.rightFrames = loadFrames(FRAME_HEIGHT)
    self.upFrames = loadFrames(2 * FRAME_HEIGHT)
    self.leftFrames = loadFrames(3 * FRAME_HEIGHT)
end

function Player:update(dt)

    --[[ INPUT HANDLER - TRY IMPLEMENTING AGAIN AT SOME POINT
    local PLAYER_KEYS = {

        w = 'walk_up',
        a = 'walk_left',
        d = 'walk_right',
        s = 'walk_down',
    }

    local BINDINGS = {

        walk_up = function() self.player_obj.y = self.player_obj.y - WALKING_SPEED * dt end,
        walk_left = function() self.player_obj.x = self.player_obj.x - WALKING_SPEED * dt end,
        walk_right = function() self.player_obj.x = self.player_obj.x + WALKING_SPEED * dt end,
        walk_down = function()  self.player_obj.y = self.player_obj.y + WALKING_SPEED * dt end ,
    }

    function inputHandler(input, k)
        local action = BINDINGS[input]
        if action then  
            return action()
        end
    end

    function love.keypressed(k, isRepeat)
        local binding = PLAYER_KEYS[k]
        return inputHandler(binding, k)
    end
    --]]

    self.timer = self.timer + dt

    -- pick current frame base on elapsed time
    function frameIndex(animationSpeed)
        -- should this be local?
        -- could we use modulus instead?
        frame = math.ceil(self.timer / animationSpeed)

        if frame > 4 then
            self.timer = 0
            frame = 1
        end

        return frame
    end
    
    -- Move player up
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.player_obj.y = self.player_obj.y - WALKING_SPEED * dt
        self.currentFrame = self.upFrames[frameIndex(0.1)]
    -- Move player down
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.player_obj.y = self.player_obj.y + WALKING_SPEED * dt
        self.currentFrame = self.downFrames[frameIndex(0.1)]
    -- Move player left
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.player_obj.x = self.player_obj.x - WALKING_SPEED * dt
        self.currentFrame = self.leftFrames[frameIndex(0.1)]
    -- Move player right
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.player_obj.x = self.player_obj.x + WALKING_SPEED * dt
        self.currentFrame = self.rightFrames[frameIndex(0.1)]
    end
end

function Player:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.currentFrame, self.player_obj.x, self.player_obj.y - 10)
end