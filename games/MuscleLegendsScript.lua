-- VaneGood Hub - Muscle Legends Script
-- Created by VaneGood

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

-- Services
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
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end

    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Anti-AFK: Prevented idle kick")
    end)

    print("Anti-AFK system enabled")
end

-- Initialize Anti-AFK system
setupAntiAFK()

-- Create Main Window with dark red/black theme
local window = library:AddWindow("VaneGood • Muscle Legends", {
    main_color = Color3.fromRGB(139, 0, 0), -- Dark Red
    min_size = Vector2.new(800, 900),
    can_resize = true,
})

-- Main Tab
local mainTab = window:AddTab("🏠 Main")
local farmTab = window:AddTab("⚡ Farm")
mainTab:Show()

-- Header
mainTab:AddLabel("╔═══════════════════════════════╗")
mainTab:AddLabel("║   VaneGood • Muscle Legends   ║")
mainTab:AddLabel("╚═══════════════════════════════╝")
mainTab:AddLabel("👤 Welcome, " .. displayName .. "!")
mainTab:AddSeperator()

-- Anti-AFK toggle
local antiAFKEnabled = true
mainTab:AddSwitch("🛡️ Anti-AFK System", function(bool)
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
end, true)

-- Auto Brawls Folder
local autoBrawlsFolder = mainTab:AddFolder("🥊 Auto Brawls")

-- Variables
local whitelist = {}

-- Auto Win Brawl Toggle
autoBrawlsFolder:AddSwitch("🏆 Auto Win Brawls", function(bool)
    getgenv().autoWinBrawl = bool

    local function equipPunch()
        if not getgenv().autoWinBrawl then return end

        local character = game.Players.LocalPlayer.Character
        if not character then return false end

        if character:FindFirstChild("Punch") then return true end

        local backpack = game.Players.LocalPlayer.Backpack
        if not backpack then return false end

        for _, tool in pairs(backpack:GetChildren()) do
            if tool.ClassName == "Tool" and tool.Name == "Punch" then
                tool.Parent = character
                return true
            end
        end
        return false
    end

    local function isValidTarget(targetPlayer)
        if not targetPlayer or not targetPlayer.Parent then return false end
        if targetPlayer == Players.LocalPlayer then return false end
        if whitelist[targetPlayer.UserId] then return false end

        local character = targetPlayer.Character
        if not character or not character.Parent then return false end

        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return false end

        if not humanoid.Health or humanoid.Health <= 0 then return false end
        if humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end

        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart or not rootPart.Parent then return false end

        return true
    end

    local function isLocalPlayerReady()
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer then return false end

        local character = localPlayer.Character
        if not character or not character.Parent then return false end

        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false end

        local leftHand = character:FindFirstChild("LeftHand")
        local rightHand = character:FindFirstChild("RightHand")

        return (leftHand ~= nil or rightHand ~= nil)
    end

    local function safeTouchInterest(targetPart, localPart)
        if not targetPart or not targetPart.Parent then return false end
        if not localPart or not localPart.Parent then return false end

        local success = pcall(function()
            firetouchinterest(targetPart, localPart, 0)
            task.wait(0.01)
            firetouchinterest(targetPart, localPart, 1)
        end)

        return success
    end

    -- Join Brawl Loop
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if not getgenv().autoWinBrawl then break end

            if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)

    -- Equipment loop
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if not getgenv().autoWinBrawl then break end
            equipPunch()
        end
    end)

    -- Auto Punch Loop
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.1) do
            if not getgenv().autoWinBrawl then break end

            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                local localPlayer = game.Players.LocalPlayer
                pcall(function() localPlayer.muscleEvent:FireServer("punch", "rightHand") end)
                pcall(function() localPlayer.muscleEvent:FireServer("punch", "leftHand") end)
            end
        end
    end)

    -- Main Kill Loop
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.05) do
            if not getgenv().autoWinBrawl then break end

            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                local character = game.Players.LocalPlayer.Character
                local leftHand = character:FindFirstChild("LeftHand")
                local rightHand = character:FindFirstChild("RightHand")

                for _, targetPlayer in pairs(Players:GetPlayers()) do
                    if not getgenv().autoWinBrawl then break end

                    pcall(function()
                        if isValidTarget(targetPlayer) then
                            local targetRoot = targetPlayer.Character.HumanoidRootPart

                            if leftHand then
                                safeTouchInterest(targetRoot, leftHand)
                            end

                            if rightHand then
                                safeTouchInterest(targetRoot, rightHand)
                            end
                        end
                    end)

                    task.wait(0.01)
                end
            end
        end
    end)
end)

-- Auto Join Brawl Only
autoBrawlsFolder:AddSwitch("🎯 Auto Join Brawls", function(bool)
    getgenv().autoJoinBrawl = bool

    task.spawn(function()
        while getgenv().autoJoinBrawl and task.wait(0.5) do
            if not getgenv().autoJoinBrawl then break end

            if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)
end)

-- Jungle Gym Folder
local jungleGymFolder = farmTab:AddFolder("🌴 Jungle Gym")

-- Cache services
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Helper functions
local function pressE()
    VIM:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    VIM:SendKeyEvent(false, "E", false, game)
end

local function autoLift()
    while getgenv().working do
        LocalPlayer.muscleEvent:FireServer("rep")
        task.wait()
    end
end

local function teleportAndStart(machineName, position)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = position
        task.wait(0.1)
        pressE()
        task.spawn(autoLift)
    end
end

-- Jungle Gym exercises
jungleGymFolder:AddSwitch("💪 Jungle Bench Press", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end

    getgenv().working = bool
    if bool then
        teleportAndStart("Bench Press", CFrame.new(-8173, 64, 1898))
    end
end)

jungleGymFolder:AddSwitch("🦵 Jungle Squat", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end

    getgenv().working = bool
    if bool then
        teleportAndStart("Squat", CFrame.new(-8352, 34, 2878))
    end
end)

jungleGymFolder:AddSwitch("🏋️ Jungle Pull Ups", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end

    getgenv().working = bool
    if bool then
        teleportAndStart("Pull Up", CFrame.new(-8666, 34, 2070))
    end
end)

jungleGymFolder:AddSwitch("🪨 Jungle Boulder", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end

    getgenv().working = bool
    if bool then
        teleportAndStart("Boulder", CFrame.new(-8621, 34, 2684))
    end
end)

-- Success notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VaneGood Hub",
    Text = "Muscle Legends script loaded successfully!",
    Duration = 5
})

print("VaneGood Hub - Muscle Legends script loaded!")
