-- Name: spawner
-- Process ID: 0y5p_iwQBUkIVk17rsuBglPZINu_3SICDpQIj5bCKQQ

TARGET_WORLD_PID = TARGET_WORLD_PID or "vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8"
local json = require('json')

SpawnedProcesses = SpawnedProcesses or {}

Handlers.add('SayHelloResponse',
    Handlers.utils.hasMatchingTag('Action', 'SayHelloResponse'),
    function(msg)
        print('Got Hello Response: "' .. msg.Data .. '" from: ' .. msg.From)
    end
)

function InitNewProcess(processID)
    ao.send({
        Target = processID,
        Action = "Eval",
        Data = [[
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


    ]]
    })
    print("Added Eval code to new process: " .. processID)

    Send({
        Target = processID,
        Tags = {
            Action = 'SayHello',
        }
    })
end

-- to test -> can just use Spawend Action
-- Handlers.add('InitEvalNewProcess',
--     Handlers.utils.hasMatchingTag('Action', 'InitEvalNewProcess'),
--     function(msg)
--         print('InitEvalNewProcess')
--         local processID = msg.ProcessID
--         InitNewProcess(processID)
--     end
-- )

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

Handlers.add('SpawnNew',
    Handlers.utils.hasMatchingTag('Action', 'SpawnNew'),
    function(msg)
        print('Spawning New Entity')

        ao.spawn("cNlipBptaF9JeFAf4wUmpi43EojNanIBos3EfNrEOWo", { Purpose = "Test" })
        print('Spawned New Process')
    end
)
