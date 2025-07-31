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

-- Main tab (empty)
local mainTab = win:Tab({
    Title = "Main",
    Icon = "pickaxe",
})

-- Games tab with vanegood script launcher
local gamesTab = win:Tab({
    Title = "Games",
    Icon = "gamepad",
})

gamesTab:Section({
    Title = "Script Launcher",
    TextXAlignment = "Left",
    TextSize = 17,
})

gamesTab:Button({
    Title = "Run Vanegood Script",
    Locked = false,
    Callback = function()
        -- Добавляем проверку на ошибки при загрузке
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/vanegood.lua", true))()
        end)
        
        if not success then
            warn("Failed to load Vanegood script: " .. err)
        end
    end
})

-- Optional: Добавляем статус загрузки
gamesTab:Paragraph({
    Title = "Status: Ready",
    Locked = false,
})
