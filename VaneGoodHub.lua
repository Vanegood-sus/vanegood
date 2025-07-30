-- VaneGood Hub Simple Version
print("Loading VaneGood Hub...")

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create window
local window = library:AddWindow("VaneGood Hub v1.0", {
    main_color = Color3.fromRGB(139, 0, 0),
    min_size = Vector2.new(500, 400),
    can_resize = true,
})

-- Create tabs
local mainTab = window:AddTab("Home")
local gamesTab = window:AddTab("Games") 
mainTab:Show()

-- Home tab
mainTab:AddLabel("VaneGood Hub v1.0")
mainTab:AddLabel("Welcome " .. player.DisplayName)
mainTab:AddSeperator()
mainTab:AddLabel("Current Game: " .. game.PlaceId)

-- Games tab - DIRECT BUTTONS (no folders)
gamesTab:AddLabel("Available Games:")
gamesTab:AddSeperator()

-- Direct Muscle Legends button
gamesTab:AddButton("💪 Load Muscle Legends Script", function()
    if game.PlaceId == 3623096087 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/games/MuscleLegendsScript.lua", true))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VaneGood Hub",
            Text = "Muscle Legends script loaded!",
            Duration = 3
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VaneGood Hub",
            Text = "Join Muscle Legends first!",
            Duration = 3
        })
    end
end)

gamesTab:AddLabel("Game ID: 3623096087")
gamesTab:AddSeperator()
gamesTab:AddLabel("More games coming soon...")

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("VaneGood Hub loaded successfully!")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VaneGood Hub",
    Text = "Hub loaded! Check Games tab",
    Duration = 5
})
