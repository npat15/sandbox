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
        filename = 'maps/spawn1.lua',
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
                        MapTrigger(72, 27, 1),
                        MapTrigger(72, 28, 1),
                        MapTrigger(72, 29, 1),
                        MapTrigger(72, 30, 1),
                        MapTrigger(72, 31, 1),
                        MapTrigger(72, 32, 1),
                        MapTrigger(72, 33, 1),
                        MapTrigger(72, 34, 1),
                        MapTrigger(72, 35, 1),
                        MapTrigger(72, 36, 1),
                    },
    },
}