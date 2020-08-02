return {

    {   
        filename = 'maps/map.lua',
        toDraw = {"Tile Layer 1", "Buildings"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/map.lua', {}),
        npcs =      {
                        Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    },

        mtriggers = {
            
                    },
    },

    {   
        filename = 'maps/spawn.lua',
        toDraw = {"terrain0", "terrain1"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/spawn.lua', {}),
        npcs =      {
                        --Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        --Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        --Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        --Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    },

        mtriggers = {
                        MapTrigger(73, 20, 1),
                        MapTrigger(73, 21, 1),
                        MapTrigger(73, 22, 1),
                        MapTrigger(73, 23, 1),
                    },
    },
}