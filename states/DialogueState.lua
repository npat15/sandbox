DialogueState = Class{__includes = BaseState}

function DialogueState:init()
    assert(g_talking_npc, 'no one is talking!')

    self.talking = g_talking_npc
    self.talking.moves = false

    -- face player
    if player.direction > 2 then
        self.talking.direction = player.direction - 2
        self.talking.currentFrame = self.talking.frames[self.talking.direction][1]
    else
        self.talking.direction = player.direction + 2
        self.talking.currentFrame = self.talking.frames[self.talking.direction][1]
    end

    self.talking:render()

    -- set up dialogue UI
    self.box = love.graphics.newImage('maps/tiles/gfx/Dialog.png')
    self.index = 1
    self.dialogueTree = self.talking.dialogueTree
    self.length = get_length(self.dialogueTree)

    -- print first line 
    sounds['talk']:play()

    message = self.dialogueTree[self.index]
    message = g_talking_npc.name..': '..message
end

function DialogueState:update(dt)
    -- execute dialogue or switch out
    if self.index == self.length then
        if love.keyboard.wasPressed('k') then
            sounds['talk']:play()
            self.talking.moves = true
            gStateMachine:change('play')
        end
    elseif love.keyboard.wasPressed('k') then
        sounds['talk']:play()
        self.index = self.index + 1
        message = self.dialogueTree[self.index]
        message = g_talking_npc.name..': '..message
    end

    -- move other villagers
    for k, npc in pairs(map_npcs) do
        npc:update(dt)
    end
end

-- same as play state
function DialogueState:render()
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
 
    -- stop hardcode
    love.graphics.draw(self.box, player.x - GAME_WIDTH / 2 + 40, player.y + GAME_HEIGHT / 2 - 150)
    love.graphics.setFont(dialogueFont)
    love.graphics.printf(message, player.x - GAME_WIDTH / 2 + 60, player.y + GAME_HEIGHT / 2 - 140, 350)
end