local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Gerad's/source.lua"))()

local Window = Library:CreateWindow('vanegood hub ') -- :CreateWindow(Title)

local Section = Window:Section('Open script') -- :Section(Title)

-- Label
Section:Label('Made by vanegood') -- :Label(Text)

-- Button
Section:Button('AutoSteps', function()
     getgenv().AutoSteps = true
    while getgenv().AutoSteps == true do

    local args = {
    [1] = "collectOrb",
    [2] = "Orange Orb",
    [3] = "City"
  }
  game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait()
    end
  end)


Section:Button('AutoGems', function()
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



Section:Button('AutoRebirth', function()
     getgenv().AutoRebirth = true
    while getgenv().AutoRebirth == true do
     local args = {
    [1] = "rebirthRequest"
   }
game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
    wait()
    end
  end)

Section:Label('') -- :Label(Text)      [3] = "City"
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

