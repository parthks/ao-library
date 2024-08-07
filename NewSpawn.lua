TARGET_WORLD_PID = TARGET_WORLD_PID or "vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8"
local json = require('json')
Initialized = nil -- Can always re-register entity

Position = Position or { 4, 2 }
Count = Count or 0

function Register()
    print("Registering as Reality Entity")
    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
            Action = "Reality.EntityCreate",
        },
        Data = json.encode({
            Type = "Avatar",
            Metadata = {
                DisplayName = ao.env.Process.Tags.TxnName or "Spawn Child",
                SkinNumber = 1,
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
                (ao.env.Process.Tags.TxnDataID or ao.env.Process.Tags.TxnID or "") ..
                " and has been summoned " .. Count .. " times",
            Schema = nil
        }
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode(dataToEncode),
        })
    end
)
