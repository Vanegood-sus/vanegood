-- ╔═══════════════════════════════════════╗
-- ║             vanegood hub              ║
-- ║              @AHTNXPECT               ║
-- ║                                       ║
-- ╚═══════════════════════════════════════╝

print("🔥 Loading VaneGood Hub...")

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create Main Hub Window
local window = library:AddWindow("VaneGood Hub • v1.0", {
    main_color = Color3.fromRGB(139, 0, 0), -- Dark Red
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

mainTab:AddLabel("🎮 All available scripts in Games tab")
mainTab:AddLabel("🆔 Current Game ID: " .. game.PlaceId)
mainTab:AddSeperator()

mainTab:AddLabel("📊 Hub Status: ✅ Online")
mainTab:AddLabel("👨‍💻 Creator: VaneGood")

-- === GAMES TAB ===
gamesTab:AddLabel("╔══════════════════════════╗")
gamesTab:AddLabel("║      Available Scripts    ║")
gamesTab:AddLabel("╚══════════════════════════╝")
gamesTab:AddSeperator()

-- ALL SCRIPTS FROM GAMES FOLDER (NO GAME DETECTION)
gamesTab:AddLabel("🎮 All Scripts (works in any game):")
gamesTab:AddSeperator()

-- Muscle Legends Script
gamesTab:AddButton("💪 Muscle Legends Script", function()
    print("🚀 Loading Muscle Legends Script...")
    
    local success, error = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/games/MuscleLegendsScript.lua", true))()
    end)
    
    if success then
        print("✅ Muscle Legends Script loaded!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VaneGood Hub",
            Text = "✅ Muscle Legends Script loaded!",
            Duration = 3
        })
    else
        print("❌ Failed to load script:", error)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VaneGood Hub", 
            Text = "❌ Failed to load script!",
            Duration = 3
        })
    end
end)

gamesTab:AddLabel("📂 games/MuscleLegendsScript.lua")
gamesTab:AddSeperator()

-- Placeholder for when you add more scripts
gamesTab:AddLabel("📝 To add more scripts:")
gamesTab:AddLabel("1. Upload .lua files to games/ folder")  
gamesTab:AddLabel("2. Scripts will work in any game")
gamesTab:AddLabel("3. No game detection needed")

-- === INFO TAB ===
infoTab:AddLabel("╔═══════════════════════════════╗")
infoTab:AddLabel("║      vanegood hub info        ║")
infoTab:AddLabel("╚═══════════════════════════════╝")
infoTab:AddSeperator()

infoTab:AddLabel("👨‍💻 Creator: vanegood")
infoTab:AddLabel("📊 Version: 1.0")
infoTab:AddSeperator()

infoTab:AddLabel("🎮 Available Scripts:")
infoTab:AddLabel("✅ Muscle Legends Script")
infoTab:AddLabel("📂 From: games/ folder")
infoTab:AddSeperator()

infoTab:AddButton("📋 Copy GitHub Link", function()
    setclipboard("https://github.com/Vanegood-sus/vanegood")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "VaneGood Hub",
        Text = "GitHub link copied!",
        Duration = 3
    })
end)

infoTab:AddButton("📋 Copy Discord", function()
    setclipboard("vanegood")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "VaneGood Hub",
        Text = "Discord copied: vanegood",
        Duration = 3
    })
end)

-- Anti-AFK System for hub
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    print("🛡️ Anti-AFK activated")
end)

-- Success notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VaneGood Hub",
    Text = "🔥 Hub loaded! Check Games tab",
    Duration = 5
})

print("╔═══════════════════════════════════════╗")
print("║            vanegood hub               ║")
print("║         Successfully Loaded!          ║")  
print("║                                       ║")
print("║                                       ║")
print("╚═══════════════════════════════════════╝")
