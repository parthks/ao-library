--#region Model
-- AOS process vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8

RealityInfo = {
    Dimensions = 2,
    Name = 'ExampleReality',
    ['Render-With'] = '2D-Tile-0',
}

RealityParameters = {
    ['2D-Tile-0'] = {
        Version = 0,
        Spawn = { 5, 5 },
        PlayerSpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
        -- This is a tileset themed to Llama Land main island
        Tileset = {
            Type = 'Fixed',
            Format = 'PNG',
            -- TxId = '0CtawtxssYg4jxDgQEThrz-oJqMmR-zIyepfyWgLr4Y', -- TxId of the tileset in PNG format
            TxId = 'h5Bo-Th9DWeYytRK156RctbPceREK53eFzwTiKi0pnE'
        },
        -- This is a tilemap of sample small island
        Tilemap = {
            Type = 'Fixed',
            Format = 'TMJ',
            TxId = 'koH7Xcao-lLr1aXKX4mrcovf37OWPlHW76rPQEwCMMA', -- TxId of the tilemap in TMJ format
            -- Since we are already setting the spawn in the middle, we don't need this
            -- Offset = { -10, -10 },
        },
    },
    ['Audio-0'] = {
        Bgm = {
            Type = 'Fixed',
            Format = 'WEBM',
            TxId = 'k-p6enw-P81m-cwikH3HXFtYB762tnx2aiSSrW137d8',
        }
    }
}

RealityEntitiesStatic = {
    ['7d1iNwXzuhkPgpecVtX83QuJJ57z_QPR87_C5y6wA_U'] = {
        Position = { 8, 10 },
        Type = 'Avatar',
        Metadata = {
            DisplayName = 'Poke Llama',
            SkinNumber = 1,
            Interaction = {
                Type = 'Default',
            },
        },
    },
    ['KEjhGh2JJS3yAhlCIP6zjjx3lR_0-AHU5bc9qmkE5lw'] = {
        Position = { 6, 12 },
        Type = 'Avatar',
        Metadata = {
            DisplayName = 'Guide',
            SkinNumber = 2,
            Interaction = {
                Type = 'SchemaForm',
                Id = "Guide"
            },
        },
    },
    ['Warper'] = {
        Position = { 12, 10 },
        Type = 'Avatar',
        Metadata = {
            SpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
            Interaction = {
                Type = 'Warp',
                Size = { 0.5, 0.5 },
                Position = { 0, 10 },
                Target = "9a_YP6M7iN7b6QUoSvpoV3oe3CqxosyuJnraCucy5ss",
            },
        }
    }
}

--#endregion

return print("Loaded Reality Template")
