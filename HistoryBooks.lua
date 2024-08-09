-- AOS process  ZUCMT6EZGUqnUQ7Xdxp_bozlsQ_JNk-Fq_f8XLP-iq0

RealityInfo = {
    Dimensions = 2,
    Name = 'HistoryBooks',
    ['Render-With'] = '2D-Tile-0',
}

RealityParameters = {
    ['2D-Tile-0'] = {
        Version = 0,
        Spawn = { 17, 27 },
        PlayerSpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
        -- This is a tileset themed to Llama Land main island
        Tileset = {
            Type = 'Fixed',
            Format = 'PNG',
            -- TxId = 'h5Bo-Th9DWeYytRK156RctbPceREK53eFzwTiKi0pnE'
            TxId = 'Yi4XhlxBvlqzdPSrcOhwjTA4w7cHy43pHfyMXJ9rAAc'

        },
        -- This is a tilemap of sample small island
        Tilemap = {
            Type = 'Fixed',
            Format = 'TMJ',
            TxId = 'Phi5qnupxXgUoQsJPczWLTAKvMNJlYEkzoURi7y2aXQ', -- TxId of the tilemap in TMJ format
            -- TxId = 'YgpoIN2sR3itR35O0kny99kMkTxxieYdDX-sB3eznp8'
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
    ['WarpToLibrary'] = {
        Position = { 14.5, 29 },
        Type = 'Hidden',
        Metadata = {
            -- SpriteTxId = '0WFjH89wzK8XAA1aLPzBBEUQ1uKpQe9Oz_pj8x1Wxpc',
            -- SpriteTxId = 'jXfJFUiFG4ojMg9YIgvxTefcvntW2GiBWw4kaow8poo',
            -- SpriteTxId = 'gGzwitPXKg_Z-jBAwzzpYt947TCmZin9o7-d6LYgClA',
            Interaction = {
                Type = 'Warp',
                Size = { 1, 1 },
                Position = { 44, 33 },
                Target = "GbjU2E-ZTsYOpvB02ZnPpD1brak6OZyZm-K8JznidoA",
            },
        }
    }
}
