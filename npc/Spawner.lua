-- Name: spawner
-- Process ID: 0y5p_iwQBUkIVk17rsuBglPZINu_3SICDpQIj5bCKQQ

-- have an agent spawn a new process for a transaction
-- TARGET_WORLD_PID = TARGET_WORLD_PID or "vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8"
local json = require('json')

SpawnedProcesses = SpawnedProcesses or {}

-- call assign to this process with an alex history book transaction id

function InitNewProcess(processID)
    print("Addding Eval code to new process: " .. processID)
    ao.send({
        Target = processID,
        Action = "Eval", -- TARGET_WORLD_PID of new spawn set to History Books
        Data = [[
            TARGET_WORLD_PID = TARGET_WORLD_PID or "ZUCMT6EZGUqnUQ7Xdxp_bozlsQ_JNk-Fq_f8XLP-iq0"
local json = require('json')
Initialized = nil -- Can always re-register entity

Position = { 11, 23 }
Count = Count or 0

function Register()
    print("Registering as Reality Entity")
    local txnName = ao.env.Process.Tags.TxnName or "Spawn Child"
    local name = #txnName > 12 and string.sub(txnName, 1, 12) .. "..." or txnName

    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
            Action = "Reality.EntityCreate",
        },
        Data = json.encode({
            Type = "Avatar",
            SpriteTxId = 'gGzwitPXKg_Z-jBAwzzpYt947TCmZin9o7-d6LYgClA',
            Metadata = {
                SpriteTxId = 'gGzwitPXKg_Z-jBAwzzpYt947TCmZin9o7-d6LYgClA',
                DisplayName = name,
                Interaction = {
                    Type = 'SchemaForm',
                    Id = 'Something Mysterious'
                },
            },
            Position = Position,
        }),
    })
    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
          Action = 'Reality.EntityFix',
        },
      })
end


if (Initialized == nil) then
    print("Registering as Reality Entity")
    Register() -- Can register multiple times, no problem
    Initialized = true
end

Handlers.add('UpdatePosition',
    Handlers.utils.hasMatchingTag('Action', 'UpdatePosition'),
    function(msg)
        TargetPosition = msg.Data.Position

        Send({
            Target = TARGET_WORLD_PID,
            Tags = {
                Action = "Reality.EntityUpdatePosition",
            },
            Data = json.encode({
                Position = TargetPosition,
            }),
        })
        Position = TargetPosition
    end
)

Handlers.add(
    'Schema',
    Handlers.utils.hasMatchingTag('Action', 'Schema'),
    function(msg)
        print('Schema')
        Count = Count + 1
        local dataToEncode = {}
        dataToEncode["Something Mysterious"] = {
                Title = 'Explore The Permaweb',
                Description = (ao.env.Process.Tags.TxnName or "Unknown") ..
                    " can be found at https://arweave.net/" ..
                    (ao.env.Process.Tags.TxnDataID or ao.env.Process.Tags.TxnID or "") .. " and has been summoned " .. Count .. " times",
                Schema = nil
        }
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode(dataToEncode),
        })
    end
)

    ]]
    })
    print("Added Eval code to new process: " .. processID)
end

-- Way to send a message to a spawned process
-- Send({ Target = ao.id, Data = { Position = { 7, 23 } }, Action = "SendToSwpanedProcess", Process = "emtEpdbSDViPdamE7gHqSnd4Q-S5I2Nt5XTj67jA0UY", Tags = {["X-Action"] = "UpdatePosition"} })
Handlers.add('SendToSwpanedProcess',
    Handlers.utils.hasMatchingTag('Action', 'SendToSwpanedProcess'),
    function(msg)
        local processID = msg.Process
        -- Create a new Tags table
        local newTags = {}

        -- Copy all tags from msg.Tags to newTags, except 'X-Action'
        for key, value in pairs(msg.Tags) do
            if key ~= 'X-Action' then
                newTags[key] = value
            end
        end

        -- Set the Action tag
        newTags['Action'] = msg.Tags['X-Action']

        print('Sending to Spawned Process: ' .. processID)
        print('Tags: ' .. json.encode(newTags))

        ao.send({
            Target = processID,
            Tags = newTags,
            Data = json.encode(msg.Data)
        })
    end
)

-- Send({Target = ao.id, Action = 'Spawned', Process = "uFu20nSeYmPJksCuf-w3kU17CcUiR2y3yEuJVQjBluE"})
--
-- Initialize a new process. This is called when a new process is spawned.
Handlers.add('Spawned',
    Handlers.utils.hasMatchingTag('Action', 'Spawned'),
    function(msg)
        local processId = msg.Process
        print('Successfully Spawned New Process: ' .. processId)
        InitNewProcess(processId)
        SpawnedProcesses[processId] = {
            ID = processId,
            Timestamp = msg.Timestamp,
        }
    end
)

-- Test to spawn a new process
Handlers.add('SpawnNew',
    Handlers.utils.hasMatchingTag('Action', 'SpawnNew'),
    function(msg)
        print('Spawning New Entity')

        ao.spawn("cNlipBptaF9JeFAf4wUmpi43EojNanIBos3EfNrEOWo", { Purpose = "Test" })
        print('Spawned New Process')
    end
)

-- Gets called when an Arweave transaction is assigned to the process. Starts a new process with the transaction data
-- TRIGGER - Assign({Processes = {ao.id}, Message="4nND47K3RGbZsPkNWH-Rzijhv5inEpwlQD5wIMwiNfw"})
Handlers.add("GetTxn",
    function(msg)
        return msg.Signature ~= nil and
            msg.Process == nil
        -- how to identify a transaction sent to the Inbox?
    end,
    function(msg)
        print("GetTxn" .. json.encode(msg))
        local fileData = msg.Data
        local fileTxn = msg.Id
        local Title = msg.Title or "Txn Data"
        local ContentType = msg["Content-Type"] or "unknown"
        if (msg["Content-Type"] == 'application/json') then
            if (fileData.fileTxId ~= nil) then
                fileTxn = fileData.fileTxId
            end
        end

        -- [string ".handlers"]:345: [string "aos"]:128: attempt to concatenate a table value (local 'Tags')
        local Tags = msg.Tags

        print("Tags: " .. json.encode(Tags))
        print("\nfileTxn: " .. fileTxn)
        print("Title: " .. Title)
        print("ContentType: " .. ContentType)
        print("From: " .. msg.From)
        print("ID: " .. msg.Id)

        print('\nSpawning New Entity')
        ao.spawn("cNlipBptaF9JeFAf4wUmpi43EojNanIBos3EfNrEOWo", {
            Purpose = "Test",
            TxnTags = json.encode(Tags),
            TxnDataID = fileTxn,
            TxnID = msg.Id,
            TxnOwner = msg.From,
            TxnContentType = ContentType,
            TxnName = Title,
        })
        print('Spawned New Process')
    end
)
