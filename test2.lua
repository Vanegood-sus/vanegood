--[[
Rayfield Interface Suite
by Sirius (Fixed & Complete Version)
]]

local Release = "Beta 8"
local NotificationDuration = 6.5
local RayfieldFolder = "Rayfield"
local ConfigurationFolder = RayfieldFolder.."/Configurations"
local ConfigurationExtension = ".rfld"

local RayfieldLibrary = {
	Flags = {},
	Theme = {
		Default = {
			TextFont = "Default",
			TextColor = Color3.fromRGB(240, 240, 240),
			Background = Color3.fromRGB(25, 25, 25),
			Topbar = Color3.fromRGB(34, 34, 34),
			Shadow = Color3.fromRGB(20, 20, 20),
			NotificationBackground = Color3.fromRGB(20, 20, 20),
			NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
			TabBackground = Color3.fromRGB(80, 80, 80),
			TabStroke = Color3.fromRGB(85, 85, 85),
			TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
			TabTextColor = Color3.fromRGB(240, 240, 240),
			SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
			ElementBackground = Color3.fromRGB(35, 35, 35),
			ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
			SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
			ElementStroke = Color3.fromRGB(50, 50, 50),
			SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
			SliderBackground = Color3.fromRGB(43, 105, 159),
			SliderProgress = Color3.fromRGB(43, 105, 159),
			SliderStroke = Color3.fromRGB(48, 119, 177),
			ToggleBackground = Color3.fromRGB(30, 30, 30),
			ToggleEnabled = Color3.fromRGB(0, 146, 214),
			ToggleDisabled = Color3.fromRGB(100, 100, 100),
			ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
			ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
			ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
			ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),
			InputBackground = Color3.fromRGB(30, 30, 30),
			InputStroke = Color3.fromRGB(65, 65, 65),
			PlaceholderColor = Color3.fromRGB(178, 178, 178)
		}
	}
}

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Interface Management
local Rayfield = game:GetObjects("rbxassetid://10804731440")[1]
Rayfield.Enabled = false

if gethui then
	Rayfield.Parent = gethui()
elseif syn and syn.protect_gui then 
	syn.protect_gui(Rayfield)
	Rayfield.Parent = CoreGui
elseif CoreGui:FindFirstChild("RobloxGui") then
	Rayfield.Parent = CoreGui:FindFirstChild("RobloxGui")
else
	Rayfield.Parent = CoreGui
end

local Main = Rayfield.Main
local Topbar = Main.Topbar
local Elements = Main.Elements
local LoadingFrame = Main.LoadingFrame
local TabList = Main.TabList

Rayfield.DisplayOrder = 100
LoadingFrame.Version.Text = Release

local request = (syn and syn.request) or (http and http.request) or http_request
local CFileName = nil
local CEnabled = false
local Minimised = false
local Hidden = false
local Debounce = false
local Notifications = Rayfield.Notifications
local SelectedTheme = RayfieldLibrary.Theme.Default

local function AddDraggingFunctionality(DragPoint, MainObj)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos
		DragPoint.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				MousePos = Input.Position
				FramePos = MainObj.Position
				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then Dragging = false end
				end)
			end
		end)
		DragPoint.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then DragInput = Input end
		end)
		UserInputService.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				TweenService:Create(MainObj, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
			end
		end)
	end)
end

local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    

local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end

function RayfieldLibrary:SaveConfiguration()
	if not CEnabled or not CFileName then return end
	local Data = {}
	for i, v in pairs(RayfieldLibrary.Flags) do
		if v.Type == "ColorPicker" then
			Data[i] = PackColor(v.Color)
		else
			Data[i] = v.CurrentValue or v.CurrentKeybind or v.CurrentOption or v.Color
		end
	end	
	writefile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension, HttpService:JSONEncode(Data))
end

function RayfieldLibrary:LoadConfiguration()
	if not CEnabled or not isfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension) then return end
	local Raw = readfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension)
	local Success, Data = pcall(function() return HttpService:JSONDecode(Raw) end)
	if not Success or not Data then return end
	for FlagName, FlagValue in pairs(Data) do
		if RayfieldLibrary.Flags[FlagName] then
			task.spawn(function()
				if RayfieldLibrary.Flags[FlagName].Type == "ColorPicker" then
					RayfieldLibrary.Flags[FlagName]:Set(UnpackColor(FlagValue))
				else
					RayfieldLibrary.Flags[FlagName]:Set(FlagValue)
				end
			end)
		end
	end
end

function RayfieldLibrary:Notify(NotificationSettings)
	task.spawn(function()
		local Notification = Notifications.Template:Clone()
		Notification.Name = NotificationSettings.Title or "Notification"
		Notification.Title.Text = NotificationSettings.Title or "Notification"
		Notification.Description.Text = NotificationSettings.Content or ""
		Notification.Visible = true
		Notification.Parent = Notifications
		
		Notification.Size = UDim2.new(0, 260, 0, 80)
		Notification.BackgroundTransparency = 1
		
		TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1, Size = UDim2.new(0, 295, 0, 91)}):Play()
		task.wait(NotificationSettings.Duration or NotificationDuration)
		
		TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 260, 0, 0)}):Play()
		task.wait(0.5)
		Notification:Destroy()
	end)
end

function RayfieldLibrary:Destroy()
	Rayfield:Destroy()
end

function RayfieldLibrary:CreateWindow(Settings)
	Topbar.Title.Text = Settings.Name
	Main.Size = UDim2.new(0, 450, 0, 260)
	Main.Visible = true
	
	if Settings.ConfigurationSaving then
		CEnabled = Settings.ConfigurationSaving.Enabled or false
		CFileName = Settings.ConfigurationSaving.FileName or tostring(game.PlaceId)
		if Settings.ConfigurationSaving.FolderName then ConfigurationFolder = Settings.ConfigurationSaving.FolderName end
		if CEnabled and not isfolder(ConfigurationFolder) then makefolder(ConfigurationFolder) end
	end

	AddDraggingFunctionality(Topbar, Main)

	Notifications.Template.Visible = false
	Notifications.Visible = true
	Rayfield.Enabled = true

	-- Hide Loading Screen after delay
	task.delay(1, function()
		TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
		LoadingFrame.Visible = false
		Elements.Visible = true
		Topbar.Visible = true
		Main.Size = UDim2.new(0, 500, 0, 475)
	end)

	local Window = {}
	local FirstTab = false

	function Window:CreateTab(Name, Image)
		local TabButton = TabList.Template:Clone()
		TabButton.Name = Name
		TabButton.Title.Text = Name
		TabButton.Visible = true
		TabButton.Parent = TabList

		local TabPage = Elements.Template:Clone()
		TabPage.Name = Name
		TabPage.Visible = true
		TabPage.Parent = Elements

		for _, Child in ipairs(TabPage:GetChildren()) do
			if Child.ClassName == "Frame" and Child.Name ~= "Placeholder" then Child:Destroy() end
		end

		if not FirstTab then
			FirstTab = true
			Elements.UIPageLayout:JumpTo(TabPage)
		end

		TabButton.Interact.MouseButton1Click:Connect(function()
			Elements.UIPageLayout:JumpTo(TabPage)
		end)

		local Tab = {}

		-- Button
		function Tab:CreateButton(ButtonSettings)
			local Button = Elements.Template.Button:Clone()
			Button.Name = ButtonSettings.Name
			Button.Title.Text = ButtonSettings.Name
			Button.Visible = true
			Button.Parent = TabPage

			Button.Interact.MouseButton1Click:Connect(function()
				pcall(ButtonSettings.Callback)
				RayfieldLibrary:SaveConfiguration()
			end)

			local ButtonObj = {}
			function ButtonObj:Set(NewName)
				Button.Title.Text = NewName
			end
			return ButtonObj
		end

		-- Section
		function Tab:CreateSection(Name)
			local Section = Elements.Template.SectionTitle:Clone()
			Section.Title.Text = Name
			Section.Visible = true
			Section.Parent = TabPage

			local SectionObj = {}
			function SectionObj:Set(NewName)
				Section.Title.Text = NewName
			end
			return SectionObj
		end

		-- Toggle
		function Tab:CreateToggle(ToggleSettings)
			local Toggle = Elements.Template.Toggle:Clone()
			Toggle.Name = ToggleSettings.Name
			Toggle.Title.Text = ToggleSettings.Name
			Toggle.Visible = true
			Toggle.Parent = TabPage

			local CurrentValue = ToggleSettings.CurrentValue or false

			local function UpdateToggle()
				if CurrentValue then
					TweenService:Create(Toggle.Switch, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ToggleEnabled}):Play()
				else
					TweenService:Create(Toggle.Switch, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ToggleDisabled}):Play()
				end
			end

			UpdateToggle()

			Toggle.Interact.MouseButton1Click:Connect(function()
				CurrentValue = not CurrentValue
				UpdateToggle()
				pcall(ToggleSettings.Callback, CurrentValue)
				RayfieldLibrary:SaveConfiguration()
			end)

			local ToggleObj = {CurrentValue = CurrentValue}
			function ToggleObj:Set(NewVal)
				CurrentValue = NewVal
				ToggleObj.CurrentValue = NewVal
				UpdateToggle()
				pcall(ToggleSettings.Callback, CurrentValue)
			end

			if ToggleSettings.Flag then RayfieldLibrary.Flags[ToggleSettings.Flag] = ToggleObj end
			return ToggleObj
		end

		-- Slider
		function Tab:CreateSlider(SliderSettings)
			local Slider = Elements.Template.Slider:Clone()
			Slider.Name = SliderSettings.Name
			Slider.Title.Text = SliderSettings.Name
			Slider.Visible = true
			Slider.Parent = TabPage

			local Min = SliderSettings.Range[1]
			local Max = SliderSettings.Range[2]
			local CurrentValue = SliderSettings.CurrentValue or Min

			local function UpdateSlider(Val)
				Val = math.clamp(Val, Min, Max)
				CurrentValue = Val
				Slider.Value.Text = tostring(Val) .. " " .. (SliderSettings.Suffix or "")
				local Percent = (Val - Min) / (Max - Min)
				Slider.Main.Progress.Size = UDim2.new(Percent, 0, 1, 0)
			end

			UpdateSlider(CurrentValue)

			local Dragging = false
			Slider.Main.Interact.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true end
			end)

			UserInputService.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
					local MousePos = UserInputService:GetMouseLocation().X
					local FramePos = Slider.Main.AbsolutePosition.X
					local FrameSize = Slider.Main.AbsoluteSize.X
					local Percent = math.clamp((MousePos - FramePos) / FrameSize, 0, 1)
					local Val = math.floor(Min + (Max - Min) * Percent)
					UpdateSlider(Val)
					pcall(SliderSettings.Callback, Val)
					RayfieldLibrary:SaveConfiguration()
				end
			end)

			local SliderObj = {CurrentValue = CurrentValue}
			function SliderObj:Set(NewVal)
				UpdateSlider(NewVal)
				SliderObj.CurrentValue = CurrentValue
				pcall(SliderSettings.Callback, CurrentValue)
			end

			if SliderSettings.Flag then RayfieldLibrary.Flags[SliderSettings.Flag] = SliderObj end
			return SliderObj
		end

		-- Input
		function Tab:CreateInput(InputSettings)
			local InputFrame = Elements.Template.Input:Clone()
			InputFrame.Name = InputSettings.Name
			InputFrame.Title.Text = InputSettings.Name
			InputFrame.InputBox.PlaceholderText = InputSettings.PlaceholderText or "Enter text..."
			InputFrame.Visible = true
			InputFrame.Parent = TabPage

			InputFrame.InputBox.FocusLost:Connect(function(EnterPressed)
				local Text = InputFrame.InputBox.Text
				pcall(InputSettings.Callback, Text)
				if InputSettings.RemoveTextAfterFocusLost then InputFrame.InputBox.Text = "" end
			end)

			local InputObj = {}
			function InputObj:Set(NewText)
				InputFrame.InputBox.Text = NewText
			end
			return InputObj
		end

		-- Dropdown
		function Tab:CreateDropdown(DropdownSettings)
			local Dropdown = Elements.Template.Dropdown:Clone()
			Dropdown.Name = DropdownSettings.Name
			Dropdown.Title.Text = DropdownSettings.Name
			Dropdown.Visible = true
			Dropdown.Parent = TabPage

			local CurrentOption = DropdownSettings.CurrentOption or {DropdownSettings.Options[1]}

			Dropdown.Selected.Text = table.concat(CurrentOption, ", ")

			local DropdownObj = {CurrentOption = CurrentOption}
			function DropdownObj:Set(NewOptions)
				if type(NewOptions) == "string" then NewOptions = {NewOptions} end
				CurrentOption = NewOptions
				DropdownObj.CurrentOption = CurrentOption
				Dropdown.Selected.Text = table.concat(CurrentOption, ", ")
				pcall(DropdownSettings.Callback, CurrentOption)
			end

			if DropdownSettings.Flag then RayfieldLibrary.Flags[DropdownSettings.Flag] = DropdownObj end
			return DropdownObj
		end

		-- Keybind
		function Tab:CreateKeybind(KeybindSettings)
			local Keybind = Elements.Template.Keybind:Clone()
			Keybind.Name = KeybindSettings.Name
			Keybind.Title.Text = KeybindSettings.Name
			Keybind.Key.Text = KeybindSettings.CurrentKeybind or "None"
			Keybind.Visible = true
			Keybind.Parent = TabPage

			local CurrentKey = KeybindSettings.CurrentKeybind or "Q"
			local Listening = false

			Keybind.Interact.MouseButton1Click:Connect(function()
				Listening = true
				Keybind.Key.Text = "..."
			end)

			UserInputService.InputBegan:Connect(function(Input, Processed)
				if Processed then return end
				if Listening and Input.UserInputType == Enum.UserInputType.Keyboard then
					Listening = false
					CurrentKey = Input.KeyCode.Name
					Keybind.Key.Text = CurrentKey
					pcall(KeybindSettings.Callback, CurrentKey)
					RayfieldLibrary:SaveConfiguration()
				elseif not Listening and Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == CurrentKey then
					pcall(KeybindSettings.Callback, true)
				end
			end)

			local KeybindObj = {CurrentKeybind = CurrentKey}
			function KeybindObj:Set(NewKey)
				CurrentKey = NewKey
				KeybindObj.CurrentKeybind = NewKey
				Keybind.Key.Text = NewKey
			end

			if KeybindSettings.Flag then RayfieldLibrary.Flags[KeybindSettings.Flag] = KeybindObj end
			return KeybindObj
		end

		-- Label
		function Tab:CreateLabel(Text)
			local Label = Elements.Template.Label:Clone()
			Label.Title.Text = Text
			Label.Visible = true
			Label.Parent = TabPage

			local LabelObj = {}
			function LabelObj:Set(NewText)
				Label.Title.Text = NewText
			end
			return LabelObj
		end

		-- Paragraph
		function Tab:CreateParagraph(Settings)
			local Paragraph = Elements.Template.Paragraph:Clone()
			Paragraph.Title.Text = Settings.Title or "Title"
			Paragraph.Content.Text = Settings.Content or "Content"
			Paragraph.Visible = true
			Paragraph.Parent = TabPage

			local ParagraphObj = {}
			function ParagraphObj:Set(NewSettings)
				Paragraph.Title.Text = NewSettings.Title or Paragraph.Title.Text
				Paragraph.Content.Text = NewSettings.Content or Paragraph.Content.Text
			end
			return ParagraphObj
		end

		return Tab
	end

	return Window
end

return RayfieldLibrary
