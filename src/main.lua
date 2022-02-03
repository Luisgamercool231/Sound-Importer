--[[
  By: luisgamercooI231fan, 
  Time: Wed Feb  2 12:20:06 2022 ,
  Description: core for sound importer,
 ]]--
 local StudioService = game:GetService("StudioService")
local Toolbar = plugin:CreateToolbar("Sound importer")
local Selection = game:GetService("Selection")
local ImportButton = Toolbar:CreateButton("Import", "button for importing sounds.", "rbxassetid://7173469118")
local FileWhitelist = {"mp3", "ogg"}
local Mouse:PluginMouse = plugin:GetMouse()
local Camera = workspace.CurrentCamera
local function PositiveIntegerMask(text)
	return text:gsub("[^%-%d]", "")
end
local function Imported(SoundName)
	local Ui = script.Notifier:Clone()

	Ui.TextLabel.Text = string.format("Added %q", SoundName)
	Ui.Parent = game:GetService("CoreGui")
	Ui.TextLabel:TweenPosition(Ui.TextLabel:GetAttribute("Origin"), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	task.wait(2.4)
	Ui.TextLabel:TweenPosition(Ui.TextLabel:GetAttribute("End"), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
end
ImportButton.Click:Connect(function()
	local Selected:File = StudioService:PromptImportFile(FileWhitelist)
	if Selected ~= nil then
		local TempId:string = Selected:GetTemporaryId()
		local Sound = Instance.new("Sound")
		Sound.Name = Selected.Name
		Sound.SoundId = TempId
		local Hit =  Selection:Get()[1]
		if Hit ~= nil then
			Selection:Set({Sound})
			Sound.Parent = Hit
			Imported(Selected.Name)
		else
			Selection:Set({Sound})
			Sound.Parent = workspace
			Imported(Selected.Name)
		end
		
	end
	

	
end)
