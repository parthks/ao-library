-- Name: hello-npc
-- Process ID: KEjhGh2JJS3yAhlCIP6zjjx3lR_0-AHU5bc9qmkE5lw

local json = require('json')

count = count or 0
CHAT_TARGET = CHAT_TARGET or 'vKbkWePtJIXSRKYWU1iaqMQKbHH43E3QblpN9NR8GV8'


-- Note: when an integer field has a comment property, it is used to multiply the value before sending it. This is useful for for converting from whole token amounts to the base unit quantity (e.g. wrapped Winston to wrapped Arweave).
function GetSchemaTags()
    return [[
    {
        "type": "object",
        "required": [
            "Action",
            "ContentType",
        ],
    "properties": {
            "Action": {
                "type": "string",
                "const": "SendChatCount"
            },
            "ContentType": {
                "title": "Content Type",
                "type": "string",
                "value": "image",
                "enum": ["image", "video", "pdf"]
              },
              "FileOwner": {
                "title": "Owner of the file",
                "description": "Filter by the owner of the file.",
                "type": "string",
                "maxLength": 140
              },
              "MaxSize": {
                "title": "Max Size (in MB)",
                "description": "Max MB for the file.",
                "type": "integer",
                "minimum": 0,
                "maximum": 100,
                "$comment": "1000000"
              }
        }
    }
  ]]
end

Handlers.add('SendChatCount',
    Handlers.utils.hasMatchingTag('Action', 'SendChatCount'),
    function(msg)
        print('SendChatCount')
        local contentType = msg.ContentType
        local owner = msg.FileOwner
        local maxSize = msg.MaxSize

        local message = "Finding items of type " .. contentType
        if owner then
            message = message .. " with owner " .. owner
        end
        if maxSize then
            message = message .. "and with max size " .. maxSize .. " bytes"
        end

        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Hello NPC',
            },
            Data =
                "Hello! I am Marky The Guide. I have been requeted " .. count .. " times. " .. message,
        })
    end
)

Handlers.add(
    'Schema',
    Handlers.utils.hasMatchingTag('Action', 'Schema'),
    function(msg)
        print('Schema')
        count = count + 1
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode({
                Guide = {
                    Title = 'Welcome Adventurer!!',
                    Description =
                        '## I am Marky https://www.google.com The Guide.  \n                    # Hello Friend!\n\n\n\tI have been *summoned* ' ..
                        count .. " times",
                    Schema = {
                        Tags = json.decode(GetSchemaTags()),
                        -- Data
                        -- Result?
                    },
                },
            })
        })
    end
)
