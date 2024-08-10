-- Name: hello-npc -- LIBRARIAN
-- Process ID: KEjhGh2JJS3yAhlCIP6zjjx3lR_0-AHU5bc9qmkE5lw

local json = require('json')

COUNT = COUNT or 0
CHAT_TARGET = 'GbjU2E-ZTsYOpvB02ZnPpD1brak6OZyZm-K8JznidoA'

SEARCH_QUERIES = SEARCH_QUERIES or {}


_0RBIT = "BaMK1dfayo75s3q1ow6AO64UDpD9SEFbeE8xYrY2fyQ"
_0RBT_TOKEN = "BUhZLMwQ6yZHguLtJYA5lLUa9LQzLXMXRfaq9FVcPJc"

FEE_AMOUNT = "1000000000000" -- 1 $0RBT
-- BASE_URL = "https://g8way.0rbit.co/graphql"
BASE_URL = "https://permagate.io/graphql"
-- The data body to be sent in the POST request

Latest0rbitResopnse = nil -- for testing


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
                "enum": ["image/png", "video/mp4", "application/pdf", "application/epub+zip"]
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
            " has been initiated!"

        BODY = json.encode({
            query = [[
                        query {
                            transactions(
                                first: 5,
                                tags: {
                                    name: "Content-Type",
                                    values: ["]] .. contentType .. [["]
                                }
                            ) {
                                edges {
                                    node {
                                        id
                                        owner {
                                            address
                                        }
                                        data {
                                            size
                                            type
                                        }
                                        tags {
                                            name
                                            value
                                        }
                                    }
                                }
                            }
                        }
                    ]]
        });

        -- add to search queries
        table.insert(SEARCH_QUERIES, {
            ContentType = contentType,
            FileOwner = owner,
            MaxSize = maxSize,
        })

        Send({
            Target = _0RBT_TOKEN,
            Action = "Transfer",
            Recipient = _0RBIT,
            Quantity = FEE_AMOUNT,
            ["X-Url"] = BASE_URL,
            ["X-Action"] = "Post-Real-Data",
            ["X-Body"] = BODY
        })
        print(Colors.green .. "POST Request sent to the 0rbit process.")

        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Librarian',
            },
            Data = message,
        })
    end
)

Handlers.add(
    "Receive-Data",
    Handlers.utils.hasMatchingTag("Action", "Receive-Response"),
    function(msg)
        local res = json.decode(msg.Data)
        -- local res = msg.Data
        print(Colors.green .. "You have received the data from the 0rbit process.")

        Latest0rbitResopnse = res

        if res.errors then
            print(Colors.red .. "Error: " .. res.errors[1].message)
            message = "An error occurred while fetching the data from the permaweb." .. res.errors[1].message
            Send({
                Target = CHAT_TARGET,
                Tags = {
                    Action = 'ChatMessage',
                    ['Author-Name'] = 'Librarian',
                },
                Data = message,
            })
            return
        end

        if res.data == nil or res.data.transactions == nil then
            print(Colors.red .. "Error: No data received")
            message = "An error occurred while fetching the data from the permaweb. No data received."
            message = message .. json.encode(res)
            Send({
                Target = CHAT_TARGET,
                Tags = {
                    Action = 'ChatMessage',
                    ['Author-Name'] = 'Librarian',
                },
                Data = message,
            })
            return
        end

        local transactions = res.data.transactions.edges
        local message = "Have received your data from the permaweb!"
        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Librarian',
            },
            Data = message,
        })

        for _, edge in ipairs(transactions) do
            local node = edge.node
            message = "ID: " .. node.id .. "\n" ..
                "Owner: " .. node.owner.address .. "\n" ..
                "Size: " .. node.data.size .. " bytes\n" ..
                "Type: " .. node.data.type .. "\n"
            Send({
                Target = CHAT_TARGET,
                Tags = {
                    Action = 'ChatMessage',
                    ['Author-Name'] = 'Librarian',
                },
                Data = message,
            })
        end
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
