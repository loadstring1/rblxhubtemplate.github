Template is done but UI lib isnt done fully

Run this in your executor to load the hub:

use the loader in releases

or

local request = http_request or request or HttpPost or syn.request
loadstring(request({Url = "https://raw.githubusercontent.com/loadstring1/rblxhubtemplate.github/main/loader.lua",Method = "GET"}).Body)()
