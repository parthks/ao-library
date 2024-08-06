-- code to be added to when a new process is spawned in Spawner.lua

TARGET_WORLD_PID = TARGET_WORLD_PID or "vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8"
local json = require('json')
Initialized = Initialized or nil

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
                DisplayName = "New Spawned Entity",
                SkinNumber = 1,
            },
            Position = { 2, 2 },
        }),
    })
end

Handlers.add('SayHello',
    Handlers.utils.hasMatchingTag('Action', 'SayHello'),
    function(msg)
        print('Saying Hello. Initialized = ' .. tostring(Initialized))

        if (Initialized == nil) then
            print("Registering as Reality Entity")
            Register()
            Initialized = true
        end

        Send({
            Target = msg.From,
            Tags = {
                Action = 'SayHelloResponse',
            },
            Data =
            "Hello From the Other Side! "
        })
    end
)
