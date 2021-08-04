local diatgg = {}

local http = require('coro-http')
local json = require('json')

local Auth = nil
local Id = nil

function headers()
return({{"Authorization", Auth},{"Content-Type", "application/json"}})
end

function string.split(self, pat)

    -- Table to store substrings --
    local subs = {}

    -- For every word --
    while true do

        -- Get index of substring (div) --
        local findx, lindx = self:find(pat)

        -- Store last substring --
        if not findx then

            subs[#subs + 1] = self
            break
        end

        -- Store the substring before (div) --
        subs[#subs + 1], self = self:sub(1, findx - 1), self:sub(lindx + 1)
    end
    return subs
end

function diatgg.authorize(token,id)
Auth = token
Id = id
end

function diatgg.searchBots(search,limit)
if limit == nil or not limit then limit = 50 end
local payload = {
limit = limit,
search = search,
    }
search = string.gsub(search," ","%%20")
search = string.gsub(search,"'","%%27")
local res,body = http.request("GET","https://top.gg/api/search?q="..search,headers(),json.encode(payload))
return(json.parse(body.results))    
end

function diatgg.findBot(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id,headers())
return(json.parse(body))    
end

function diatgg.findUser(id)
local res,body = http.request("GET","https://top.gg/api/users/"..id,headers())
return(json.parse(body))    
end

function diatgg.botVotes(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/votes",headers())
return(json.parse(body))    
end

function diatgg.botStats(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/stats",headers())
return(json.parse(body))    
end

function diatgg.voteCheck(userId,id)
if id == nil or not id then id = Id end
local payload = {
userId = userId
}
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/check",headers(),json.encode(payload))
if json.parse(body).voted == 1 then return(true) else return(false) end 
end

function diatgg.updateStats(client)
local payload = {
server_count = #client.guilds,
shard_count = client.totalShardCount
}
local res,body = http.request("GET","https://top.gg/api/bots/"..client.id.."/check",headers(),json.encode(payload)) 
end

function diatgg.extraInfo(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/bot/"..id)
body = json.parse('{"props":'..string.split(string.gsub(body,"</script></body></html>",""),'{"props":')[2])
local data = {
review_count = body.props.pageProps.botData.reviewStats.reviewCount,
rating = body.props.pageProps.botData.reviewStats.averageScore/20,
announcement = {
        title = body.props.pageProps.botData.announcement.title,
        body = body.props.pageProps.botData.announcement.content
    }
 }
return(data)
end

return diatgg
