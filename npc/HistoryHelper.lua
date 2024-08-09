-- Name: history-npc -- HISTORY HELPER
-- Process ID: h4nv902ZHD6EGVCWfSPf7DD8XdlYuf3lV_5qXtpPYJY

local json = require('json')

COUNT = COUNT or 0
CHAT_TARGET = 'GbjU2E-ZTsYOpvB02ZnPpD1brak6OZyZm-K8JznidoA'


Handlers.add(
    'Schema',
    Handlers.utils.hasMatchingTag('Action', 'Schema'),
    function(msg)
        print('Schema')
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode({
                Historian = {
                    Title = 'Welcome to the History Section',
                    Description =
                    'Approach this bookshelf to browse the Public Domain History Books, from the Alex Archives.',
                    Schema = {
                        -- Tags = json.decode(GetSchemaTags()),
                        -- Data
                        -- Result?
                    },
                },
            })
        })
    end
)
