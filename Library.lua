--#region Model
-- GbjU2E-ZTsYOpvB02ZnPpD1brak6OZyZm-K8JznidoA

RealityInfo = {
    Dimensions = 2,
    Name = 'TheGreatLibraryIndoors',
    ['Render-With'] = '2D-Tile-0',
}

RealityParameters = {
    ['2D-Tile-0'] = {
        Version = 0,
        Spawn = { 25, 47 },
        PlayerSpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
        -- This is a tileset themed to Llama Land main island
        Tileset = {
            Type = 'Fixed',
            Format = 'PNG',
            -- TxId = '0CtawtxssYg4jxDgQEThrz-oJqMmR-zIyepfyWgLr4Y', -- TxId of the tileset in PNG format
            TxId = 'Yi4XhlxBvlqzdPSrcOhwjTA4w7cHy43pHfyMXJ9rAAc'
        },
        -- This is a tilemap of sample small island
        Tilemap = {
            Type = 'Fixed',
            Format = 'TMJ',
            -- TxId = 'hA93lRyitpr-g6_axzR-BHUNZxyu057ZLYuPNIHfwYY', -- TxId of the tilemap in TMJ format
            -- TxId = 'fwOdtuWzyNVT4h54NSBdLOaoIdWkjODyEvDbJaBjR60', -- TxId of the tilemap in TMJ format
            TxId = 'V9I67tEVLu5pI4GZgjw9h5YNOH8RENV5W2P0KeqWAhg', -- TxId of the tilemap in TMJ format
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
--#endregion


RealityEntitiesStatic = {
    -- ['7d1iNwXzuhkPgpecVtX83QuJJ57z_QPR87_C5y6wA_U'] = {
    --     Position = { 8, 10 },
    --     Type = 'Avatar',
    --     Metadata = {
    --         DisplayName = 'Poke Llama',
    --         SkinNumber = 1,
    --         Interaction = {
    --             Type = 'Default',
    --         },
    --     },
    -- },
    ['KEjhGh2JJS3yAhlCIP6zjjx3lR_0-AHU5bc9qmkE5lw'] = {
        Position = { 25, 21 },
        Type = 'Avatar',
        Metadata = {
            DisplayName = 'Librarian',
            SkinNumber = 2,
            Interaction = {
                Type = 'SchemaForm',
                Id = "Librarian"
            },
        },
    },
    ['h4nv902ZHD6EGVCWfSPf7DD8XdlYuf3lV_5qXtpPYJY'] = {
        Position = { 44, 30 },
        Type = 'Avatar',
        Metadata = {
            DisplayName = 'Historian',
            SkinNumber = 2,
            Interaction = {
                Type = 'SchemaForm',
                Id = "Historian"
            },
        },
    },
    ['WarpToHistory'] = {
        Position = { 45, 33 },
        Type = 'Hidden',
        Metadata = {
            -- SpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
            -- SpriteTxId = 'jXfJFUiFG4ojMg9YIgvxTefcvntW2GiBWw4kaow8poo',
            -- SpriteTxId = 'gGzwitPXKg_Z-jBAwzzpYt947TCmZin9o7-d6LYgClA',
            Interaction = {
                Type = 'Warp',
                Size = { 1, 3 },
                -- Position = { 44, 33 },
                Target = "ZUCMT6EZGUqnUQ7Xdxp_bozlsQ_JNk-Fq_f8XLP-iq0",
            },
        }
    },
    ['WarpToOutdoor'] = {
        Position = { 24.5, 48.5 },
        Type = 'Hidden',
        Metadata = {
            -- SpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
            -- SpriteTxId = 'jXfJFUiFG4ojMg9YIgvxTefcvntW2GiBWw4kaow8poo',
            -- SpriteTxId = 'gGzwitPXKg_Z-jBAwzzpYt947TCmZin9o7-d6LYgClA',
            Interaction = {
                Type = 'Warp',
                Size = { 6, 1 },
                Position = { 25, 22 },
                Target = "7eP1aoGS60M1fT9GEcUzcsW6OliCnZaAzfsWAJ5Qk6Q",
            },
        }
    }
}

--#endregion

return print("Loaded Reality Template")
