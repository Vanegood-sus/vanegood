local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Position = UDim2.new(0.5, -100, 0, 20)
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

-- Заголовок
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
ContentFrame.Size = UDim2.new(1, -20, 1, -35)
ContentFrame.Position = UDim2.new(0, 10, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Переключатель Aimbot
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(1, 0, 0, 30)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.Parent = ContentFrame

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0, 60, 1, 0)
ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Aimbot"
ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ToggleLabel.Font = Enum.Font.GothamMedium
ToggleLabel.TextSize = 14
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleContainer

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(0, 50, 0, 25)
ToggleFrame.Position = UDim2.new(1, -50, 0.5, -12)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleFrame.BorderSizePixel = 0
ToggleFrame.Parent = ToggleContainer

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 21, 0, 21)
ToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
ToggleButton.Text = ""
ToggleButton.Parent = ToggleFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = ToggleButton

-- Ползунок силы
local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, 0, 0, 30)
SliderContainer.Position = UDim2.new(0, 0, 0, 40)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Parent = ContentFrame

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(0, 60, 1, 0)
SliderLabel.Position = UDim2.new(0, 0, 0, 0)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Сила:"
SliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SliderLabel.Font = Enum.Font.GothamMedium
SliderLabel.TextSize = 14
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
SliderLabel.Parent = SliderContainer

-- Кнопка -10
local MinusButton = Instance.new("TextButton")
MinusButton.Size = UDim2.new(0, 30, 0, 20)
MinusButton.Position = UDim2.new(0, 60, 0.5, -10)
MinusButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinusButton.Text = "-10"
MinusButton.TextColor3 = Color3.fromRGB(220, 220, 220)
MinusButton.Font = Enum.Font.GothamMedium
MinusButton.TextSize = 12
MinusButton.Parent = SliderContainer

-- Процентное значение
local SliderValue = Instance.new("TextLabel")
SliderValue.Size = UDim2.new(0, 40, 1, 0)
SliderValue.Position = UDim2.new(0, 95, 0, 0)
SliderValue.BackgroundTransparency = 1
SliderValue.Text = "50%"
SliderValue.TextColor3 = Color3.fromRGB(220, 220, 220)
SliderValue.Font = Enum.Font.GothamMedium
SliderValue.TextSize = 14
SliderValue.Parent = SliderContainer

-- Кнопка +10
local PlusButton = Instance.new("TextButton")
PlusButton.Size = UDim2.new(0, 30, 0, 20)
PlusButton.Position = UDim2.new(0, 140, 0.5, -10)
PlusButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
PlusButton.Text = "+10"
PlusButton.TextColor3 = Color3.fromRGB(220, 220, 220)
PlusButton.Font = Enum.Font.GothamMedium
PlusButton.TextSize = 12
PlusButton.Parent = SliderContainer

-- Ползунок (под кнопками)
local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, -20, 0, 5)
SliderFrame.Position = UDim2.new(0, 10, 1, -8)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SliderFrame.BorderSizePixel = 0
SliderFrame.Parent = SliderContainer

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SliderFrame

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
SliderFill.Parent = SliderFrame

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(1, 0)
SliderFillCorner.Parent = SliderFill

-- Скругление кнопок
local SmallButtonCorner = Instance.new("UICorner")
SmallButtonCorner.CornerRadius = UDim.new(0, 4)
SmallButtonCorner.Parent = MinusButton
SmallButtonCorner:Clone().Parent = PlusButton

-- Переменные для Aimbot
local aimbotEnabled = false
local aimbotStrength = 0.5
local aimbotConnection

-- Функция для поиска ближайшего игрока
local function findNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                local distance = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPlayer = player.Character
                end
            end
        end
    end
    
    return nearestPlayer
end

-- Плавное прицеливание
local function smoothAim(target)
    if not target or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = LocalPlayer.Character.HumanoidRootPart
    local targetPosition = target.HumanoidRootPart.Position
    
    local currentCFrame = rootPart.CFrame
    local targetCFrame = CFrame.new(rootPart.Position, Vector3.new(targetPosition.X, rootPart.Position.Y, targetPosition.Z))
    rootPart.CFrame = currentCFrame:Lerp(targetCFrame, aimbotStrength * 0.1)
end

-- Обновление переключателя
local function updateToggle()
    local goal = {
        Position = aimbotEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    ToggleFrame.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

-- Обновление ползунка
local function updateSlider(value)
    aimbotStrength = math.clamp(value, 0.1, 1.0)
    SliderFill.Size = UDim2.new(aimbotStrength, 0, 1, 0)
    SliderValue.Text = math.floor(aimbotStrength * 100) .. "%"
end

-- Обработчик переключателя
ToggleButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    updateToggle()
    
    if aimbotEnabled then
        aimbotConnection = RunService.Heartbeat:Connect(function()
            local target = findNearestPlayer()
            if target then
                smoothAim(target)
            end
        end)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    end
end)

-- Обработчик ползунка
local function onSliderInput(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local sliderPos = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
        updateSlider(sliderPos)
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                connection:Disconnect()
            else
                local sliderPos = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                updateSlider(sliderPos)
            end
        end)
    end
end

SliderFrame.InputBegan:Connect(onSliderInput)

-- Обработчики кнопок +10/-10
MinusButton.MouseButton1Click:Connect(function()
    updateSlider(aimbotStrength - 0.1)
end)

PlusButton.MouseButton1Click:Connect(function()
    updateSlider(aimbotStrength + 0.1)
end)

-- Инициализация
updateToggle()
updateSlider(0.5)

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 25)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 180)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end

-- Функция создания окна подтверждения
local function createConfirmationDialog()
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
        if aimbotConnection then aimbotConnection:Disconnect() end
        ScreenGui:Destroy()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end

-- Обработчик кнопки минимизации
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Обработчик кнопки закрытия
CloseButton.MouseButton1Click:Connect(createConfirmationDialog)
