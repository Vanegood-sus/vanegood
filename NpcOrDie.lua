local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Настройки функций
local autoTaskEnabled = false
local autoParkourEnabled = false
local minimized = false

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 120) -- Увеличил высоту для двух переключателей
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
Title.Font = Enum.Font.GothamBold
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

-- Функция для создания переключателя
local function createToggle(parent, name, yPosition)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Size = UDim2.new(1, 0, 0, 30)
    ToggleContainer.Position = UDim2.new(0, 0, 0, yPosition)
    ToggleContainer.BackgroundTransparency = 1
    ToggleContainer.Parent = parent

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, 100, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
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

    return ToggleButton, ToggleFrame
end

-- Создаем переключатели
local AutoTaskToggle, AutoTaskFrame = createToggle(ContentFrame, "Auto Task", 0)
local AutoParkourToggle, AutoParkourFrame = createToggle(ContentFrame, "Auto Parkour", 35)

-- Функция для анимации переключателя
local function updateToggle(button, frame, enabled)
    local goal = {
        Position = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = enabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    frame.BackgroundColor3 = enabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(button, TweenInfo.new(0.2), goal)
    tween:Play()
end

-- Auto Task функция
local function autoTask()
    while autoTaskEnabled do
        local char = LocalPlayer.Character
        if char then
            local humPart = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChild("Humanoid")
            
            if humPart and humanoid then
                local taskName = char:GetAttribute("TaskName")
                if taskName and taskName ~= "" then
                    for _, task in pairs(workspace:GetDescendants()) do
                        if not autoTaskEnabled then break end
                        if task:IsA("ProximityPrompt") and task.Parent and task.Parent.Name == taskName then
                            task.HoldDuration = 0
                            task:InputHoldBegin()
                            task:InputHoldEnd()
                            wait(0.1)
                        end
                    end
                end
            end
        end
        wait(0.5)
    end
end

-- Auto Parkour функция
local function autoParkour()
    while autoParkourEnabled do
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Team and LocalPlayer.Team.Name == "Lobby" then
                local obbyEnd = workspace:FindFirstChild("Lobby"):FindFirstChild("Obby"):FindFirstChild("ObbyEndPart")
                if obbyEnd then
                    firetouchinterest(char.HumanoidRootPart, obbyEnd, 0)
                    firetouchinterest(char.HumanoidRootPart, obbyEnd, 1)
                end
            end
        end
        wait(1)
    end
end

-- Обработчики переключателей
AutoTaskToggle.MouseButton1Click:Connect(function()
    autoTaskEnabled = not autoTaskEnabled
    updateToggle(AutoTaskToggle, AutoTaskFrame, autoTaskEnabled)
    if autoTaskEnabled then
        coroutine.wrap(autoTask)()
    end
end)

AutoParkourToggle.MouseButton1Click:Connect(function()
    autoParkourEnabled = not autoParkourEnabled
    updateToggle(AutoParkourToggle, AutoParkourFrame, autoParkourEnabled)
    if autoParkourEnabled then
        coroutine.wrap(autoParkour)()
    end
end)

-- Функция минимизации
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"  
    else
        MainFrame.Size = UDim2.new(0, 180, 0, 120)
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

-- Инициализация переключателей
updateToggle(AutoTaskToggle, AutoTaskFrame, autoTaskEnabled)
updateToggle(AutoParkourToggle, AutoParkourFrame, autoParkourEnabled)
