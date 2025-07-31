wait(0.5)

local gui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local statusFrame = Instance.new("Frame")
local statusText = Instance.new("TextLabel")
local credit = Instance.new("TextLabel")

-- Настройка GUI
gui.Name = "Anti-Afk"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм (4x4 см - примерно 150x150 пикселей)
mainFrame.Name = "MainFrame"
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.Position = UDim2.new(0.7, 0, 0.1, 0)
mainFrame.Size = UDim2.new(0, 150, 0, 150)
mainFrame.BorderSizePixel = 0

-- Заголовок
title.Name = "vanegood hub"
title.Parent = mainFrame
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.SourceSansSemibold
title.Text = "Anti AFK"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextSize = 18
title.BorderSizePixel = 0

-- Фрейм статуса
statusFrame.Name = "StatusFrame"
statusFrame.Parent = mainFrame
statusFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
statusFrame.Position = UDim2.new(0, 0, 0.2, 0)
statusFrame.Size = UDim2.new(1, 0, 0.6, 0)
statusFrame.BorderSizePixel = 0

-- Текст статуса
statusText.Name = "Статус"
statusText.Parent = statusFrame
statusText.BackgroundTransparency = 1
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.Font = Enum.Font.ArialBold
statusText.Text = "Статус: Активный"
statusText.TextColor3 = Color3.fromRGB(0, 255, 255)
statusText.TextSize = 16

-- Кредиты
credit.Name = "Создатель"
credit.Parent = mainFrame
credit.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
credit.Position = UDim2.new(0, 0, 0.8, 0)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Font = Enum.Font.Arial
credit.Text = "vanegood hub"
credit.TextColor3 = Color3.fromRGB(0, 255, 255)
credit.TextSize = 14
credit.BorderSizePixel = 0

-- Anti-AFK логика
local virtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    statusText.Text = "Roblox пытался кикнуть вас"
    wait(2)
    statusText.Text = "Статус: Активный"
end)
