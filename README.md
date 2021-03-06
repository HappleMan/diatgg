-Better function outputs coming soon

## diatgg

Diatgg is a really simple top.gg api module for communicating with the top.gg api. 
You first need to input your top.gg authentication token and (optionally) your bot's id. If entered, the id will be automatically added to any requests that require an id. Otherwise, you will have to manually add the id for every request.

```lua
local diatgg = require('diatgg')
diattg.authenticate(token,id) --token can be fount at https://top.gg/bot/:bot_id/webhooks. It is recommended that you submit your id as a string, so it doesn't get simplified.
```

## Current available functions*:

Search bots: 
```lua
diatgg.searchBots(search,limit)--limit is optional, default 50
--Example
diatgg.searchBots("HappleMan's Admin",45)
--returns a table of bots
```

Find a single bot: 
```lua
diatgg.findBot(id)--id is optional if you submitted your bot's id during authentication
--Example
diatgg.findBot("794759245408370729")
--returns a table with a bot's information
```

Find a top.gg user: 
```lua
diatgg.findUser(userId)
--Example
diatgg.findUser("485514940313239562")
--returns a table with a top.gg user's information
```

Show last 1000 votes: 
```lua
diatgg.botVotes(id)--id is optional if you submitted your bot's id during authentication
--Example
diatgg.botVotes("794759245408370729")
--returns up to 1000 current bot votes
```

Show a bot's stats: 
```lua
diatgg.botStats(id)--id is optional if you submitted your bot's id during authentication
--Example
diatgg.botStats("794759245408370729")
--returns a bot's stats, like shards, shard_count, and server_count if available
```

Check if a user has voted: 
```lua
diatgg.voteCheck(userId,id)--id is optional if you submitted your bot's id during authentication
--Example
diatgg.voteCheck("485514940313239562","794759245408370729")
--returns a bool value depending on the user's vote status
```

Update a bot's stats: 
```lua
diatgg.updateStats(discordia client)
--Example
diatgg.updateStats(client)
--returns an error if one exists, otherwise returns the string "{}"
```

Show additional bot stats found on the top.gg bot page but not in the api: 
(this one may or may not work depending on if top.gg has DDoS protection enabled.)
```lua
diatgg.extraInfo(id)--id is optional if you submitted your bot's id during authentication
--Example
diatgg.extraInfo("794759245408370729")
--returns a table, or nil if the information is not available:
{
review_count = number of reviews,
rating = number 0-5,
announcement = {
        title = announcement title,
        body = announcement content
    }
 }
```

*All output is converted into tables. You can see the format of these responses at https://docs.top.gg/api/bot/ or https://docs.top.gg/api/user/
