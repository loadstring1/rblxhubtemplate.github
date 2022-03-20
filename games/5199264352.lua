local request = http_request or request or HttpPost or syn.request
local MainSystem = loadstring(request({Url = "https://raw.githubusercontent.com/loadstring1/rblxhubtemplate.github/main/UI.lua",Method = "GET"}).Body)
if typeof(MainSystem) == "function" then MainSystem = MainSystem() end
local lib = MainSystem:CreateUIlib()
lib:CreateUI()
lib:ParentAndProtectUI(nil,true)
task.wait(0.6)
lib:DestroyUI()
