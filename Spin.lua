local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 80)
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

-- Кнопка Spin
local SpinButton = Instance.new("TextButton")
SpinButton.Size = UDim2.new(1, 0, 0, 25)
SpinButton.Position = UDim2.new(0, 0, 0, 5)
SpinButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
SpinButton.Text = "Spin Control ▼"
SpinButton.TextColor3 = Color3.fromRGB(220, 220, 220)
SpinButton.Font = Enum.Font.Gotham
SpinButton.TextSize = 12
SpinButton.Parent = ContentFrame

local SpinButtonCorner = Instance.new("UICorner")
SpinButtonCorner.CornerRadius = UDim.new(0, 4)
SpinButtonCorner.Parent = SpinButton

-- Фрейм управления Spin
local SpinFrame = Instance.new("Frame")
SpinFrame.Size = UDim2.new(1, 0, 0, 0)
SpinFrame.Position = UDim2.new(0, 0, 0, 30)
SpinFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpinFrame.ClipsDescendants = true
SpinFrame.Visible = false
SpinFrame.Parent = ContentFrame

local SpinContainer = Instance.new("Frame")
SpinContainer.Size = UDim2.new(1, 0, 1, 0)
SpinContainer.BackgroundTransparency = 1
SpinContainer.Parent = SpinFrame

local SpinLayout = Instance.new("UIListLayout")
SpinLayout.Padding = UDim.new(0, 5)
SpinLayout.Parent = SpinContainer

-- Поле ввода скорости
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 25)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
SpeedInput.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedInput.PlaceholderText = "Enter spin speed"
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 12
SpeedInput.Text = "50" -- Значение по умолчанию
SpeedInput.Parent = SpinContainer

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 4)
SpeedInputCorner.Parent = SpeedInput

-- Кнопка запуска
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, 0, 0, 25)
SubmitButton.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
SubmitButton.TextColor3 = Color3.fromRGB(220, 220, 220)
SubmitButton.Text = "START SPIN"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 12
SubmitButton.Parent = SpinContainer

local SubmitButtonCorner = Instance.new("UICorner")
SubmitButtonCorner.CornerRadius = UDim.new(0, 4)
SubmitButtonCorner.Parent = SubmitButton

-- Переменные для спина
local spinning = false
local spinSpeed = 50
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Обработчик кнопки Spin
local isSpinFrameVisible = false
SpinButton.MouseButton1Click:Connect(function()
    isSpinFrameVisible = not isSpinFrameVisible
    
    if isSpinFrameVisible then
        SpinButton.Text = "Spin Control ▲"
        SpinFrame.Visible = true
        SpinFrame.Size = UDim2.new(1, 0, 0, 55)
        MainFrame.Size = UDim2.new(0, 180, 0, 80 + 55)
    else
        SpinButton.Text = "Spin Control ▼"
        SpinFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
    end
end)

-- Функция для управления спином
SubmitButton.MouseButton1Click:Connect(function()
    if not spinning then
        spinSpeed = tonumber(SpeedInput.Text) or 50
        spinning = true
        SubmitButton.Text = "STOP SPIN"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(120, 60, 60)
    else
        spinning = false
        SubmitButton.Text = "START SPIN"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
    end
end)

-- Обновление персонажа при возрождении
LocalPlayer.CharacterAdded:Connect(function(newChar)
    character = newChar
end)

-- Логика вращения
RunService.RenderStepped:Connect(function()
    if spinning and character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
    end
end)

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ContentFrame.Visible = false
        SpinFrame.Visible = false
        isSpinFrameVisible = false
        SpinButton.Text = "Spin Control ▼"
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
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
