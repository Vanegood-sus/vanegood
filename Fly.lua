local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150) -- Увеличил размер для новых элементов
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

-- Кнопка полета
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(1, 0, 0, 30)
FlyButton.Position = UDim2.new(0, 0, 0, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
FlyButton.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyButton.Text = "Fly: Off"
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 14
FlyButton.Parent = ContentFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = FlyButton

-- Поле ввода скорости полета
local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Size = UDim2.new(1, 0, 0, 30)
FlySpeedBox.Position = UDim2.new(0, 0, 0, 40)
FlySpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FlySpeedBox.TextColor3 = Color3.fromRGB(220, 220, 220)
FlySpeedBox.PlaceholderText = "Fly Speed (default: 50)"
FlySpeedBox.Text = "50"
FlySpeedBox.Font = Enum.Font.Gotham
FlySpeedBox.TextSize = 14
FlySpeedBox.Parent = ContentFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = FlySpeedBox

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 25)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 150)
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

-- ========== ФУНКЦИОНАЛ ПОЛЕТА ========== --
local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
local buttonIsOn = false
local speed = 50
local bv, bg
local Signal1, Signal2, Signal3

local function setupCharacter(character)
    if character:FindFirstChild("HumanoidRootPart") then
        if character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
            character.HumanoidRootPart.VelocityHandler:Destroy()
        end
        if character.HumanoidRootPart:FindFirstChild("GyroHandler") then
            character.HumanoidRootPart.GyroHandler:Destroy()
        end
        
        bv = Instance.new("BodyVelocity")
        bv.Name = "VelocityHandler"
        bv.Parent = character.HumanoidRootPart
        bv.MaxForce = Vector3.new(0,0,0)
        bv.Velocity = Vector3.new(0,0,0)
        
        bg = Instance.new("BodyGyro")
        bg.Name = "GyroHandler"
        bg.Parent = character.HumanoidRootPart
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.P = 1000
        bg.D = 50
    end
end

-- Инициализация при старте
if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end

Signal1 = LocalPlayer.CharacterAdded:Connect(setupCharacter)

Signal2 = RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and 
       LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
       LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and 
       LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
        
        if buttonIsOn then
            FlyButton.Text = "Fly: On"
            FlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
            LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
            LocalPlayer.Character.Humanoid.PlatformStand = true
        else
            FlyButton.Text = "Fly: Off"
            FlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(0,0,0)
            LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(0,0,0)
            LocalPlayer.Character.Humanoid.PlatformStand = false
            return
        end
        
        local camera = workspace.CurrentCamera
        LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
        
        local direction = controlModule:GetMoveVector()
        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
        
        if direction.X > 0 then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*speed)
        end
        if direction.X < 0 then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*speed)
        end
        if direction.Z > 0 then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*speed)
        end
        if direction.Z < 0 then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*speed)
        end
    end
end)

FlyButton.MouseButton1Click:Connect(function()
    buttonIsOn = not buttonIsOn
end)

Signal3 = FlySpeedBox:GetPropertyChangedSignal("Text"):Connect(function()
    if tonumber(FlySpeedBox.Text) then
        speed = tonumber(FlySpeedBox.Text)
    end
end)

-- Обработчик команды !stop в чате
LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower() == "!stop" then
        if Signal1 then Signal1:Disconnect() end
        if Signal2 then Signal2:Disconnect() end
        if Signal3 then Signal3:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
            if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
                LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
            end
            if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
            end
        end
        ScreenGui:Destroy()
    end
end)
