local plrs = game.Players
local plr = plrs.LocalPlayer
local char = plr.Character

local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local win = ui:CreateWindow({
    Title = "Vanegood Hub",
    Icon = "terminal",
    Folder = nil,
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    Background = "",
})

-- Main tab (пустая)
local mainTab = win:Tab({
    Title = "Main",
    Icon = "pickaxe",
})

-- Games tab (с кнопкой запуска Vanegood)
local gamesTab = win:Tab({
    Title = "Games",
    Icon = "gamepad",
})

gamesTab:Button({
    Title = "Muscle Legends", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/vanegood.lua"))()
    end
})
