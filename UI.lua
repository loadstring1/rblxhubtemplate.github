local module = {}
function module.RandomName(a,descendants)
	if typeof(a) == "Instance" then
		a.Name = module.RandomName()
		if descendants == true then
			for i,v in pairs(a:GetDescendants()) do
				v.Name = module.RandomName()
			end
		end
		return
	end
	local str = [[]]
	for i = 1,10 do
		str = str..string.char(math.random(1,128))..tostring(math.random())..tostring(math.rad(math.random()))
	end
	return str
end
function module.ProtectGui(gui)
	if typeof(gui) ~= "Instance" then return end
	if gethui or get_hidden_gui then
		gui.Parent = (gethui or get_hidden_gui)()
	elseif syn and syn.protect_gui then
		syn.protect_gui(gui)
		gui.Parent = game:GetService("CoreGui")
	else
		gui.Parent = game:GetService("CoreGui")
	end
end
function module:CreateUILib()
	local lib = {}
	local MainUIElements = {}
	function lib:CreateUI()
		if MainUIElements.GUI then return "UI already exists" end
		MainUIElements["GUI"] = Instance.new("ScreenGui")
		MainUIElements["Main"] = Instance.new("Frame")
		MainUIElements["UIGradient"] = Instance.new("UIGradient")
		MainUIElements["GUI"].ResetOnSpawn = false
		MainUIElements["GUI"].Archivable = true
		MainUIElements["GUI"].Name = "GUI"
		MainUIElements["GUI"].IgnoreGuiInset = true
		MainUIElements["GUI"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		MainUIElements["Main"].Archivable = true
		MainUIElements["Main"].Name = "Main"
		MainUIElements["Main"].Parent = MainUIElements["GUI"]
		MainUIElements["Main"].ZIndex = 1
		MainUIElements["Main"].AutomaticSize = Enum.AutomaticSize.None
		MainUIElements["Main"].Size = UDim2.new(0, 540,0, 336)
		MainUIElements["Main"].BorderColor3 = Color3.fromRGB(27.000002190470695,42.000001296401024,53.000004440546036)
		MainUIElements["Main"].Position = UDim2.new(0.329337537, 0,0.293251514, 0)
		MainUIElements["Main"].BorderSizePixel = 0
		MainUIElements["Main"].BackgroundColor3 = Color3.fromRGB(255,255,255)
		MainUIElements["UIGradient"].Archivable = true
		MainUIElements["UIGradient"].Name = "UIGradient"
		MainUIElements["UIGradient"].Parent = MainUIElements["Main"]
		MainUIElements["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(33.00000183284283,21.000000648200512,62.00000010430813)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(82.00000271201134,53.00000064074993,149.00000631809235))}
		return MainUIElements
	end
	function lib:GetUI()
		return MainUIElements
	end
	function lib:ParentAndProtectUI(a,shouldrenameeverything)
		module.ProtectGui(MainUIElements.GUI)
		if shouldrenameeverything == true then module.RandomName(MainUIElements.GUI,true) end
		if typeof(a) == "Instance" then MainUIElements.GUI.Parent = a end
	end
	function lib:DestroyUI(fakeout)
		for i,v in pairs(MainUIElements) do
			game:GetService("Debris"):AddItem(v,0)
			v:Destroy()
			if fakeout == true then MainUIElements[i] = Instance.new(v.ClassName) end
		end
		if fakeout ~= true then table.clear(MainUIElements) end
	end
	return lib
end
function module.CreateAnnouncement(message,config)
	if typeof(message) ~= "string" or typeof(config) ~= "table" then return end
	--bgtl (better gui to lua) made by "Cozapierdolonychuj" on roblox
	local MainUIElements = {}
	MainUIElements["GUI"] = Instance.new("ScreenGui")
	MainUIElements["announcement"] = Instance.new("TextLabel")
	MainUIElements["UIGradient"] = Instance.new("UIGradient")
	MainUIElements.GUI.IgnoreGuiInset = true
	MainUIElements.GUI.ResetOnSpawn = false
	MainUIElements["announcement"].Archivable = true
	MainUIElements["announcement"].Name = "announcement"
	MainUIElements["announcement"].TextWrapped = true
	MainUIElements["announcement"].ZIndex = 1
	MainUIElements["announcement"].AutomaticSize = Enum.AutomaticSize.None
	MainUIElements["announcement"].Size = UDim2.new(1, 0,-0.00613496918, 50)
	MainUIElements["announcement"].TextSize = 14
	MainUIElements["announcement"].RichText = true
	MainUIElements["announcement"].BorderColor3 = Color3.fromRGB(149.00000631809235,88.00000235438347,161.0000056028366)
	MainUIElements["announcement"].TextColor3 = Color3.fromRGB(255,255,255)
	MainUIElements["announcement"].Font = Enum.Font.SourceSans
	MainUIElements["announcement"].Position = UDim2.new(0, 0,0.472392619, 0)
	MainUIElements["announcement"].TextScaled = true
	MainUIElements["announcement"].BackgroundColor3 = Color3.fromRGB(100.00000163912773,87.00000241398811,103.0000014603138)
	MainUIElements["announcement"].Text = "<b>"..message.."<b>"
	MainUIElements["UIGradient"].Archivable = true
	MainUIElements["UIGradient"].Name = "UIGradient"
	MainUIElements["UIGradient"].Parent = MainUIElements["announcement"]
	MainUIElements["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100.00000163912773,87.00000241398811,103.0000014603138)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(149.00000631809235,88.00000235438347,161.0000056028366))}
	MainUIElements.announcement.Parent = MainUIElements.GUI
	module.RandomName(MainUIElements.GUI,true)
	if config.tween == true then
		MainUIElements.announcement.BackgroundTransparency = 1
		MainUIElements.announcement.TextTransparency = 1
		task.spawn(function()
			repeat task.wait() until MainUIElements.GUI.Parent
			game:GetService("TweenService"):Create(MainUIElements.announcement,TweenInfo.new(1),{BackgroundTransparency = 0,TextTransparency = 0}):Play()
			if typeof(config.timetoremove) == "number" then
				task.wait(config.timetoremove - 1)
				game:GetService("TweenService"):Create(MainUIElements.announcement,TweenInfo.new(1),{BackgroundTransparency = 1,TextTransparency = 1}):Play()
			end
		end)
	end
	module.ProtectGui(MainUIElements.GUI)
	if typeof(config.timetoremove) == "number" then game:GetService("Debris"):AddItem(MainUIElements.GUI,config.timetoremove) end
	return MainUIElements
end
return module
