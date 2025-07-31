local plrs = game.Players
local plr = plrs.LocalPlayer
local char = plr.Character

local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local win = ui:CreateWindow({
    Title = "Vanegood Hub",
    Icon = "terminal",
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
})

-- Main tab
local mainTab = win:Tab({
    Title = "Main",
    Icon = "home",
})

-- Games tab
local gamesTab = win:Tab({
    Title = "Scripts",
    Icon = "gamepad",
})

gamesTab:Section({
    Title = "Muscle Legends",
})

gamesTab:Button({
    Title = "Запустить Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/hub.lua"))()
    end
})
