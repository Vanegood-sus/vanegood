local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 80)
MainFrame.Position = UDim2.new(0.5, -125, 0, 20)
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

-- Две кнопки в ряд
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 0, 25)
ButtonContainer.Position = UDim2.new(0, 0, 0, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = ContentFrame

-- Кнопка телепорта
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.48, 0, 1, 0)
TeleportButton.Position = UDim2.new(0, 0, 0, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.TextSize = 12
TeleportButton.Parent = ButtonContainer

local TeleportButtonCorner = Instance.new("UICorner")
TeleportButtonCorner.CornerRadius = UDim.new(0, 4)
TeleportButtonCorner.Parent = TeleportButton

-- Кнопка автофарма
local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0.48, 0, 1, 0)
FarmButton.Position = UDim2.new(0.52, 0, 0, 0)
FarmButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
FarmButton.Text = "Autofarm"
FarmButton.TextColor3 = Color3.fromRGB(220, 220, 220)
FarmButton.Font = Enum.Font.Gotham
FarmButton.TextSize = 12
FarmButton.Parent = ButtonContainer

local FarmButtonCorner = Instance.new("UICorner")
FarmButtonCorner.CornerRadius = UDim.new(0, 4)
FarmButtonCorner.Parent = FarmButton

-- Координаты команд
local TeamCoordinates = {
    White = {X = -51, Y = -8.75, Z = -502.73},
    Red = {X = 376.3, Y = -8.75, Z = -65.47},
    Black = {X = -483.05, Y = -8.75, Z = -68.65},
    Blue = {X = 377.13, Y = -8.75, Z = 299.43},
    Green = {X = -484.24, Y = -8.75, Z = 294.84},
    Pink = {X = 377.50, Y = -8.75, Z = 646.60},
    Yellow = {X = -485.49, Y = -8.75, Z = 641.32}
}

-- Меню телепорта
local TeamsFrame = Instance.new("Frame")
TeamsFrame.Size = UDim2.new(1, 0, 0, 0)
TeamsFrame.Position = UDim2.new(0, 0, 0, 30)
TeamsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TeamsFrame.ClipsDescendants = true
TeamsFrame.Visible = false
TeamsFrame.Parent = ContentFrame

local TeamsList = Instance.new("ScrollingFrame")
TeamsList.Size = UDim2.new(1, 0, 1, 0)
TeamsList.Position = UDim2.new(0, 0, 0, 0)
TeamsList.BackgroundTransparency = 1
TeamsList.CanvasSize = UDim2.new(0, 0, 0, 0)
TeamsList.ScrollBarThickness = 3
TeamsList.Parent = TeamsFrame

local TeamsListLayout = Instance.new("UIListLayout")
TeamsListLayout.Padding = UDim.new(0, 5)
TeamsListLayout.Parent = TeamsList

TeamsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TeamsList.CanvasSize = UDim2.new(0, 0, 0, TeamsListLayout.AbsoluteContentSize.Y)
    TeamsFrame.Size = UDim2.new(1, 0, 0, math.min(TeamsListLayout.AbsoluteContentSize.Y, 200))
    MainFrame.Size = UDim2.new(0, 250, 0, 120 + math.min(TeamsListLayout.AbsoluteContentSize.Y, 200))
end)

-- Создаем кнопки для команд в 2 колонки
local TeamButtons = {}
local Column1 = Instance.new("Frame")
Column1.Size = UDim2.new(0.48, 0, 1, 0)
Column1.Position = UDim2.new(0, 0, 0, 0)
Column1.BackgroundTransparency = 1
Column1.Parent = TeamsList

local Column2 = Instance.new("Frame")
Column2.Size = UDim2.new(0.48, 0, 1, 0)
Column2.Position = UDim2.new(0.52, 0, 0, 0)
Column2.BackgroundTransparency = 1
Column2.Parent = TeamsList

local Column1Layout = Instance.new("UIListLayout")
Column1Layout.Padding = UDim.new(0, 5)
Column1Layout.Parent = Column1

local Column2Layout = Instance.new("UIListLayout")
Column2Layout.Padding = UDim.new(0, 5)
Column2Layout.Parent = Column2

local teamOrder = {"White", "Red", "Black", "Blue", "Green", "Pink", "Yellow"}

for i, teamName in ipairs(teamOrder) do
    local column = i % 2 == 1 and Column1 or Column2
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 25)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = teamName
    button.Parent = column
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        teamTeleport(TeamCoordinates[teamName])
    end)
    
    TeamButtons[teamName] = button
end

-- Функция телепортации для команд (мгновенная)
local function teamTeleport(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y + 3, position.Z)
    end
end

-- Меню автофарма
local FarmFrame = Instance.new("Frame")
FarmFrame.Size = UDim2.new(1, 0, 0, 25)
FarmFrame.Position = UDim2.new(0, 0, 0, 30)
FarmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
FarmFrame.ClipsDescendants = true
FarmFrame.Visible = false
FarmFrame.Parent = ContentFrame

local StartFarmButton = Instance.new("TextButton")
StartFarmButton.Size = UDim2.new(1, -10, 1, -5)
StartFarmButton.Position = UDim2.new(0, 5, 0, 2.5)
StartFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
StartFarmButton.TextColor3 = Color3.fromRGB(220, 220, 220)
StartFarmButton.Font = Enum.Font.Gotham
StartFarmButton.TextSize = 12
StartFarmButton.Text = "Start Farm"
StartFarmButton.Parent = FarmFrame

local StartFarmButtonCorner = Instance.new("UICorner")
StartFarmButtonCorner.CornerRadius = UDim.new(0, 4)
StartFarmButtonCorner.Parent = StartFarmButton

-- Автофарм из первого скрипта
local autoFarming = false
local flySpeed = 390.45 -- Fly speed for 1400 km/h (updated speed)
local flyDuration = 21 -- Flying duration in seconds
local centerPosition = Vector3.new(0, 100, 0) -- Center of the map
local chestPosition = Vector3.new(15, -5, 9495) -- Chest position
local bodyVelocity -- Variable to manage flying
local totalCoins = 0 -- Coins counter
local antiAFKEnabled = false -- Anti-AFK toggle state

-- Auto Farm Functionality
local function startAutoFarm()
    spawn(function()
        while autoFarming do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Teleport to the center of the map
                hrp.CFrame = CFrame.new(centerPosition)
                
                -- Enable noclip
                enableNoclip(character)
                
                -- Fly with boosted speed
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVelocity.Velocity = Vector3.new(0, 0, flySpeed)
                bodyVelocity.Parent = hrp
                
                -- Allow flying for a fixed duration
                wait(flyDuration)
                
                -- Stop flying and destroy the velocity object
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
                
                -- Adjust position slightly and teleport to chest
                hrp.CFrame = CFrame.new(chestPosition)
                
                -- Kill the player to end the farm cycle
                character:BreakJoints()
                
                -- Increment coins after death
                if totalCoins < 10000000 then
                    totalCoins = totalCoins + 100
                end
                
                -- Wait for the player to respawn before restarting the loop
                wait(9) -- Adjust respawn wait time as necessary
            end
        end
    end)
end

-- Stop flying (when Auto Farm is stopped)
local function stopFlying()
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
end

-- Teleport to team base when Auto Farm is stopped
local function teleportToTeamBase()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Replace with your team base position
        local teamBasePosition = Vector3.new(0, 10, 0) -- Change to your desired coordinates
        hrp.CFrame = CFrame.new(teamBasePosition)
    end
end

-- Enable noclip (No Collision)
local function enableNoclip(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Anti-AFK Functionality
local function startAntiAFK()
    spawn(function()
        while antiAFKEnabled do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Simulate movement to avoid AFK detection
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, math.random(-1, 1))
            end
            wait(2) -- Move every 2 seconds
        end
    end)
end

-- Обработчики кнопок
TeleportButton.MouseButton1Click:Connect(function()
    TeamsFrame.Visible = not TeamsFrame.Visible
    FarmFrame.Visible = false
end)

FarmButton.MouseButton1Click:Connect(function()
    FarmFrame.Visible = not FarmFrame.Visible
    TeamsFrame.Visible = false
end)

StartFarmButton.MouseButton1Click:Connect(function()
    autoFarming = not autoFarming
    
    if autoFarming then
        StartFarmButton.Text = "Stop Farm"
        StartFarmButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        startAutoFarm()
    else
        StartFarmButton.Text = "Start Farm"
        StartFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        stopFlying()
        teleportToTeamBase()
    end
end)

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 250, 0, 25)
        ContentFrame.Visible = false
        TeamsFrame.Visible = false
        FarmFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 250, 0, 80)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end

MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

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

-- Обработчик кнопки закрытия
CloseButton.MouseButton1Click:Connect(createConfirmationDialog)

-- Анти-АФК
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Изначально скрываем вкладки
TeamsFrame.Visible = false
FarmFrame.Visible = false
