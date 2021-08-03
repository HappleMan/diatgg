local diatgg = {}

local http = require('coro-http')
local json = require('json')

local Auth = nil
local Id = nil

function headers()
return({{"Authorization", Auth},{"Content-Type", "application/json"}})
end

function mod.authorize(token,id)
Auth = token
Id = id
end

function mod.searchBots(search,limit)
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

function mod.findBot(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id,headers())
return(json.parse(body))    
end

function mod.findUser(id)
local res,body = http.request("GET","https://top.gg/api/users/"..id,headers())
return(json.parse(body))    
end

function mod.botVotes(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/votes",headers())
return(json.parse(body))    
end

function mod.botStats(id)
if id == nil or not id then id = Id end
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/stats",headers())
return(json.parse(body))    
end

function mod.voteCheck(userId,id)
if id == nil or not id then id = Id end
local payload = {
userId = userId
}
local res,body = http.request("GET","https://top.gg/api/bots/"..id.."/check",headers(),json.encode(payload))
if json.parse(body).voted == 1 then return(true) else return(false) end 
end

function mod.updateStats(client)
local payload = {
server_count = #client.guilds,
shard_count = client.totalShardCount
}
local res,body = http.request("GET","https://top.gg/api/bots/"..client.id.."/check",headers(),json.encode(payload)) 
end



return diatgg
