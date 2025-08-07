local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local SpeedGUI = Instance.new("ScreenGui")
SpeedGUI.Name = "VanegoodSpeedGUI"
SpeedGUI.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 100)
MainFrame.Position = UDim2.new(0.5, -90, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = SpeedGUI

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
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

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

-- Контентная область
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -35)
ContentFrame.Position = UDim2.new(0, 10, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Поле ввода скорости
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 30)
SpeedInput.Position = UDim2.new(0, 0, 0, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedInput.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedInput.PlaceholderText = "Enter speed"
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 14
SpeedInput.Parent = ContentFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

-- Кнопка установки скорости
local SetSpeedButton = Instance.new("TextButton")
SetSpeedButton.Size = UDim2.new(1, 0, 0, 30)
SetSpeedButton.Position = UDim2.new(0, 0, 0, 40)
SetSpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SetSpeedButton.TextColor3 = Color3.fromRGB(220, 220, 220)
SetSpeedButton.Text = "Set Speed"
SetSpeedButton.Font = Enum.Font.GothamBold
SetSpeedButton.TextSize = 14
SetSpeedButton.Parent = ContentFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = SetSpeedButton

-- Функция установки скорости
local function setSpeed(speed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end

-- Обработчик кнопки установки скорости
SetSpeedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedInput.Text)
    if speed then
        setSpeed(speed)
    end
end)

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 180, 0, 100)
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
    MessageFrame.Parent = SpeedGUI
    
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
        SpeedGUI:Destroy()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end

-- Обработчик кнопки минимизации
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Обработчик кнопки закрытия
CloseButton.MouseButton1Click:Connect(createConfirmationDialog)

-- Инициализация
setSpeed(16)

