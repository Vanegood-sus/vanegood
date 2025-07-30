-- Dark Red Muscle Legends Script
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/vanegood.lua"))()
--// Window Theme
local theme = {
	main_color = Color3.fromRGB(178, 34, 34), --// Dark Red
	accent_color = Color3.fromRGB(0, 0, 0), --// Black
	text_color = Color3.fromRGB(255, 255, 255), --// White
	font = "SourceSansBold",
	font_size = 16
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local startTime = os.time()
local startRebirths = player.leaderstats.Rebirths.Value
local displayName = player.DisplayName

-- Anti-AFK System
local VirtualUser = game:GetService("VirtualUser")
local antiAFKConnection

local function setupAntiAFK()
	-- Disconnect previous connection if it exists
	if antiAFKConnection then
		antiAFKConnection:Disconnect()
	end

	-- Connect to PlayerIdleEvent to prevent AFK kicks
	antiAFKConnection = player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
		print("Anti-AFK: Prevented idle kick")
	end)

	print("Anti-AFK system enabled")
end

-- Initialize Anti-AFK system
setupAntiAFK()

-- Create Main Window
local window = library:AddWindow("Muscle Legends Script", {
	main_color = theme.main_color,
	min_size = Vector2.new(800, 900),
	can_resize = true,
})

-- Main Tab
local mainTab = window:AddTab("Main")
local farmPlusTab = window:AddTab("Farm")
mainTab:Show() -- Show this tab by default

-- Apply theme to main tab
mainTab.MainFrame.BackgroundColor3 = theme.main_color
mainTab.SideBar.BackgroundColor3 = theme.accent_color

mainTab:AddLabel("Muscle Legends Script")

-- Add Anti-AFK toggle
local antiAFKEnabled = true
mainTab:AddSwitch("Anti-AFK System", function(bool)
	antiAFKEnabled = bool
	if bool then
		setupAntiAFK()
	else
		if antiAFKConnection then
			antiAFKConnection:Disconnect()
			antiAFKConnection = nil
			print("Anti-AFK system disabled")
		end
	end
end, true) -- Default to enabled

-- Auto Brawls Folder
local autoBrawlsFolder = mainTab:AddFolder("Auto Brawls")

-- Variables
local Players = game:GetService("Players")
local whitelist = {}
-- Add any whitelisted player IDs here

-- Auto Win Brawl Toggle
local autoWinBrawlSwitch = autoBrawlsFolder:AddSwitch("Auto Win Brawls", function(bool)
	getgenv().autoWinBrawl = bool

	-- Equip Punch Tool function - will be called repeatedly
	local function equipPunch()
		if not getgenv().autoWinBrawl then
			return
		end

		local character = game.Players.LocalPlayer.Character
		if not character then
			return false
		end

		-- Check if already equipped
		if character:FindFirstChild("Punch") then
			return true
		end

		-- Try to equip from backpack
		local backpack = game.Players.LocalPlayer.Backpack
		if not backpack then
			return false
		end

		for _, tool in pairs(backpack:GetChildren()) do
			if tool.ClassName == "Tool" and tool.Name == "Punch" then
				tool.Parent = character
				return true
			end
		end

		return false
	end

	-- Safe player check function
	local function isValidTarget(player)
		if not player or not player.Parent then
			return false
		end

		if player == Players.LocalPlayer then
			return false
		end

		if whitelist[player.UserId] then
			return false
		end

		local character = player.Character
		if not character or not character.Parent then
			return false
		end

		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then
			return false
		end

		-- Multiple health checks to be absolutely certain
		if not humanoid.Health or humanoid.Health <= 0 then
			return false
		end

		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			return false
		end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not rootPart or not rootPart.Parent then
			return false
		end

		return true
	end

	-- Safe local player check function
	local function isLocalPlayerReady()
		local player = game.Players.LocalPlayer
		if not player then
			return false
		end

		local character = player.Character
		if not character or not character.Parent then
			return false
		end

		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return false
		end

		local leftHand = character:FindFirstChild("LeftHand")
		local rightHand = character:FindFirstChild("RightHand")

		return (leftHand ~= nil or rightHand ~= nil)
	end

	-- Safe firetouchinterest function
	local function safeTouchInterest(targetPart, localPart)
		if not targetPart or not targetPart.Parent then
			return false
		end
		if not localPart or not localPart.Parent then
			return false
		end

		local success, err = pcall(function()
			firetouchinterest(targetPart, localPart, 0)
			task.wait(0.01)
			firetouchinterest(targetPart, localPart, 1)
		end)

		return success
	end

	-- Join Brawl Loop
	task.spawn(function()
		while getgenv().autoWinBrawl and task.wait(0.5) do
			if not getgenv().autoWinBrawl then
				break
			end

			if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
				game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
				game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
			end
		end
	end)

	-- Equipment loop - keeps trying to equip the punch
	task.spawn(function()
		while getgenv().autoWinBrawl and task.wait(0.5) do
			if not getgenv().autoWinBrawl then
				break
			end

			equipPunch()
		end
	end)

	-- Auto Punch Loop - keeps punching
	task.spawn(function()
		while getgenv().autoWinBrawl and task.wait(0.1) do
			if not getgenv().autoWinBrawl then
				break
			end

			if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
				local player = game.Players.LocalPlayer
				pcall(function()
					player.muscleEvent:FireServer("punch", "rightHand")
				end)
				pcall(function()
					player.muscleEvent:FireServer("punch", "leftHand")
				end)
			end
		end
	end)

	-- Main Kill Loop - extremely resilient
	task.spawn(function()
		while getgenv().autoWinBrawl and task.wait(0.05) do
			if not getgenv().autoWinBrawl then
				break
			end

			-- Only proceed if local player is ready and brawl is in progress
			if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
				local character = game.Players.LocalPlayer.Character
				local leftHand = character:FindFirstChild("LeftHand")
				local rightHand = character:FindFirstChild("RightHand")

				-- Process each player individually with error handling
				for _, player in pairs(Players:GetPlayers()) do
					-- Skip if toggle was turned off mid-loop
					if not getgenv().autoWinBrawl then
						break
					end

					-- Use pcall for the entire player processing to prevent any errors from breaking the loop
					pcall(function()
						if isValidTarget(player) then
							local targetRoot = player.Character.HumanoidRootPart

							-- Try left hand
							if leftHand then
								safeTouchInterest(targetRoot, leftHand)
							end

							-- Try right hand
							if rightHand then
								safeTouchInterest(targetRoot, rightHand)
							end
						end
					end)

					-- Small delay between players to prevent overwhelming
					task.wait(0.01)
				end
			end
		end
	end)

	-- Recovery system - if the main loop somehow breaks, this will restart it
	task.spawn(function()
		local lastPlayerCount = 0
		local stuckCounter = 0

		while getgenv().autoWinBrawl and task.wait(1) do
			if not getgenv().autoWinBrawl then
				break
			end

			-- Check if we're processing players
			local currentPlayerCount = #Players:GetPlayers()

			-- If player count changed but we're not seeing any activity, restart the kill loop
			if currentPlayerCount ~= lastPlayerCount then
				stuckCounter = 0
				lastPlayerCount = currentPlayerCount
			else
				stuckCounter = stuckCounter + 1

				-- If we seem stuck for too long, force re-equip the tool
				if stuckCounter > 5 then
					stuckCounter = 0

					-- Force re-equip
					pcall(function()
						local character = game.Players.LocalPlayer.Character
						if character and character:FindFirstChild("Punch") then
							character.Punch.Parent = game.Players.LocalPlayer.Backpack
							task.wait(0.1)
							equipPunch()
						else
							equipPunch()
						end
					end)
				end
			end
		end
	end)
end)

-- Auto Join Brawl Only - FIXED to join only once and properly turn off
autoBrawlsFolder:AddSwitch("Auto Brawls", function(bool)
	getgenv().autoJoinBrawl = bool
	task.spawn(function()
		while getgenv().autoJoinBrawl and task.wait(0.5) do
			if not getgenv().autoJoinBrawl then
				break
			end

			if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
				game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
				-- Set the label to not visible to prevent multiple joins
				game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
			end
		end
	end)
end)

local jungleGymFolder = mainTab:AddFolder("Jungle Gym")

-- Cache services for faster access
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Helper functions for Jungle Gym
local function pressE()
	VIM:SendKeyEvent(true, "E", false, game)
	task.wait(0.1)
	VIM:SendKeyEvent(false, "E", false, game)
end

local function autoLift()
	while getgenv().working do
		LocalPlayer.muscleEvent:FireServer("rep")
		task.wait() -- More efficient than task.wait(0) or task.wait(small number)
	end
end

local function teleportAndStart(machineName, position)
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		character.HumanoidRootPart.CFrame = position
		task.wait(0.1)
		pressE()
		task.spawn(autoLift) -- Use task.spawn to prevent UI freezing
	end
end

-- Jungle Gym Bench Press
jungleGymFolder:AddSwitch("Jungle Bench Press", function(bool)
	if getgenv().working and not bool then
		getgenv().working = false
		return
	end
	getgenv().working = bool
	if bool then
		teleportAndStart("Bench Press", CFrame.new(-8173, 64, 1898))
	end
end)

-- Jungle Gym Squat
jungleGymFolder:AddSwitch("Jungle Squat", function(bool)
	if getgenv().working and not bool then
		getgenv().working = false
		return
	end
	getgenv().working = bool
	if bool then
		teleportAndStart("Squat", CFrame.new(-8352, 34, 2878))
	end
end)

-- Jungle Gym Pull Up
jungleGymFolder:AddSwitch("Jungle Pull Ups", function(bool)
	if getgenv().working and not bool then
		getgenv().working = false
		return
	end
	getgenv().working = bool
	if bool then
		teleportAndStart("Pull Up", CFrame.new(-8666, 34, 2070))
	end
end)

-- Jungle Gym Boulder
jungleGymFolder:AddSwitch("Jungle Boulder", function(bool)
	if getgenv().working and not bool then
		getgenv().working = false
		return
	end
	getgenv().working = bool
	if bool then
		teleportAndStart("Boulder", CFrame.new(-8621, 34, 2684))
	end
end)

-- NEW: Farm Gyms Folder
local farmGymsFolder = mainTab:AddFolder("Entrenar Gimnasios")

-- Workout positions data
local workoutPositions = {
	["Bench Press"] = {
		["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
		["Legend Gym"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
		["Muscle King Gym"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
	},
	["Squat"] = {
		["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
		["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
		["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
	},
	["Deadlift"] = {
		["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
		["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
		["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
	},
	["Pull Up"] = {
		["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
		["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
		["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
	}
}

-- Workout types
local workoutTypes = {"Bench Press", "Squat", "Deadlift", "Pull Up"}

-- Gym locations (only the three requested)
local gymLocations = {"Eternal Gym", "Legend Gym", "Muscle King Gym"}

-- Spanish translations for workout types
local workoutTranslations = {
	["Bench Press"] = "Bench Press",
	["Squat"] = "Squat",
	["Deadlift"] = "Dead Lift",
	["Pull Up"] = "Pull Up"
}

-- Store references to toggle objects
local gymToggles = {}

-- Create dropdowns and toggles for each workout type
for _, workoutType in ipairs(workoutTypes) do
	-- Create dropdown for gym selection
	local dropdownName = workoutType .. "GymDropdown"
	local spanishWorkoutName = workoutTranslations[workoutType]

	-- Create the dropdown with the correct format
	local dropdown = farmGymsFolder:AddDropdown(spanishWorkoutName .. " - Gimnasio", function(selected)
		_G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] = selected
	end)

	-- Add gym locations to the dropdown
	for _, gymName in ipairs(gymLocations) do
		dropdown:Add(gymName)
	end

	-- Create toggle for workout
	local toggleName = workoutType .. "GymToggle"
	local toggle = farmGymsFolder:AddSwitch(spanishWorkoutName, function(bool)
		getgenv().workingGym = bool
		getgenv().currentWorkoutType = workoutType
		if bool then
			local selectedGym = _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] or gymLocations[1]

			-- Make sure we have a valid position
			if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGym] then
				-- Stop any other workout that might be running
				for otherType, otherToggle in pairs(gymToggles) do
					if otherType ~= workoutType and otherToggle then
						otherToggle:Set(false)
					end
				end

				-- Start the workout
				teleportAndStart(workoutType, workoutPositions[workoutType][selectedGym])
			else
				-- Notify user if position is not found
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Position not found for " .. workoutType .. " in " .. selectedGym,
					Duration = 5
				})
			end
		end
	end)

	-- Store reference to toggle
	gymToggles[workoutType] = toggle
end

-- OP Things/Farms Folder
local opThingsFolder = mainTab:AddFolder("OP Things/Farms")

-- Anti Knockback Toggle
opThingsFolder:AddSwitch("Anti Knockback", function(Value)
	if Value then
		local playerName = game.Players.LocalPlayer.Name
		local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
		bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		bodyVelocity.P = 1250
		bodyVelocity.Parent = rootPart
	else
		local playerName = game.Players.LocalPlayer.Name
		local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
		local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
		if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
			existingVelocity:Destroy()
		end
	end
end)

-- Anti AFK Button
opThingsFolder:AddButton("Anti AFK", function()
	-- Anti AFK implementation
	local GC = getconnections or get_signal_cons
	if GC then
		for i, v in pairs(GC(game.Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
	else
		-- Fallback method if getconnections isn't available
		local VirtualUser = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end

	-- Notify user
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Anti AFK",
		Text = "Anti AFK has been enabled!",
		Duration = 5
	})

	-- Additional periodic movement to prevent AFK
	spawn(function()
		while wait(30) do
			local VirtualUser = game:GetService("VirtualUser")
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end
	end)
end)

local autoRockFolder = farmPlusTab:AddFolder("Auto Rock")

-- Define the gettool function first
function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

-- Add all rock farming toggles to the Auto Rock folder
autoRockFolder:AddSwitch("Tiny Rock", function(Value)
	selectrock = "Tiny Island Rock"
	getgenv().autoFarm = Value
	task.spawn(function()
		while getgenv().autoFarm do
			task.wait()
			if not getgenv().autoFarm then
				break
			end
			if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end)
end)

autoRockFolder:AddSwitch("Starter Rock", function(Value)
	selectrock = "Starter Island Rock"
	getgenv().autoFarm = Value
	task.spawn(function()
		while getgenv().autoFarm do
			task.wait()
			if not getgenv().autoFarm then
				break
			end
			if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						get
