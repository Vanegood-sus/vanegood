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
mainTab:Button({
    Title = "Fly", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/fly.lua", true))()
    end
})
mainTab:Button({
    Title = "Infinite Yield", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})
mainTab:Button({
    Title = "Anti-Afk", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/Anti-Afk-lua", true))()
    end
})
mainTab:Button({
    Title = "Spectator", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/spectator.lua", true))()
    end
})
mainTab:Button({
    Title = "Spin", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/spin.lua", true))()
    end
})
mainTab:Button({
    Title = "Shift-Lock", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/shiftlock.lua", true))()
    end
})
-- Games tab 
local gamesTab = win:Tab({
    Title = "Scripts",
    Icon = "gamepad",
})

-- Muscle Legends 
gamesTab:Button({
    Title = "Muscle Legends", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/MuscleLegends.lua", true))()
    end
})
gamesTab:Button({
    Title = "Legends Of Speed", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/LegendOfSpeed.lua", true))()
    end
})
gamesTab:Button({
    Title = "Npc or Die", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/NpcOrDie.lua", true))()
    end
})
