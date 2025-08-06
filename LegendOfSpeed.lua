local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки скрипта
local orbFarmEnabled = false
local rebirthEnabled = false
local minimized = false

-- Подключение к RemoteEvents
local replicatedStorage = game:GetService("ReplicatedStorage")
local rEvents = replicatedStorage:WaitForChild("rEvents")
local orbEvent = rEvents:WaitForChild("orbEvent")
local rebirthEvent = rEvents:WaitForChild("rebirthEvent")

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 130) -- Увеличили высоту для двух переключателей
MainFrame.Position = UDim2.new(0.5, -90, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Заголовок "Vanegood hub"
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "vanegood hub"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamMedium
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Крестик для закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Контентная область
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 0, 95) -- Увеличили высоту
ContentFrame.Position = UDim2.new(0, 10, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Переключатель сбора орбов
local OrbToggleContainer = Instance.new("Frame")
OrbToggleContainer.Size = UDim2.new(1, 0, 0, 30)
OrbToggleContainer.BackgroundTransparency = 1
OrbToggleContainer.Parent = ContentFrame

local OrbToggleLabel = Instance.new("TextLabel")
OrbToggleLabel.Size = UDim2.new(0, 100, 1, 0)
OrbToggleLabel.Position = UDim2.new(0, 0, 0, 0)
OrbToggleLabel.BackgroundTransparency = 1
OrbToggleLabel.Text = "Фарм орбов"
OrbToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
OrbToggleLabel.Font = Enum.Font.GothamMedium
OrbToggleLabel.TextSize = 14
OrbToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
OrbToggleLabel.Parent = OrbToggleContainer

local OrbToggleFrame = Instance.new("Frame")
OrbToggleFrame.Size = UDim2.new(0, 50, 0, 25)
OrbToggleFrame.Position = UDim2.new(1, -50, 0.5, -12)
OrbToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
OrbToggleFrame.BorderSizePixel = 0
OrbToggleFrame.Parent = OrbToggleContainer

local OrbToggleCorner = Instance.new("UICorner")
OrbToggleCorner.CornerRadius = UDim.new(1, 0)
OrbToggleCorner.Parent = OrbToggleFrame

local OrbToggleButton = Instance.new("TextButton")
OrbToggleButton.Size = UDim2.new(0, 21, 0, 21)
OrbToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
OrbToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
OrbToggleButton.Text = ""
OrbToggleButton.Parent = OrbToggleFrame

local OrbButtonCorner = Instance.new("UICorner")
OrbButtonCorner.CornerRadius = UDim.new(1, 0)
OrbButtonCorner.Parent = OrbToggleButton

-- Переключатель ребитхов
local RebirthToggleContainer = Instance.new("Frame")
RebirthToggleContainer.Size = UDim2.new(1, 0, 0, 30)
RebirthToggleContainer.BackgroundTransparency = 1
RebirthToggleContainer.Position = UDim2.new(0, 0, 0, 35) -- Смещаем вниз
RebirthToggleContainer.Parent = ContentFrame

local RebirthToggleLabel = Instance.new("TextLabel")
RebirthToggleLabel.Size = UDim2.new(0, 100, 1, 0)
RebirthToggleLabel.Position = UDim2.new(0, 0, 0, 0)
RebirthToggleLabel.BackgroundTransparency = 1
RebirthToggleLabel.Text = "Авто ребитх"
RebirthToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
RebirthToggleLabel.Font = Enum.Font.GothamMedium
RebirthToggleLabel.TextSize = 14
RebirthToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
RebirthToggleLabel.Parent = RebirthToggleContainer

local RebirthToggleFrame = Instance.new("Frame")
RebirthToggleFrame.Size = UDim2.new(0, 50, 0, 25)
RebirthToggleFrame.Position = UDim2.new(1, -50, 0.5, -12)
RebirthToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
RebirthToggleFrame.BorderSizePixel = 0
RebirthToggleFrame.Parent = RebirthToggleContainer

local RebirthToggleCorner = Instance.new("UICorner")
RebirthToggleCorner.CornerRadius = UDim.new(1, 0)
RebirthToggleCorner.Parent = RebirthToggleFrame

local RebirthToggleButton = Instance.new("TextButton")
RebirthToggleButton.Size = UDim2.new(0, 21, 0, 21)
RebirthToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
RebirthToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
RebirthToggleButton.Text = ""
RebirthToggleButton.Parent = RebirthToggleFrame

local RebirthButtonCorner = Instance.new("UICorner")
RebirthButtonCorner.CornerRadius = UDim.new(1, 0)
RebirthButtonCorner.Parent = RebirthToggleButton

-- Функции для анимации переключателей
local function updateOrbToggle()
    local goal = {
        Position = orbFarmEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = orbFarmEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    OrbToggleFrame.BackgroundColor3 = orbFarmEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(OrbToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function updateRebirthToggle()
    local goal = {
        Position = rebirthEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = rebirthEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    RebirthToggleFrame.BackgroundColor3 = rebirthEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(RebirthToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

-- Функции для фарма орбов
local orbThreads = {}

local function collectOrb(orbType)
    local args = {
        [1] = "collectOrb",
        [2] = orbType, -- Orb type ("Red Orb" or "Gem")
        [3] = "City"
    }

    while orbFarmEnabled and task.wait(0) do
        orbEvent:FireServer(unpack(args))
    end
end

local function startOrbFarm()
    -- Останавливаем предыдущие потоки
    for _, thread in ipairs(orbThreads) do
        coroutine.close(thread)
    end
    orbThreads = {}

    if orbFarmEnabled then
        -- Запускаем новые потоки
        for i = 1, 50 do -- Adjust number of concurrent executions 
            table.insert(orbThreads, coroutine.create(function() collectOrb("Red Orb") end))
            table.insert(orbThreads, coroutine.create(function() collectOrb("Gem") end))
        end

        -- Запускаем все потоки
        for _, thread in ipairs(orbThreads) do
            coroutine.resume(thread)
        end
    end
end

-- Функция для ребитхов
local rebirthThread

local function autoRebirth()
    local args = {
        [1] = "rebirthRequest"
    }

    while rebirthEnabled and task.wait(1) do
        rebirthEvent:FireServer(unpack(args))
    end
end

local function startRebirth()
    -- Останавливаем предыдущий поток
    if rebirthThread then
        coroutine.close(rebirthThread)
    end

    if rebirthEnabled then
        rebirthThread = coroutine.create(autoRebirth)
        coroutine.resume(rebirthThread)
    end
end

-- Функция минимизации
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"  
    else
        MainFrame.Size = UDim2.new(0, 180, 0, 130)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"  
    end
end

-- Обработчики кликов по переключателям
OrbToggleButton.MouseButton1Click:Connect(function()
    orbFarmEnabled = not orbFarmEnabled
    updateOrbToggle()
    startOrbFarm()
end)

RebirthToggleButton.MouseButton1Click:Connect(function()
    rebirthEnabled = not rebirthEnabled
    updateRebirthToggle()
    startRebirth()
end)

-- Обработчик кнопки минимизации
MinimizeButton.MouseButton1Click:Connect(function()
    toggleMinimize()
end)

-- Обработчик кнопки закрытия
CloseButton.MouseButton1Click:Connect(function()
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Size = UDim2.new(0, 220, 0, 100)
    MessageFrame.Position = UDim2.new(0.5, -110, 0.5, -60)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MessageFrame.BackgroundTransparency = 0.2
    MessageFrame.Parent = ScreenGui
    
    local MessageCorner = Instance.new("UICorner")
    MessageCorner.CornerRadius = UDim.new(0, 8)
    MessageCorner.Parent = MessageFrame
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 0, 50)
    MessageLabel.Position = UDim2.new(0, 10, 0, 10)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = "Вы уверены, что хотите закрыть меню?"
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = MessageFrame
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, -20, 0, 30)
    ButtonContainer.Position = UDim2.new(0, 10, 1, -40)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = MessageFrame
    
    local YesButton = Instance.new("TextButton")
    YesButton.Size = UDim2.new(0.45, 0, 1, 0)
    YesButton.Position = UDim2.new(0, 0, 0, 0)
    YesButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    YesButton.Text = "Да"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.GothamMedium
    YesButton.TextSize = 14
    YesButton.Parent = ButtonContainer
    
    local NoButton = Instance.new("TextButton")
    NoButton.Size = UDim2.new(0.45, 0, 1, 0)
    NoButton.Position = UDim2.new(0.55, 0, 0, 0)
    NoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    NoButton.Text = "Нет"
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.GothamMedium
    NoButton.TextSize = 14
    NoButton.Parent = ButtonContainer
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = YesButton
    ButtonCorner:Clone().Parent = NoButton
    
    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end)

-- Инициализация переключателей
updateOrbToggle()
updateRebirthToggle()
