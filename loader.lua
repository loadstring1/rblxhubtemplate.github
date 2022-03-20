local request = http_request or request or HttpPost or syn.request
local Owner,Rname = "loadstring1","rblxhubtemplate.github"
local MainSystem = loadstring(request({Url = "https://raw.githubusercontent.com/loadstring1/rblxhubtemplate.github/main/UI.lua",Method = "GET"}).Body)
if typeof(MainSystem) == "function" then MainSystem = MainSystem() end
local MainPage,sha = "https://raw.githubusercontent.com/"..Owner.."/"..Rname.."/main/games/",game:GetService("HttpService"):JSONDecode(request({Url = "https://api.github.com/repos/"..Owner.."/"..Rname.."/git/trees/main?recursive=1",Method = "GET"}).Body).tree
for i,v in pairs(sha) do
	if v.path == "games" then
		sha = v.sha
		break
	end
end
local SupportedGames = game:GetService("HttpService"):JSONDecode(request({Url = "https://api.github.com/repos/"..Owner.."/"..Rname.."/git/trees/"..sha,Method = "GET"}).Body).tree
for i,v in pairs(SupportedGames) do
	if tonumber(string.split(v.path,".")[1]) == tonumber(game.PlaceId) or tonumber(string.split(v.path,".")[1]) == tonumber(game.GameId) then
		local loading,source = os.date("*t",os.time()),request({Url = MainPage..v.path,Method = "GET"}).Body
		source = typeof(source) == "string" and loadstring(source) or "Expected string to load hub got "..typeof(source)
		if typeof(source) == "function" then
			source()
		else
			warn("Hub failed to load\nError message: "..tostring(source))
			return
		end
		local endedloading = os.date("*t",os.time())
		warn("\ntemplate hub started loading at "..tostring(loading["hour"])..":"..tostring(loading["min"])..":"..tostring(loading["sec"]).."\ntemplate hub ended loading at "..tostring(endedloading["hour"])..":"..tostring(endedloading["min"])..":"..tostring(endedloading["sec"]))
		return
	end
end
if typeof(MainSystem) == "table" then
	MainSystem.CreateAnnouncement("Template hub wont run in this game because its unsupported",{tween = true,timetoremove = 5})
end
