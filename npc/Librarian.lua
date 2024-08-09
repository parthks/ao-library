-- Name: hello-npc -- LIBRARIAN
-- Process ID: KEjhGh2JJS3yAhlCIP6zjjx3lR_0-AHU5bc9qmkE5lw

local json = require('json')

COUNT = COUNT or 0
CHAT_TARGET = 'GbjU2E-ZTsYOpvB02ZnPpD1brak6OZyZm-K8JznidoA'

SEARCH_QUERIES = SEARCH_QUERIES or {}


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
                "const": "SendSearchQuery"
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

Handlers.add('SendSearchQuery',
    Handlers.utils.hasMatchingTag('Action', 'SendSearchQuery'),
    function(msg)
        print('SendSearchQuery')
        local contentType = msg.ContentType
        local owner = msg.FileOwner
        local maxSize = msg.MaxSize

        COUNT = COUNT + 1

        local message = "Your search of items of type " .. contentType
        if owner then
            message = message .. " with owner " .. owner
        end
        if maxSize then
            message = message .. " and with max size " .. maxSize .. " bytes"
        end
        message = message ..
            " is important to us. Don't forget to check out the History section on the right side of the library"

        -- add to search queries
        table.insert(SEARCH_QUERIES, {
            ContentType = contentType,
            FileOwner = owner,
            MaxSize = maxSize,
        })

        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Librarian',
            },
            Data =
                "Sorry we are still indexing the Permaweb and cannot currently satisfy your request. " .. message,
        })
    end
)

Handlers.add(
    'Schema',
    Handlers.utils.hasMatchingTag('Action', 'Schema'),
    function(msg)
        print('Schema')
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode({
                Librarian = {
                    Title = 'Welcome to the Great Library of Arweave',
                    Description =
                        'Allow me to assist you in your search for knowledge. ' ..
                        'I have been summoned for help ' .. COUNT .. ' times.',
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
