local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

-- Основной код интерфейса
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua", true))()

local win = ui:CreateWindow({
    Title = "Vanegood Hub",
    Icon = "terminal",
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark"
})

-- Вкладка Main
local mainTab = win:Tab({
    Title = "Main",
    Icon = "pickaxe"
})

-- Вкладка Games
local gamesTab = win:Tab({
    Title = "Games",
    Icon = "gamepad"
})

-- Кнопка запуска
gamesTab:Button({
    Title = "Muscle Legends", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/vanegood.lua", true))()
    end
})

-- Принудительное отображение (на случай если UI скрыто по умолчанию)
game:GetService("CoreGui").WindUI.Enabled = true
