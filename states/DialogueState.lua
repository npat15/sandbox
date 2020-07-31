DialogueState = Class{__includes = BaseState}

local function text_box(message)
    -- display message to map
end

function DialogueState:init()
    assert(g_talking_npc, 'no one is talking!')

    self.talking = g_talking_npc
    self.talking.moves = false

    if not(self.talking.direction == player.direction) then
        if player.direction > 2 then
            self.talking.direction = player.direction - 2
            self.talking.currentFrame = self.talking.frames[self.talking.direction][1]
        else
            self.talking.direction = player.direction + 2
            self.talking.currentFrame = self.talking.frames[self.talking.direction][1]
        end
    end

    self.talking:render()

    self.index = 1
    self.dialogueTree = self.talking.dialogueTree
    self.length = get_length(self.dialogueTree)

    -- print first line 
    print(self.dialogueTree[self.index])
    self.index = self.index + 1
end

function DialogueState:update(dt)
    -- execute dialogue or switch out
    if self.index > self.length then
        self.talking.moves = true
        gStateMachine:change('play')
    elseif love.keyboard.wasPressed('k') then
        print(self.dialogueTree[self.index])
        self.index = self.index + 1
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
end