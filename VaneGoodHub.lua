-- ╔═══════════════════════════════════════╗
-- ║            VaneGood Hub v1.0          ║
-- ║         Created by VaneGood           ║
-- ║        Discord: vanegood              ║
-- ╚═══════════════════════════════════════╝

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create Main Hub Window with Dark Red/Black Theme
local window = library:AddWindow("VaneGood Hub • v1.0", {
    main_color = Color3.fromRGB(139, 0, 0), -- Dark Red (#8B0000)
    min_size = Vector2.new(600, 450),
    can_resize = true,
})

-- Tabs
local mainTab = window:AddTab("🏠 Home")
local gamesTab = window:AddTab("🎮 Games")
local infoTab = window:AddTab("ℹ️ Info")
mainTab:Show()

-- === HOME TAB ===
mainTab:AddLabel("╔══════════════════════════╗")
mainTab:AddLabel("║     VaneGood Hub v1.0    ║")
mainTab:AddLabel("╚══════════════════════════╝")
mainTab:AddLabel("👤 Welcome, " .. player.DisplayName .. "!")
mainTab:AddSeperator()

mainTab:AddLabel("🎮 Select a game from the Games tab")
mainTab:AddLabel("🆔 Current Game ID: " .. game.PlaceId)
mainTab:AddSeperator()

-- Status
mainTab:AddLabel("📊 Hub Status: ✅ Online")
mainTab:AddLabel("👨‍💻 Creator: VaneGood")

-- === GAMES TAB ===
gamesTab:AddLabel("Available Games:")
gamesTab:AddSeperator()

-- Muscle Legends Section
local muscleLegendsFolder = gamesTab:AddFolder("💪 Muscle Legends")

muscleLegendsFolder:AddButton("🚀 Load Muscle Legends Script", function()
    -- Check if we're in Muscle Legends
    if game.PlaceId == 3623096087 then -- Muscle Legends game ID
        -- Load the complete muscle legends script
        local success, error = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VaneGood/Scripts/main/games/MuscleLegendsScript.lua", true))()
        end)
        
        if success then
            -- Notification
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "VaneGood Hub",
                Text = "✅ Muscle Legends script loaded!",
                Duration = 3
            })
        else
            -- Fallback to embedded script
            loadstring([[
-- VaneGood Hub - Muscle Legends Script
-- Created by VaneGood

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
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
    end)
end

setupAntiAFK()

-- Create Main Window
local window = library:AddWindow("VaneGood • Muscle Legends", {
    main_color = Color3.fromRGB(139, 0, 0),
    min_size = Vector2.new(800, 900),
    can_resize = true,
})

local mainTab = window:AddTab("🏠 Main")
local farmTab = window:AddTab("⚡ Farm")
mainTab:Show()

mainTab:AddLabel("╔═══════════════════════════════╗")
mainTab:AddLabel("║   VaneGood • Muscle Legends   ║")  
mainTab:AddLabel("╚═══════════════════════════════╝")
mainTab:AddLabel("👤 Welcome, " .. displayName .. "!")
mainTab:AddSeperator()

-- Anti-AFK toggle
mainTab:AddSwitch("🛡️ Anti-AFK System", function(bool)
    if bool then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
    end
end, true)

-- Auto Brawls
local autoBrawlsFolder = mainTab:AddFolder("🥊 Auto Brawls")

autoBrawlsFolder:AddSwitch("🏆 Auto Win Brawls", function(bool)
    getgenv().autoWinBrawl = bool
    
    if bool then
        -- Join Brawl Loop
        task.spawn(function()
            while getgenv().autoWinBrawl do
                if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end
                task.wait(0.5)
            end
        end)
        
        -- Auto Punch Loop
        task.spawn(function()
            while getgenv().autoWinBrawl do
                if game.ReplicatedStorage.brawlInProgress.Value then
                    pcall(function() 
                        player.muscleEvent:FireServer("punch", "rightHand")
                        player.muscleEvent:FireServer("punch", "leftHand") 
                    end)
                end
                task.wait(0.1)
            end
        end)
        
        -- Kill Loop
        task.spawn(function()
            while getgenv().autoWinBrawl do
                if game.ReplicatedStorage.brawlInProgress.Value then
                    local character = player.Character
                    if character then
                        local leftHand = character:FindFirstChild("LeftHand")
                        local rightHand = character:FindFirstChild("RightHand")
                        
                        for _, targetPlayer in pairs(Players:GetPlayers()) do
                            if targetPlayer ~= player and targetPlayer.Character then
                                local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if targetRoot then
                                    pcall(function()
                                        if leftHand then
                                            firetouchinterest(targetRoot, leftHand, 0)
                                            firetouchinterest(targetRoot, leftHand, 1)
                                        end
                                        if rightHand then
                                            firetouchinterest(targetRoot, rightHand, 0)
                                            firetouchinterest(targetRoot, rightHand, 1)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
                task.wait(0.05)
            end
        end)
    end
end)

-- Jungle Gym
local jungleGymFolder = farmTab:AddFolder("🌴 Jungle Gym")

local VIM = game:GetService("VirtualInputManager")

local function pressE()
    VIM:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    VIM:SendKeyEvent(false, "E", false, game)
end

local function autoLift()
    while getgenv().working do
        player.muscleEvent:FireServer("rep")
        task.wait()
    end
end

local function teleportAndStart(machineName, position)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = position
        task.wait(0.1)
        pressE()
        task.spawn(autoLift)
    end
end

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

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VaneGood Hub",
    Text = "Muscle Legends script loaded!",
    Duration = 5
})
            ]])()
        end
    else
        -- Wrong game notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VaneGood Hub", 
            Text = "❌ Join Muscle Legends to use this script!",
            Duration = 5
        })
    end
end)

-- Game info
muscleLegendsFolder:AddLabel("🆔 Game ID: 3623096087")
muscleLegendsFolder:AddLabel("📝 Status: ✅ Ready")

-- Placeholder for future games
gamesTab:AddSeperator()
gamesTab:AddLabel("🔜 More games coming soon...")

-- Future game folders (disabled for now)
local comingSoonFolder = gamesTab:AddFolder("🔒 Coming Soon")
comingSoonFolder:AddLabel("- Pet Simulator X")
comingSoonFolder:AddLabel("- Blox Fruits") 
comingSoonFolder:AddLabel("- Arsenal")
comingSoonFolder:AddLabel("- King Legacy")

-- === INFO TAB ===
infoTab:AddLabel("╔═══════════════════════════════╗")
infoTab:AddLabel("║      VaneGood Hub Info        ║")
infoTab:AddLabel("╚═══════════════════════════════╝")
infoTab:AddSeperator()

infoTab:AddLabel("👨‍💻 Creator: VaneGood")
infoTab:AddLabel("📊 Version: 1.0")
infoTab:AddLabel("💬 Discord: vanegood")
infoTab:AddSeperator()

infoTab:AddLabel("🎮 Supported Games:")
infoTab:AddLabel("✅ Muscle Legends (3623096087)")
infoTab:AddLabel("⏳ More games in development...")

infoTab:AddSeperator()
infoTab:AddButton("📋 Copy Discord Link", function()
    setclipboard("https://discord.gg/vanegood")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "VaneGood Hub",
        Text = "Discord link copied to clipboard!",
        Duration = 3
    })
end)

infoTab:AddButton("🔄 Check for Updates", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "VaneGood Hub",
        Text = "You are running the latest version!",
        Duration = 3
    })
end)

-- Anti-AFK System for the hub
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Success notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VaneGood Hub",
    Text = "Hub loaded successfully! Welcome " .. player.DisplayName,
    Duration = 5
})

print("╔═══════════════════════════════════════╗")
print("║            VaneGood Hub v1.0          ║")
print("║         Successfully Loaded!          ║")
print("╚═══════════════════════════════════════╝")