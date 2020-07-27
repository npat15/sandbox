Player = Class{}

local WALKING_SPEED = 40
local ANIMATION_SPEED = 0.1

function Player:init(name, U0, V0, U1, V1, charSheet)
    self.name = name
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1
    self.direction = 1
    --self.layer = spriteLayer

    -- find player within object layer
    local player_obj
    for k, object in pairs(map.objects) do
        if object.name == self.name then
            player_obj = object
            break
        end
    end

    self.player_obj = player_obj
    self.x = self.player_obj.x
    self.y = self.player_obj.y

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

    -- store all frames in one table for easy access
    self.frames = {
        loadFrames(0), 
        loadFrames(FRAME_HEIGHT), 
        loadFrames(2 * FRAME_HEIGHT), 
        loadFrames(3 * FRAME_HEIGHT)
        }
end

function Player:update(dt)
    self.timer = self.timer + dt

    -- initialize these here so there's no nil error in update
    future_x = self.player_obj.x
    future_y = self.player_obj.y

    -- pick current frame base on elapsed time
    function frameIndex()
        -- should this be local?
        -- could we use modulus instead?
        frame = math.ceil(self.timer / ANIMATION_SPEED)
        if frame > 4 then
            self.timer = 0
            frame = 1
        end
        return frame
    end

    if love.keyboard.wasPressed('j') then
        shed:enter()
    end

    if love.keyboard.wasPressed('o') then
        shed:exit()
    end
    
    -- Move player up
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.direction = 3
        future_y = self.player_obj.y - WALKING_SPEED * dt
    -- Move player down
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.direction = 1
        future_y = self.player_obj.y + WALKING_SPEED * dt
    -- Move player left
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.direction = 4
        future_x = self.player_obj.x - WALKING_SPEED * dt
    -- Move player right
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.direction = 2
        future_x = self.player_obj.x + WALKING_SPEED * dt
    end

    -- determine animation 
    if future_x == self.player_obj.x and future_y == self.player_obj.y then
        self.currentFrame = self.frames[self.direction][1]
    else
        self.currentFrame = self.frames[self.direction][frameIndex()]
    end

    -- look for collision 
    local actualX, actualY, collisions, len = world:check(self, future_x, future_y)

    if len == 0 then
        -- if no collision, let player move
        self.player_obj.x = future_x
        self.player_obj.y = future_y
        self.x = self.player_obj.x
        self.y = self.player_obj.y
        world:move(self, self.x, self.y)
    else
        --local trig = map:bump_checkTrigger(future_x, future_y)
        local trig = -1
        if trig < 0 then
            -- keep player in place
            self.player_obj.x = actualX
            self.player_obj.y = actualY
            self.x = self.player_obj.x
            self.y = self.player_obj.y
            self.currentFrame = self.frames[self.direction][1]
            world:move(self, self.x, self.y)
        else
            trig:enter()
        end
    end
end

function Player:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.currentFrame, self.player_obj.x, self.player_obj.y - 10)
end