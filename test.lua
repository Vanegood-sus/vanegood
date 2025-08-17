-- Vanegood Hub for Muscle Legends
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local player = LocalPlayer
local startTime = os.time()
local startRebirths = player.leaderstats.Rebirths.Value
local displayName = player.DisplayName

-- Удаляем старый хаб, если он существует
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем кнопку с фоткой
local TinyImageGui = Instance.new("ScreenGui")
TinyImageGui.Name = "TinyDraggableImage"
TinyImageGui.Parent = CoreGui
TinyImageGui.ResetOnSpawn = false

-- Размеры изображения
local imageSize = 75
local imageFrame = Instance.new("Frame")
imageFrame.Name = "TinyRoundedImage"
imageFrame.Size = UDim2.new(0, imageSize, 0, imageSize)
imageFrame.Position = UDim2.new(0, 20, 0, 20)
imageFrame.BackgroundTransparency = 1
imageFrame.ClipsDescendants = true
imageFrame.Parent = TinyImageGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.25, 0)
uiCorner.Parent = imageFrame

local image = Instance.new("ImageLabel")
image.Name = "Image"
image.Image = "rbxassetid://111084287166716"
image.Size = UDim2.new(1, 0, 1, 0)
image.BackgroundTransparency = 1
image.BorderSizePixel = 0
image.Parent = imageFrame

-- Перетаскивание
local touchStartPos, frameStartPos
local isDragging = false

imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        touchStartPos = input.Position
        frameStartPos = imageFrame.Position
    end
end)

imageFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - touchStartPos
        imageFrame.Position = UDim2.new(
            frameStartPos.X.Scale,
            frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale,
            frameStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Основное окно хаба
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Оранжевая обводка
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 2, 1, 2)
Border.Position = UDim2.new(0, -1, 0, -1)
Border.BackgroundTransparency = 1
Border.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 165, 50)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = Border

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "VANEGOOD HUB"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Кнопка закрытия (оранжевая)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации (оранжевая)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Панель вкладок
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.Parent = MainFrame

-- Вкладки
local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(0.2, 0, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainTab.Text = "МЕНЮ"
MainTab.TextColor3 = Color3.fromRGB(220, 220, 220)
MainTab.Font = Enum.Font.GothamBold
MainTab.TextSize = 12
MainTab.Parent = TabBar

local FarmTab = Instance.new("TextButton")
FarmTab.Size = UDim2.new(0.2, 0, 1, 0)
FarmTab.Position = UDim2.new(0.2, 0, 0, 0)
FarmTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FarmTab.Text = "ФАРМ"
FarmTab.TextColor3 = Color3.fromRGB(180, 180, 180)
FarmTab.Font = Enum.Font.GothamBold
FarmTab.TextSize = 12
FarmTab.Parent = TabBar

local PetsTab = Instance.new("TextButton")
PetsTab.Size = UDim2.new(0.2, 0, 1, 0)
PetsTab.Position = UDim2.new(0.4, 0, 0, 0)
PetsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PetsTab.Text = "ПЕТЫ"
PetsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
PetsTab.Font = Enum.Font.GothamBold
PetsTab.TextSize = 12
PetsTab.Parent = TabBar

local KillTab = Instance.new("TextButton")
KillTab.Size = UDim2.new(0.2, 0, 1, 0)
KillTab.Position = UDim2.new(0.6, 0, 0, 0)
KillTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KillTab.Text = "УБИЙСТВА"
KillTab.TextColor3 = Color3.fromRGB(180, 180, 180)
KillTab.Font = Enum.Font.GothamBold
KillTab.TextSize = 12
KillTab.Parent = TabBar

local TeleportTab = Instance.new("TextButton")
TeleportTab.Size = UDim2.new(0.2, 0, 1, 0)
TeleportTab.Position = UDim2.new(0.8, 0, 0, 0)
TeleportTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TeleportTab.Text = "ТЕЛЕПОРТ"
TeleportTab.TextColor3 = Color3.fromRGB(180, 180, 180)
TeleportTab.Font = Enum.Font.GothamBold
TeleportTab.TextSize = 12
TeleportTab.Parent = TabBar

-- Индикатор вкладки (оранжевый)
local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(0.2, 0, 0, 2)
ActiveTabIndicator.Position = UDim2.new(0, 0, 1, -2)
ActiveTabIndicator.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
ActiveTabIndicator.Parent = TabBar

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Фреймы для контента
local MainFrameContent = Instance.new("ScrollingFrame")
MainFrameContent.Size = UDim2.new(1, 0, 1, 0)
MainFrameContent.Position = UDim2.new(0, 0, 0, 0)
MainFrameContent.BackgroundTransparency = 1
MainFrameContent.ScrollBarThickness = 3
MainFrameContent.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
MainFrameContent.Visible = true
MainFrameContent.Parent = ContentFrame

local FarmFrame = Instance.new("ScrollingFrame")
FarmFrame.Size = UDim2.new(1, 0, 1, 0)
FarmFrame.Position = UDim2.new(0, 0, 0, 0)
FarmFrame.BackgroundTransparency = 1
FarmFrame.ScrollBarThickness = 3
FarmFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
FarmFrame.Visible = false
FarmFrame.Parent = ContentFrame

local PetsFrame = Instance.new("ScrollingFrame")
PetsFrame.Size = UDim2.new(1, 0, 1, 0)
PetsFrame.Position = UDim2.new(0, 0, 0, 0)
PetsFrame.BackgroundTransparency = 1
PetsFrame.ScrollBarThickness = 3
PetsFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
PetsFrame.Visible = false
PetsFrame.Parent = ContentFrame

local KillFrame = Instance.new("ScrollingFrame")
KillFrame.Size = UDim2.new(1, 0, 1, 0)
KillFrame.Position = UDim2.new(0, 0, 0, 0)
KillFrame.BackgroundTransparency = 1
KillFrame.ScrollBarThickness = 3
KillFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
KillFrame.Visible = false
KillFrame.Parent = ContentFrame

local TeleportFrame = Instance.new("ScrollingFrame")
TeleportFrame.Size = UDim2.new(1, 0, 1, 0)
TeleportFrame.Position = UDim2.new(0, 0, 0, 0)
TeleportFrame.BackgroundTransparency = 1
TeleportFrame.ScrollBarThickness = 3
TeleportFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
TeleportFrame.Visible = false
TeleportFrame.Parent = ContentFrame

-- Добавляем UIListLayout для всех фреймов
for _, frame in pairs({MainFrameContent, FarmFrame, PetsFrame, KillFrame, TeleportFrame}) do
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 10)
    ListLayout.Parent = frame
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
end

-- Anti-AFK
local antiAFKEnabled = true
local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-АФК активирован")
    end)
end
setupAntiAFK()

local AntiAfkContainer = Instance.new("Frame")
AntiAfkContainer.Name = "AntiAfk"
AntiAfkContainer.Size = UDim2.new(1, -20, 0, 40)
AntiAfkContainer.Position = UDim2.new(0, 10, 0, 10)
AntiAfkContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AntiAfkContainer.BackgroundTransparency = 0.5
AntiAfkContainer.Parent = MainFrameContent

local AntiAfkCorner = Instance.new("UICorner")
AntiAfkCorner.CornerRadius = UDim.new(0, 6)
AntiAfkCorner.Parent = AntiAfkContainer

local AntiAfkLabel = Instance.new("TextLabel")
AntiAfkLabel.Name = "Label"
AntiAfkLabel.Size = UDim2.new(0, 120, 1, 0)
AntiAfkLabel.Position = UDim2.new(0, 10, 0, 0)
AntiAfkLabel.BackgroundTransparency = 1
AntiAfkLabel.Text = "Анти-АФК"
AntiAfkLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AntiAfkLabel.Font = Enum.Font.GothamBold
AntiAfkLabel.TextSize = 14
AntiAfkLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAfkLabel.Parent = AntiAfkContainer

local AntiAfkToggleFrame = Instance.new("Frame")
AntiAfkToggleFrame.Name = "ToggleFrame"
AntiAfkToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AntiAfkToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AntiAfkToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AntiAfkToggleFrame.Parent = AntiAfkContainer

local AntiAfkToggleCorner = Instance.new("UICorner")
AntiAfkToggleCorner.CornerRadius = UDim.new(1, 0)
AntiAfkToggleCorner.Parent = AntiAfkToggleFrame

local AntiAfkToggleButton = Instance.new("TextButton")
AntiAfkToggleButton.Name = "ToggleButton"
AntiAfkToggleButton.Size = UDim2.new(0, 21, 0, 21)
AntiAfkToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AntiAfkToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AntiAfkToggleButton.Text = ""
AntiAfkToggleButton.Parent = AntiAfkToggleFrame

local AntiAfkButtonCorner = Instance.new("UICorner")
AntiAfkButtonCorner.CornerRadius = UDim.new(1, 0)
AntiAfkButtonCorner.Parent = AntiAfkToggleButton

local function updateAfkToggle()
    local goal = {
        Position = antiAFKEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    AntiAfkToggleFrame.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(AntiAfkToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

AntiAfkToggleButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    if antiAFKEnabled then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
            print("Anti-AFK system disabled")
        end
    end
    updateAfkToggle()
end)
updateAfkToggle()

-- Auto Brawls
local AutoBrawlsContainer = Instance.new("Frame")
AutoBrawlsContainer.Name = "AutoBrawls"
AutoBrawlsContainer.Size = UDim2.new(1, -20, 0, 80)
AutoBrawlsContainer.Position = UDim2.new(0, 10, 0, 60)
AutoBrawlsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AutoBrawlsContainer.BackgroundTransparency = 0.5
AutoBrawlsContainer.Parent = MainFrameContent

local AutoBrawlsCorner = Instance.new("UICorner")
AutoBrawlsCorner.CornerRadius = UDim.new(0, 6)
AutoBrawlsCorner.Parent = AutoBrawlsContainer

local AutoBrawlsLabel = Instance.new("TextLabel")
AutoBrawlsLabel.Name = "Label"
AutoBrawlsLabel.Size = UDim2.new(0, 120, 0, 30)
AutoBrawlsLabel.Position = UDim2.new(0, 10, 0, 5)
AutoBrawlsLabel.BackgroundTransparency = 1
AutoBrawlsLabel.Text = "Авто бой"
AutoBrawlsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoBrawlsLabel.Font = Enum.Font.GothamBold
AutoBrawlsLabel.TextSize = 14
AutoBrawlsLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoBrawlsLabel.Parent = AutoBrawlsContainer

local autoWinBrawl = false
local AutoWinBrawlToggleFrame = Instance.new("Frame")
AutoWinBrawlToggleFrame.Name = "ToggleFrame"
AutoWinBrawlToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoWinBrawlToggleFrame.Position = UDim2.new(1, -60, 0, 35)
AutoWinBrawlToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoWinBrawlToggleFrame.Parent = AutoBrawlsContainer

local AutoWinBrawlToggleCorner = Instance.new("UICorner")
AutoWinBrawlToggleCorner.CornerRadius = UDim.new(1, 0)
AutoWinBrawlToggleCorner.Parent = AutoWinBrawlToggleFrame

local AutoWinBrawlToggleButton = Instance.new("TextButton")
AutoWinBrawlToggleButton.Name = "ToggleButton"
AutoWinBrawlToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoWinBrawlToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoWinBrawlToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoWinBrawlToggleButton.Text = ""
AutoWinBrawlToggleButton.Parent = AutoWinBrawlToggleFrame

local AutoWinBrawlButtonCorner = Instance.new("UICorner")
AutoWinBrawlButtonCorner.CornerRadius = UDim.new(1, 0)
AutoWinBrawlButtonCorner.Parent = AutoWinBrawlToggleButton

local function updateAutoWinBrawlToggle()
    local goal = {
        Position = autoWinBrawl and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = autoWinBrawl and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    AutoWinBrawlToggleFrame.BackgroundColor3 = autoWinBrawl and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(AutoWinBrawlToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local whitelist = {}
local function equipPunch()
    if not autoWinBrawl then return false end
    local character = player.Character
    if not character then return false end
    if character:FindFirstChild("Punch") then return true end
    local backpack = player.Backpack
    if not backpack then return false end
    for _, tool in pairs(backpack:GetChildren()) do
        if tool.ClassName == "Tool" and tool.Name == "Punch" then
            tool.Parent = character
            return true
        end
    end
    return false
end

local function isValidTarget(target)
    if not target or not target.Parent then return false end
    if target == player then return false end
    if whitelist[target.UserId] then return false end
    local character = target.Character
    if not character or not character.Parent then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart or not rootPart.Parent then return false end
    return true
end

local function isLocalPlayerReady()
    local character = player.Character
    if not character or not character.Parent then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local leftHand = character:FindFirstChild("LeftHand")
    local rightHand = character:FindFirstChild("RightHand")
    return (leftHand ~= nil or rightHand ~= nil)
end

local function safeTouchInterest(targetPart, localPart)
    if not targetPart or not targetPart.Parent or not localPart or not localPart.Parent then return false end
    local success, err = pcall(function()
        firetouchinterest(targetPart, localPart, 0)
        task.wait(0.01)
        firetouchinterest(targetPart, localPart, 1)
    end)
    return success
end

AutoWinBrawlToggleButton.MouseButton1Click:Connect(function()
    autoWinBrawl = not autoWinBrawl
    updateAutoWinBrawlToggle()
    if autoWinBrawl then
        task.spawn(function()
            while autoWinBrawl and task.wait(0.5) do
                if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end
            end
        end)
        task.spawn(function()
            while autoWinBrawl and task.wait(0.5) do
                equipPunch()
            end
        end)
        task.spawn(function()
            while autoWinBrawl and task.wait(0.1) do
                if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                    pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                    pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
                end
            end
        end)
        task.spawn(function()
            while autoWinBrawl and task.wait(0.05) do
                if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                    local character = player.Character
                    local leftHand = character:FindFirstChild("LeftHand")
                    local rightHand = character:FindFirstChild("RightHand")
                    for _, target in pairs(Players:GetPlayers()) do
                        pcall(function()
                            if isValidTarget(target) then
                                local targetRoot = target.Character.HumanoidRootPart
                                if leftHand then safeTouchInterest(targetRoot, leftHand) end
                                if rightHand then safeTouchInterest(targetRoot, rightHand) end
                            end
                        end)
                        task.wait(0.01)
                    end
                end
            end
        end)
        task.spawn(function()
            local lastPlayerCount = 0
            local stuckCounter = 0
            while autoWinBrawl and task.wait(1) do
                local currentPlayerCount = #Players:GetPlayers()
                if currentPlayerCount ~= lastPlayerCount then
                    stuckCounter = 0
                    lastPlayerCount = currentPlayerCount
                else
                    stuckCounter = stuckCounter + 1
                    if stuckCounter > 5 then
                        stuckCounter = 0
                        pcall(function()
                            local character = player.Character
                            if character and character:FindFirstChild("Punch") then
                                character.Punch.Parent = player.Backpack
                                task.wait(0.1)
                                equipPunch()
                            else
                                equipPunch()
                            end
                        end)
                    end
                end
            end
        end)
    end
end)
updateAutoWinBrawlToggle()

local AutoJoinBrawlToggleFrame = Instance.new("Frame")
AutoJoinBrawlToggleFrame.Name = "ToggleFrame"
AutoJoinBrawlToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoJoinBrawlToggleFrame.Position = UDim2.new(1, -60, 0, 60)
AutoJoinBrawlToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoJoinBrawlToggleFrame.Parent = AutoBrawlsContainer

local AutoJoinBrawlToggleCorner = Instance.new("UICorner")
AutoJoinBrawlToggleCorner.CornerRadius = UDim.new(1, 0)
AutoJoinBrawlToggleCorner.Parent = AutoJoinBrawlToggleFrame

local AutoJoinBrawlToggleButton = Instance.new("TextButton")
AutoJoinBrawlToggleButton.Name = "ToggleButton"
AutoJoinBrawlToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoJoinBrawlToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoJoinBrawlToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoJoinBrawlToggleButton.Text = ""
AutoJoinBrawlToggleButton.Parent = AutoJoinBrawlToggleFrame

local AutoJoinBrawlButtonCorner = Instance.new("UICorner")
AutoJoinBrawlButtonCorner.CornerRadius = UDim.new(1, 0)
AutoJoinBrawlButtonCorner.Parent = AutoJoinBrawlToggleButton

local autoJoinBrawl = false
local function updateAutoJoinBrawlToggle()
    local goal = {
        Position = autoJoinBrawl and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = autoJoinBrawl and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    AutoJoinBrawlToggleFrame.BackgroundColor3 = autoJoinBrawl and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(AutoJoinBrawlToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

AutoJoinBrawlToggleButton.MouseButton1Click:Connect(function()
    autoJoinBrawl = not autoJoinBrawl
    updateAutoJoinBrawlToggle()
    if autoJoinBrawl then
        task.spawn(function()
            while autoJoinBrawl and task.wait(0.5) do
                if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end
            end
        end)
    end
end)
updateAutoJoinBrawlToggle()

-- Farm Gyms
local workoutPositions = {
    ["Жим лежа"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Портал Короля"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
    },
    ["Жим с присяда"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Становая тяга"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Поднимать камень"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    }
}

local workoutTypes = {
    "Жим лежа",
    "Жим с присяда",
    "Становая тяга",
    "Поднимать камень"
}

local gymLocations = {
    "Портал Ад",
    "Портал Легенды",
    "Портал Короля"
}

local gymToggles = {}
local function teleportAndStart(workoutType, position)
    if not position then return end
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = position
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Телепортирован в зал " .. workoutType,
        Duration = 3
    })
    task.spawn(function()
        while getgenv().workingGym do
            if not getgenv().workingGym then break end
            local success, err = pcall(function()
                if workoutType == "Жим лежа" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("benchPress")
                elseif workoutType == "Жим с присяда" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("squat")
                elseif workoutType == "Становая тяга" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("deadlift")
                elseif workoutType == "Поднимать камень" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("pullUp")
                end
            end)
            task.wait(0.1)
        end
    end)
end

for _, workoutType in ipairs(workoutTypes) do
    local GymContainer = Instance.new("Frame")
    GymContainer.Name = workoutType
    GymContainer.Size = UDim2.new(1, -20, 0, 70)
    GymContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    GymContainer.BackgroundTransparency = 0.5
    GymContainer.Parent = MainFrameContent

    local GymCorner = Instance.new("UICorner")
    GymCorner.CornerRadius = UDim.new(0, 6)
    GymCorner.Parent = GymContainer

    local GymLabel = Instance.new("TextLabel")
    GymLabel.Name = "Label"
    GymLabel.Size = UDim2.new(0, 120, 0, 30)
    GymLabel.Position = UDim2.new(0, 10, 0, 5)
    GymLabel.BackgroundTransparency = 1
    GymLabel.Text = workoutType
    GymLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    GymLabel.Font = Enum.Font.GothamBold
    GymLabel.TextSize = 14
    GymLabel.TextXAlignment = Enum.TextXAlignment.Left
    GymLabel.Parent = GymContainer

    local GymDropdown = Instance.new("TextButton")
    GymDropdown.Size = UDim2.new(0, 100, 0, 25)
    GymDropdown.Position = UDim2.new(0, 10, 0, 35)
    GymDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    GymDropdown.Text = gymLocations[1]
    GymDropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
    GymDropdown.Font = Enum.Font.Gotham
    GymDropdown.TextSize = 12
    GymDropdown.Parent = GymContainer

    local GymDropdownCorner = Instance.new("UICorner")
    GymDropdownCorner.CornerRadius = UDim.new(0, 6)
    GymDropdownCorner.Parent = GymDropdown

    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(0, 100, 0, #gymLocations * 25)
    DropdownList.Position = UDim2.new(0, 0, 0, 25)
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    DropdownList.BackgroundTransparency = 0.2
    DropdownList.Visible = false
    DropdownList.Parent = GymContainer

    local DropdownListLayout = Instance.new("UIListLayout")
    DropdownListLayout.Parent = DropdownList

    local selectedGym = gymLocations[1]
    for _, gymName in ipairs(gymLocations) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 25)
        OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        OptionButton.Text = gymName
        OptionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.TextSize = 12
        OptionButton.Parent = DropdownList
        OptionButton.MouseButton1Click:Connect(function()
            selectedGym = gymName
            GymDropdown.Text = gymName
            DropdownList.Visible = false
            _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] = gymName
        end)
    end

    GymDropdown.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
    end)

    local GymToggleFrame = Instance.new("Frame")
    GymToggleFrame.Name = "ToggleFrame"
    GymToggleFrame.Size = UDim2.new(0, 50, 0, 25)
    GymToggleFrame.Position = UDim2.new(1, -60, 0, 35)
    GymToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    GymToggleFrame.Parent = GymContainer

    local GymToggleCorner = Instance.new("UICorner")
    GymToggleCorner.CornerRadius = UDim.new(1, 0)
    GymToggleCorner.Parent = GymToggleFrame

    local GymToggleButton = Instance.new("TextButton")
    GymToggleButton.Name = "ToggleButton"
    GymToggleButton.Size = UDim2.new(0, 21, 0, 21)
    GymToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    GymToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    GymToggleButton.Text = ""
    GymToggleButton.Parent = GymToggleFrame

    local GymButtonCorner = Instance.new("UICorner")
    GymButtonCorner.CornerRadius = UDim.new(1, 0)
    GymButtonCorner.Parent = GymToggleButton

    local function updateGymToggle(enabled)
        local goal = {
            Position = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = enabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
        }
        GymToggleFrame.BackgroundColor3 = enabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
        local tween = TweenService:Create(GymToggleButton, TweenInfo.new(0.2), goal)
        tween:Play()
    end

    GymToggleButton.MouseButton1Click:Connect(function()
        getgenv().workingGym = not getgenv().workingGym
        updateGymToggle(getgenv().workingGym)
        if getgenv().workingGym then
            for otherType, otherToggle in pairs(gymToggles) do
                if otherType ~= workoutType and otherToggle then
                    otherToggle(false)
                end
            end
            local selectedGym = _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] or gymLocations[1]
            if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGym] then
                teleportAndStart(workoutType, workoutPositions[workoutType][selectedGym])
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ошибка",
                    Text = "Позиция не найдена для " .. workoutType .. " в " .. selectedGym,
                    Duration = 5
                })
                getgenv().workingGym = false
                updateGymToggle(false)
            end
        end
    end)

    gymToggles[workoutType] = updateGymToggle
    updateGymToggle(false)
end

-- Anti Knockback
local AntiKnockbackContainer = Instance.new("Frame")
AntiKnockbackContainer.Name = "AntiKnockback"
AntiKnockbackContainer.Size = UDim2.new(1, -20, 0, 40)
AntiKnockbackContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AntiKnockbackContainer.BackgroundTransparency = 0.5
AntiKnockbackContainer.Parent = MainFrameContent

local AntiKnockbackCorner = Instance.new("UICorner")
AntiKnockbackCorner.CornerRadius = UDim.new(0, 6)
AntiKnockbackCorner.Parent = AntiKnockbackContainer

local AntiKnockbackLabel = Instance.new("TextLabel")
AntiKnockbackLabel.Name = "Label"
AntiKnockbackLabel.Size = UDim2.new(0, 120, 1, 0)
AntiKnockbackLabel.Position = UDim2.new(0, 10, 0, 0)
AntiKnockbackLabel.BackgroundTransparency = 1
AntiKnockbackLabel.Text = "Анти отбрасывание"
AntiKnockbackLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AntiKnockbackLabel.Font = Enum.Font.GothamBold
AntiKnockbackLabel.TextSize = 14
AntiKnockbackLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiKnockbackLabel.Parent = AntiKnockbackContainer

local AntiKnockbackToggleFrame = Instance.new("Frame")
AntiKnockbackToggleFrame.Name = "ToggleFrame"
AntiKnockbackToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AntiKnockbackToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AntiKnockbackToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AntiKnockbackToggleFrame.Parent = AntiKnockbackContainer

local AntiKnockbackToggleCorner = Instance.new("UICorner")
AntiKnockbackToggleCorner.CornerRadius = UDim.new(1, 0)
AntiKnockbackToggleCorner.Parent = AntiKnockbackToggleFrame

local AntiKnockbackToggleButton = Instance.new("TextButton")
AntiKnockbackToggleButton.Name = "ToggleButton"
AntiKnockbackToggleButton.Size = UDim2.new(0, 21, 0, 21)
AntiKnockbackToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AntiKnockbackToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AntiKnockbackToggleButton.Text = ""
AntiKnockbackToggleButton.Parent = AntiKnockbackToggleFrame

local AntiKnockbackButtonCorner = Instance.new("UICorner")
AntiKnockbackButtonCorner.CornerRadius = UDim.new(1, 0)
AntiKnockbackButtonCorner.Parent = AntiKnockbackToggleButton

local antiKnockbackEnabled = false
local function updateAntiKnockbackToggle()
    local goal = {
        Position = antiKnockbackEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = antiKnockbackEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    AntiKnockbackToggleFrame.BackgroundColor3 = antiKnockbackEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(AntiKnockbackToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

AntiKnockbackToggleButton.MouseButton1Click:Connect(function()
    antiKnockbackEnabled = not antiKnockbackEnabled
    updateAntiKnockbackToggle()
    if antiKnockbackEnabled then
        local rootPart = workspace:FindFirstChild(player.Name):FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1250
            bodyVelocity.Parent = rootPart
        end
    else
        local rootPart = workspace:FindFirstChild(player.Name):FindFirstChild("HumanoidRootPart")
        if rootPart then
            local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
            if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                existingVelocity:Destroy()
            end
        end
    end
end)
updateAntiKnockbackToggle()

-- Position Lock
local PositionLockContainer = Instance.new("Frame")
PositionLockContainer.Name = "PositionLock"
PositionLockContainer.Size = UDim2.new(1, -20, 0, 40)
PositionLockContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PositionLockContainer.BackgroundTransparency = 0.5
PositionLockContainer.Parent = MainFrameContent

local PositionLockCorner = Instance.new("UICorner")
PositionLockCorner.CornerRadius = UDim.new(0, 6)
PositionLockCorner.Parent = PositionLockContainer

local PositionLockLabel = Instance.new("TextLabel")
PositionLockLabel.Name = "Label"
PositionLockLabel.Size = UDim2.new(0, 120, 1, 0)
PositionLockLabel.Position = UDim2.new(0, 10, 0, 0)
PositionLockLabel.BackgroundTransparency = 1
PositionLockLabel.Text = "Стоять на месте"
PositionLockLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
PositionLockLabel.Font = Enum.Font.GothamBold
PositionLockLabel.TextSize = 14
PositionLockLabel.TextXAlignment = Enum.TextXAlignment.Left
PositionLockLabel.Parent = PositionLockContainer

local PositionLockToggleFrame = Instance.new("Frame")
PositionLockToggleFrame.Name = "ToggleFrame"
PositionLockToggleFrame.Size = UDim2.new(0, 50, 0, 25)
PositionLockToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
PositionLockToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
PositionLockToggleFrame.Parent = PositionLockContainer

local PositionLockToggleCorner = Instance.new("UICorner")
PositionLockToggleCorner.CornerRadius = UDim.new(1, 0)
PositionLockToggleCorner.Parent = PositionLockToggleFrame

local PositionLockToggleButton = Instance.new("TextButton")
PositionLockToggleButton.Name = "ToggleButton"
PositionLockToggleButton.Size = UDim2.new(0, 21, 0, 21)
PositionLockToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
PositionLockToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
PositionLockToggleButton.Text = ""
PositionLockToggleButton.Parent = PositionLockToggleFrame

local PositionLockButtonCorner = Instance.new("UICorner")
PositionLockButtonCorner.CornerRadius = UDim.new(1, 0)
PositionLockButtonCorner.Parent = PositionLockToggleButton

local positionLockEnabled = false
local positionLockConnection
local function lockPlayerPosition(position)
    if positionLockConnection then
        positionLockConnection:Disconnect()
    end
    positionLockConnection = RunService.Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = position
        end
    end)
end

local function unlockPlayerPosition()
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
end

local function updatePositionLockToggle()
    local goal = {
        Position = positionLockEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = positionLockEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    PositionLockToggleFrame.BackgroundColor3 = positionLockEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(PositionLockToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

PositionLockToggleButton.MouseButton1Click:Connect(function()
    positionLockEnabled = not positionLockEnabled
    updatePositionLockToggle()
    if positionLockEnabled then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            lockPlayerPosition(currentPosition)
        end
    else
        unlockPlayerPosition()
    end
end)
updatePositionLockToggle()

-- Auto Rock Farming
local rocks = {
    {"Маленький камень - 0", "Tiny Island Rock", 0},
    {"Средний камень - 100", "Starter Island Rock", 100},
    {"Золотой камень - 5000", "Legend Beach Rock", 5000},
    {"Ледяной камень - 150000", "Frost Gym Rock", 150000},
    {"Мифический камень - 400000", "Mythical Gym Rock", 400000},
    {"Адский камень - 750000", "Eternal Gym Rock", 750000},
    {"Легендарный камень - 1000000", "Legend Gym Rock", 1000000},
    {"Камень в Джунглях - 10000000", "Ancient Jungle Rock", 10000000},
    {"Королевский камень - 5000000", "Muscle King Gym Rock", 5000000}
}

local function gettool()
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Punch" and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(v)
        end
    end
    player.muscleEvent:FireServer("punch", "leftHand")
    player.muscleEvent:FireServer("punch", "rightHand")
end

for _, rock in ipairs(rocks) do
    local RockContainer = Instance.new("Frame")
    RockContainer.Name = rock[1]
    RockContainer.Size = UDim2.new(1, -20, 0, 40)
    RockContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    RockContainer.BackgroundTransparency = 0.5
    RockContainer.Parent = FarmFrame

    local RockCorner = Instance.new("UICorner")
    RockCorner.CornerRadius = UDim.new(0, 6)
    RockCorner.Parent = RockContainer

    local RockLabel = Instance.new("TextLabel")
    RockLabel.Name = "Label"
    RockLabel.Size = UDim2.new(0, 200, 1, 0)
    RockLabel.Position = UDim2.new(0, 10, 0, 0)
    RockLabel.BackgroundTransparency = 1
    RockLabel.Text = rock[1]
    RockLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    RockLabel.Font = Enum.Font.GothamBold
    RockLabel.TextSize = 14
    RockLabel.TextXAlignment = Enum.TextXAlignment.Left
    RockLabel.Parent = RockContainer

    local RockToggleFrame = Instance.new("Frame")
    RockToggleFrame.Name = "ToggleFrame"
    RockToggleFrame.Size = UDim2.new(0, 50, 0, 25)
    RockToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    RockToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    RockToggleFrame.Parent = RockContainer

    local RockToggleCorner = Instance.new("UICorner")
    RockToggleCorner.CornerRadius = UDim.new(1, 0)
    RockToggleCorner.Parent = RockToggleFrame

    local RockToggleButton = Instance.new("TextButton")
    RockToggleButton.Name = "ToggleButton"
    RockToggleButton.Size = UDim2.new(0, 21, 0, 21)
    RockToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    RockToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    RockToggleButton.Text = ""
    RockToggleButton.Parent = RockToggleFrame

    local RockButtonCorner = Instance.new("UICorner")
    RockButtonCorner.CornerRadius = UDim.new(1, 0)
    RockButtonCorner.Parent = RockToggleButton

    local rockEnabled = false
    local function updateRockToggle()
        local goal = {
            Position = rockEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = rockEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
        }
        RockToggleFrame.BackgroundColor3 = rockEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
        local tween = TweenService:Create(RockToggleButton, TweenInfo.new(0.2), goal)
        tween:Play()
    end

    RockToggleButton.MouseButton1Click:Connect(function()
        rockEnabled = not rockEnabled
        updateRockToggle()
        getgenv().autoFarm = rockEnabled
        getgenv().selectedRock = rock[2]
        if rockEnabled then
            task.spawn(function()
                while getgenv().autoFarm do
                    task.wait()
                    if not getgenv().autoFarm then break end
                    if player.Durability.Value >= rock[3] then
                        for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                            if v.Name == "neededDurability" and v.Value == rock[3] and player.Character:FindFirstChild("LeftHand") and player.Character:FindFirstChild("RightHand") then
                                firetouchinterest(v.Parent.Rock, player.Character.RightHand, 0)
                                firetouchinterest(v.Parent.Rock, player.Character.RightHand, 1)
                                firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 0)
                                firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 1)
                                gettool()
                            end
                        end
                    end
                end
            end)
        end
    end)
    updateRockToggle()
end

-- Rebirths
local RebirthsContainer = Instance.new("Frame")
RebirthsContainer.Name = "Rebirths"
RebirthsContainer.Size = UDim2.new(1, -20, 0, 100)
RebirthsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
RebirthsContainer.BackgroundTransparency = 0.5
RebirthsContainer.Parent = FarmFrame

local RebirthsCorner = Instance.new("UICorner")
RebirthsCorner.CornerRadius = UDim.new(0, 6)
RebirthsCorner.Parent = RebirthsContainer

local RebirthsLabel = Instance.new("TextLabel")
RebirthsLabel.Name = "Label"
RebirthsLabel.Size = UDim2.new(0, 120, 0, 30)
RebirthsLabel.Position = UDim2.new(0, 10, 0, 5)
RebirthsLabel.BackgroundTransparency = 1
RebirthsLabel.Text = "Перерождения"
RebirthsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
RebirthsLabel.Font = Enum.Font.GothamBold
RebirthsLabel.TextSize = 14
RebirthsLabel.TextXAlignment = Enum.TextXAlignment.Left
RebirthsLabel.Parent = RebirthsContainer

local targetRebirthValue = 0
local TargetRebirthInput = Instance.new("TextBox")
TargetRebirthInput.Name = "TargetRebirthInput"
TargetRebirthInput.Size = UDim2.new(0, 100, 0, 25)
TargetRebirthInput.Position = UDim2.new(0, 10, 0, 35)
TargetRebirthInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TargetRebirthInput.TextColor3 = Color3.new(1, 1, 1)
TargetRebirthInput.Font = Enum.Font.Gotham
TargetRebirthInput.TextSize = 14
TargetRebirthInput.Text = "0"
TargetRebirthInput.Parent = RebirthsContainer

local TargetRebirthToggleFrame = Instance.new("Frame")
TargetRebirthToggleFrame.Name = "ToggleFrame"
TargetRebirthToggleFrame.Size = UDim2.new(0, 50, 0, 25)
TargetRebirthToggleFrame.Position = UDim2.new(1, -60, 0, 35)
TargetRebirthToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
TargetRebirthToggleFrame.Parent = RebirthsContainer

local TargetRebirthToggleCorner = Instance.new("UICorner")
TargetRebirthToggleCorner.CornerRadius = UDim.new(1, 0)
TargetRebirthToggleCorner.Parent = TargetRebirthToggleFrame

local TargetRebirthToggleButton = Instance.new("TextButton")
TargetRebirthToggleButton.Name = "ToggleButton"
TargetRebirthToggleButton.Size = UDim2.new(0, 21, 0, 21)
TargetRebirthToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
TargetRebirthToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
TargetRebirthToggleButton.Text = ""
TargetRebirthToggleButton.Parent = TargetRebirthToggleFrame

local TargetRebirthButtonCorner = Instance.new("UICorner")
TargetRebirthButtonCorner.CornerRadius = UDim.new(1, 0)
TargetRebirthButtonCorner.Parent = TargetRebirthToggleButton

local InfiniteRebirthToggleFrame = Instance.new("Frame")
InfiniteRebirthToggleFrame.Name = "ToggleFrame"
InfiniteRebirthToggleFrame.Size = UDim2.new(0, 50, 0, 25)
InfiniteRebirthToggleFrame.Position = UDim2.new(1, -60, 0, 60)
InfiniteRebirthToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
InfiniteRebirthToggleFrame.Parent = RebirthsContainer

local InfiniteRebirthToggleCorner = Instance.new("UICorner")
InfiniteRebirthToggleCorner.CornerRadius = UDim.new(1, 0)
InfiniteRebirthToggleCorner.Parent = InfiniteRebirthToggleFrame

local InfiniteRebirthToggleButton = Instance.new("TextButton")
InfiniteRebirthToggleButton.Name = "ToggleButton"
InfiniteRebirthToggleButton.Size = UDim2.new(0, 21, 0, 21)
InfiniteRebirthToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
InfiniteRebirthToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
InfiniteRebirthToggleButton.Text = ""
InfiniteRebirthToggleButton.Parent = InfiniteRebirthToggleFrame

local InfiniteRebirthButtonCorner = Instance.new("UICorner")
InfiniteRebirthButtonCorner.CornerRadius = UDim.new(1, 0)
InfiniteRebirthButtonCorner.Parent = InfiniteRebirthToggleButton

local targetRebirthActive = false
local infiniteRebirthActive = false
local function updateTargetRebirthToggle()
    local goal = {
        Position = targetRebirthActive and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = targetRebirthActive and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    TargetRebirthToggleFrame.BackgroundColor3 = targetRebirthActive and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(TargetRebirthToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function updateInfiniteRebirthToggle()
    local goal = {
        Position = infiniteRebirthActive and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = infiniteRebirthActive and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    InfiniteRebirthToggleFrame.BackgroundColor3 = infiniteRebirthActive and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(InfiniteRebirthToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

TargetRebirthInput.FocusLost:Connect(function()
    local newValue = tonumber(TargetRebirthInput.Text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет " .. targetRebirthValue .. " перерождений",
            Duration = 5
        })
    else
        TargetRebirthInput.Text = tostring(targetRebirthValue)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Ошибка",
            Text = "Введите корректное число",
            Duration = 5
        })
    end
end)

TargetRebirthToggleButton.MouseButton1Click:Connect(function()
    targetRebirthActive = not targetRebirthActive
    updateTargetRebirthToggle()
    if targetRebirthActive then
        if infiniteRebirthActive then
            infiniteRebirthActive = false
            updateInfiniteRebirthToggle()
        end
        task.spawn(function()
            while targetRebirthActive and task.wait(0.1) do
                local currentRebirths = player.leaderstats.Rebirths.Value
                if currentRebirths >= targetRebirthValue then
                    targetRebirthActive = false
                    updateTargetRebirthToggle()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Готово",
                        Text = "Достигнуто " .. targetRebirthValue .. " перерождений",
                        Duration = 5
                    })
                    break
                end
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)
updateTargetRebirthToggle()

InfiniteRebirthToggleButton.MouseButton1Click:Connect(function()
    infiniteRebirthActive = not infiniteRebirthActive
    updateInfiniteRebirthToggle()
    if infiniteRebirthActive then
        if targetRebirthActive then
            targetRebirthActive = false
            updateTargetRebirthToggle()
        end
        task.spawn(function()
            while infiniteRebirthActive and task.wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)
updateInfiniteRebirthToggle()

-- Auto Equip Tools
local tools = {
    {"Авто гантеля", "Weight"},
    {"Авто отжимания", "Pushups"},
    {"Авто отжимания стоя на руках", "Handstands"},
    {"Авто пресс", "Situps"},
    {"Авто удары", "Punch"}
}

for _, tool in ipairs(tools) do
    local ToolContainer = Instance.new("Frame")
    ToolContainer.Name = tool[1]
    ToolContainer.Size = UDim2.new(1, -20, 0, 40)
    ToolContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ToolContainer.BackgroundTransparency = 0.5
    ToolContainer.Parent = FarmFrame

    local ToolCorner = Instance.new("UICorner")
    ToolCorner.CornerRadius = UDim.new(0, 6)
    ToolCorner.Parent = ToolContainer

    local ToolLabel = Instance.new("TextLabel")
    ToolLabel.Name = "Label"
    ToolLabel.Size = UDim2.new(0, 200, 1, 0)
    ToolLabel.Position = UDim2.new(0, 10, 0, 0)
    ToolLabel.BackgroundTransparency = 1
    ToolLabel.Text = tool[1]
    ToolLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToolLabel.Font = Enum.Font.GothamBold
    ToolLabel.TextSize = 14
    ToolLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToolLabel.Parent = ToolContainer

    local ToolToggleFrame = Instance.new("Frame")
    ToolToggleFrame.Name = "ToggleFrame"
    ToolToggleFrame.Size = UDim2.new(0, 50, 0, 25)
    ToolToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    ToolToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ToolToggleFrame.Parent = ToolContainer

    local ToolToggleCorner = Instance.new("UICorner")
    ToolToggleCorner.CornerRadius = UDim.new(1, 0)
    ToolToggleCorner.Parent = ToolToggleFrame

    local ToolToggleButton = Instance.new("TextButton")
    ToolToggleButton.Name = "ToggleButton"
    ToolToggleButton.Size = UDim2.new(0, 21, 0, 21)
    ToolToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    ToolToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    ToolToggleButton.Text = ""
    ToolToggleButton.Parent = ToolToggleFrame

    local ToolButtonCorner = Instance.new("UICorner")
    ToolButtonCorner.CornerRadius = UDim.new(1, 0)
    ToolButtonCorner.Parent = ToolToggleButton

    local toolEnabled = false
    local function updateToolToggle()
        local goal = {
            Position = toolEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = toolEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
        }
        ToolToggleFrame.BackgroundColor3 = toolEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
        local tween = TweenService:Create(ToolToggleButton, TweenInfo.new(0.2), goal)
        tween:Play()
    end

    ToolToggleButton.MouseButton1Click:Connect(function()
        toolEnabled = not toolEnabled
        _G[tool[1]] = toolEnabled
        updateToolToggle()
        if toolEnabled then
            local toolObj = player.Backpack:FindFirstChild(tool[2])
            if toolObj then
                player.Character.Humanoid:EquipTool(toolObj)
            end
            task.spawn(function()
                while _G[tool[1]] do
                    if tool[2] == "Punch" then
                        local punch = player.Character:FindFirstChild("Punch")
                        if punch and punch:FindFirstChild("attackTime") then
                            punch.attackTime.Value = 0
                        end
                        player.muscleEvent:FireServer("punch", "rightHand")
                        player.muscleEvent:FireServer("punch", "leftHand")
                        if punch then punch:Activate() end
                        task.wait(0)
                    else
                        player.muscleEvent:FireServer("rep")
                        task.wait(0.1)
                    end
                end
                local character = player.Character
                local equipped = character:FindFirstChild(tool[2])
                if equipped then
                    equipped.Parent = player.Backpack
                end
            end)
        else
            local character = player.Character
            local equipped = character:FindFirstChild(tool[2])
            if equipped then
                equipped.Parent = player.Backpack
            end
        end
    end)
    updateToolToggle()
end

-- Fast Tools
local FastToolsContainer = Instance.new("Frame")
FastToolsContainer.Name = "FastTools"
FastToolsContainer.Size = UDim2.new(1, -20, 0, 40)
FastToolsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FastToolsContainer.BackgroundTransparency = 0.5
FastToolsContainer.Parent = FarmFrame

local FastToolsCorner = Instance.new("UICorner")
FastToolsCorner.CornerRadius = UDim.new(0, 6)
FastToolsCorner.Parent = FastToolsContainer

local FastToolsLabel = Instance.new("TextLabel")
FastToolsLabel.Name = "Label"
FastToolsLabel.Size = UDim2.new(0, 120, 1, 0)
FastToolsLabel.Position = UDim2.new(0, 10, 0, 0)
FastToolsLabel.BackgroundTransparency = 1
FastToolsLabel.Text = "Быстрые предметы"
FastToolsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FastToolsLabel.Font = Enum.Font.GothamBold
FastToolsLabel.TextSize = 14
FastToolsLabel.TextXAlignment = Enum.TextXAlignment.Left
FastToolsLabel.Parent = FastToolsContainer

local FastToolsToggleFrame = Instance.new("Frame")
FastToolsToggleFrame.Name = "ToggleFrame"
FastToolsToggleFrame.Size = UDim2.new(0, 50, 0, 25)
FastToolsToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
FastToolsToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
FastToolsToggleFrame.Parent = FastToolsContainer

local FastToolsToggleCorner = Instance.new("UICorner")
FastToolsToggleCorner.CornerRadius = UDim.new(1, 0)
FastToolsToggleCorner.Parent = FastToolsToggleFrame

local FastToolsToggleButton = Instance.new("TextButton")
FastToolsToggleButton.Name = "ToggleButton"
FastToolsToggleButton.Size = UDim2.new(0, 21, 0, 21)
FastToolsToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
FastToolsToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
FastToolsToggleButton.Text = ""
FastToolsToggleButton.Parent = FastToolsToggleFrame

local FastToolsButtonCorner = Instance.new("UICorner")
FastToolsButtonCorner.CornerRadius = UDim.new(1, 0)
FastToolsButtonCorner.Parent = FastToolsToggleButton

local fastToolsEnabled = false
local function updateFastToolsToggle()
    local goal = {
        Position = fastToolsEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = fastToolsEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    FastToolsToggleFrame.BackgroundColor3 = fastToolsEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(FastToolsToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local defaultSpeeds = {
    {"Punch", "attackTime", 0.35},
    {"Ground Slam", "attackTime", 6},
    {"Stomp", "attackTime", 7},
    {"Handstands", "repTime", 2},
    {"Situps", "repTime", 2.5},
    {"Pushups", "repTime", 2.5},
    {"Weight", "repTime", 3}
}

FastToolsToggleButton.MouseButton1Click:Connect(function()
    fastToolsEnabled = not fastToolsEnabled
    updateFastToolsToggle()
    for _, toolData in pairs(defaultSpeeds) do
        local toolName, property, defaultSpeed = toolData[1], toolData[2], toolData[3]
        local speed = fastToolsEnabled and 0 or defaultSpeed
        local backpackTool = player.Backpack:FindFirstChild(toolName)
        if backpackTool and backpackTool:FindFirstChild(property) then
            backpackTool[property].Value = speed
        end
        local equippedTool = player.Character:FindFirstChild(toolName)
        if equippedTool and equippedTool:FindFirstChild(property) then
            equippedTool[property].Value = speed
        end
    end
end)
updateFastToolsToggle()

-- Anti Lag
local AntiLagContainer = Instance.new("Frame")
AntiLagContainer.Name = "AntiLag"
AntiLagContainer.Size = UDim2.new(1, -20, 0, 40)
AntiLagContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AntiLagContainer.BackgroundTransparency = 0.5
AntiLagContainer.Parent =
