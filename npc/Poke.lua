-- Name: poke-npc
-- Process ID: 7d1iNwXzuhkPgpecVtX83QuJJ57z_QPR87_C5y6wA_U

CHAT_TARGET = CHAT_TARGET or 'vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8'

-- To add this agent to your world, configure your Static Entities table, e.g.:
-- RealityEntitiesStatic = {
--   ['<your agent process Id>'] = {
--     Position = { 10, 10 },
--     Type = 'Avatar',
--     Metadata = {
--       DisplayName = 'Fantasy Llama',
--       SkinNumber = 5,
--       Interaction = {
--         Type = 'Default',
--       },
--     },
--   },
-- }

TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0

-- Limit sending a message to every so often
COOLDOWN_MS = 10000 -- 10 seconds

Handlers.add(
    'DefaultInteraction',
    Handlers.utils.hasMatchingTag('Action', 'DefaultInteraction'),
    function(msg)
        print('DefaultInteraction')
        if ((msg.Timestamp - TIMESTAMP_LAST_MESSAGE_MS) < COOLDOWN_MS) then
            return print("Message on cooldown")
        end

        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Fantasy Llama',
            },
            Data =
            "Poke Poke, wud up! I'm a Fantasy Llama! 🦙🌈🎉",
        })

        TIMESTAMP_LAST_MESSAGE_MS = msg.Timestamp
    end
)
