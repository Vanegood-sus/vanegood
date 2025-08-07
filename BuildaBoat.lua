local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 105) -- Увеличена начальная высота
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

-- Координаты точек фарма (по порядку)
local FarmSpots = {
    {X = -100, Y = 85, Z = 1365},   -- 1
    {X = -100, Y = 85, Z = 2140},   -- 2
    {X = -100, Y = 85, Z = 2910},   -- 3
    {X = -100, Y = 85, Z = 3670},   -- 4
    {X = -100, Y = 85, Z = 4455},   -- 5
    {X = -100, Y = 85, Z = 5210},   -- 6
    {X = -100, Y = 85, Z = 5980},   -- 7
    {X = -100, Y = 85, Z = 6758},   -- 8
    {X = -100, Y = 85, Z = 7535},   -- 9
    {X = -100, Y = 85, Z = 8300},   -- 10
    {X = -50,  Y = -360, Z = 9490}  -- 11 (сундук)
}

-- Создаем платформы для каждой точки фарма (кроме последней)
local Platforms = {}
for i = 1, #FarmSpots - 1 do
    local spot = FarmSpots[i]
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(15, 1, 15)
    platform.Position = Vector3.new(spot.X, spot.Y - 3, spot.Z)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Transparency = 1
    platform.Name = "FarmPlatform_" .. i
    platform.Parent = workspace
    Platforms[i] = platform
end

-- Функция телепортации для команд (мгновенная)
local function teamTeleport(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y + 3, position.Z)
    end
end

-- Функция плавного перелета между точками
local function smoothFlyTo(targetPos, duration)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        return 
    end
    
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local startPos = hrp.Position
    local startTime = os.clock()
    
    while os.clock() - startTime < duration do
        if not isFarming or not hrp then break end
        
        local t = (os.clock() - startTime) / duration
        local currentPos = startPos:Lerp(targetPos, t)
        hrp.CFrame = CFrame.new(currentPos)
        RunService.Heartbeat:Wait()
    end
    
    if hrp then
        hrp.CFrame = CFrame.new(targetPos)
    end
end

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

-- Добавляем отступы для красоты
local TeamsListPadding = Instance.new("UIPadding")
TeamsListPadding.PaddingLeft = UDim.new(0, 5)
TeamsListPadding.PaddingRight = UDim.new(0, 5)
TeamsListPadding.PaddingTop = UDim.new(0, 5)
TeamsListPadding.PaddingBottom = UDim.new(0, 5)
TeamsListPadding.Parent = TeamsList

TeamsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TeamsList.CanvasSize = UDim2.new(0, 0, 0, TeamsListLayout.AbsoluteContentSize.Y)
    TeamsFrame.Size = UDim2.new(1, 0, 0, math.min(TeamsListLayout.AbsoluteContentSize.Y, 200))
    MainFrame.Size = UDim2.new(0, 250, 0, 105 + math.min(TeamsListLayout.AbsoluteContentSize.Y, 200))
end)

-- Заголовок для меню команд
local TeamsTitle = Instance.new("TextLabel")
TeamsTitle.Size = UDim2.new(1, -10, 0, 20)
TeamsTitle.Position = UDim2.new(0, 5, 0, 5)
TeamsTitle.BackgroundTransparency = 1
TeamsTitle.Text = "Select Team:"
TeamsTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
TeamsTitle.Font = Enum.Font.Gotham
TeamsTitle.TextSize = 12
TeamsTitle.TextXAlignment = Enum.TextXAlignment.Left
TeamsTitle.Parent = TeamsFrame
TeamsList.Position = UDim2.new(0, 0, 0, 25)
TeamsList.Size = UDim2.new(1, 0, 1, -25)

-- Создаем кнопки для команд
for teamName, _ in pairs(TeamCoordinates) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30) -- Увеличена высота
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = teamName
    button.TextXAlignment = Enum.TextXAlignment.Center -- Выравнивание по центру
    button.Parent = TeamsList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        teamTeleport(TeamCoordinates[teamName])
    end)
end

-- Меню автофарма
local FarmFrame = Instance.new("Frame")
FarmFrame.Size = UDim2.new(1, 0, 0, 25)
FarmFrame.Position = UDim2.new(0, 0, 0, 30)
FarmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
FarmFrame.ClipsDescendants = true
FarmFrame.Visible = true -- По умолчанию открыта
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

-- Автофарм
local isFarming = false
local currentFarmSpot = 1

local function resetCharacter()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
    repeat 
        task.wait(0.1) 
    until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    task.wait(0.5)
end

local function farmLoop()
    while isFarming do
        resetCharacter()
        task.wait(1)
        
        for i = 1, #FarmSpots do
            if not isFarming then break end
            
            -- Проверка на респавн во время фарма
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                resetCharacter()
                task.wait(1)
                i = i - 1 -- Повторяем текущую точку
                continue
            end
            
            currentFarmSpot = i
            local spot = FarmSpots[i]
            
            -- Определяем цель телепортации
            local targetPos
            if i <= #FarmSpots - 1 and Platforms[i] then
                targetPos = Platforms[i].Position + Vector3.new(0, 3, 0)
            else
                targetPos = Vector3.new(spot.X, spot.Y + 3, spot.Z)
            end
            
            -- Плавный перелет к точке
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - targetPos).Magnitude
            local flyDuration = math.max(5, distance / 100)
            
            smoothFlyTo(targetPos, flyDuration)
            
            -- Ждем 2 секунды на точке
            local waitStart = os.clock()
            while os.clock() - waitStart < 2 and isFarming do
                task.wait(0.1)
            end
        end
    end
end

-- Обработчики кнопок
TeleportButton.MouseButton1Click:Connect(function()
    TeamsFrame.Visible = not TeamsFrame.Visible
    FarmFrame.Visible = false
    
    -- Изменение размера окна
    if TeamsFrame.Visible then
        TeamsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Wait()
        MainFrame.Size = UDim2.new(0, 250, 0, 105 + math.min(TeamsListLayout.AbsoluteContentSize.Y, 200))
    else
        MainFrame.Size = UDim2.new(0, 250, 0, 105)
    end
end)

FarmButton.MouseButton1Click:Connect(function()
    FarmFrame.Visible = not FarmFrame.Visible
    TeamsFrame.Visible = false
    
    -- Изменение размера окна
    if FarmFrame.Visible then
        MainFrame.Size = UDim2.new(0, 250, 0, 105)
    else
        MainFrame.Size = UDim2.new(0, 250, 0, 80)
    end
end)

StartFarmButton.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    
    if isFarming then
        StartFarmButton.Text = "Stop Farm"
        StartFarmButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        coroutine.wrap(farmLoop)()
    else
        StartFarmButton.Text = "Start Farm"
        StartFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
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
        MainFrame.Size = UDim2.new(0, 250, 0, 105)
        ContentFrame.Visible = true
        FarmFrame.Visible = true -- Восстанавливаем вкладку фарма
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

-- Изначально открыта вкладка автофарма
TeamsFrame.Visible = false
FarmFrame.Visible = true
MainFrame.Size = UDim2.new(0, 250, 0, 105) -- Размер с открытой вкладкой фарма
