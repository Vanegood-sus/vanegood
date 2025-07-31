local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Gerad's/source.lua"))()

local window = library:AddWindow("Legend Of Speed", {

main_color = Color3.fromRGB(200, 200, 200), -- светло-серый
    min_size = Vector2.new(500, 400),
    can_resize = true
})

-- Основная вкладка 
local farmPlusTab = window:AddTab("Автошаги")
mainTab:Show()

farmPlusTab:AddFolder('AutoSteps', function(bool)
     getgenv().AutoSteps = true
    while getgenv().AutoSteps == true do

mainTab:AddLabel("Добро Пожаловать!")

    local args = {
    [1] = "collectOrb",
    [2] = "Orange Orb",
    [3] = "City"
  }
  game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait()
    end
  end)


mainTab('Автогемы', function()
     getgenv().AutoGems = true
    while getgenv().AutoGems == true do
      local args = {
      [1] = "collectOrb",
      [2] = "Gem",
      [3] = "City"
    }
    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait()
    end
  end)



local teleportTab = window:AddTab('AutoRebirth', function()
     getgenv().AutoRebirth = true
    while getgenv().AutoRebirth == true do
     local args = {
    [1] = "rebirthRequest"
   }
game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
    wait()
    end
  end)

Section:Label('') -- :Label(Text)


-- Вкладка "Создатель"
local noteTab = window:AddTab("Создатель")
noteTab:AddLabel("Private Script")
noteTab:AddLabel("")
noteTab:AddLabel("Созданно vanegood")        task.wait()
    end
end)

-- AutoRebirth
mainTab:AddButton("AutoRebirth", function()
    getgenv().AutoRebirth = true
    while getgenv().AutoRebirth do
        local args = {
            [1] = "rebirthRequest"
        }
        game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
        task.wait()
    end
end)

-- Вкладка "Создатель"
local noteTab = window:AddTab("Создатель")
noteTab:AddLabel("Private Script")
noteTab:AddLabel("")
noteTab:AddLabel("Созданно vanegood")

-- Принудительное отображение интерфейса
if game:GetService("CoreGui"):FindFirstChild("Elerium") then
    game:GetService("CoreGui").Elerium.Enabled = true
end

