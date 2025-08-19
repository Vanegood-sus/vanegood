local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

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

-- Вкладки (3 штуки)
local ScriptsTab = Instance.new("TextButton")
ScriptsTab.Size = UDim2.new(0.33, 0, 1, 0)
ScriptsTab.Position = UDim2.new(0, 0, 0, 0)
ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ScriptsTab.Text = "СКРИПТЫ"
ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
ScriptsTab.Font = Enum.Font.GothamBold
ScriptsTab.TextSize = 12
ScriptsTab.Parent = TabBar

local GamesTab = Instance.new("TextButton")
GamesTab.Size = UDim2.new(0.33, 0, 1, 0)
GamesTab.Position = UDim2.new(0.33, 0, 0, 0)
GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GamesTab.Text = "ИГРЫ"
GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
GamesTab.Font = Enum.Font.GothamBold
GamesTab.TextSize = 12
GamesTab.Parent = TabBar

local TrollTab = Instance.new("TextButton")
TrollTab.Size = UDim2.new(0.34, 0, 1, 0)
TrollTab.Position = UDim2.new(0.66, 0, 0, 0)
TrollTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TrollTab.Text = "ТРОЛЛИНГ"
TrollTab.TextColor3 = Color3.fromRGB(180, 180, 180)
TrollTab.Font = Enum.Font.GothamBold
TrollTab.TextSize = 12
TrollTab.Parent = TabBar

-- Индикатор вкладки (оранжевый)
local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(0.33, 0, 0, 2)
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
local ScriptsFrame = Instance.new("ScrollingFrame")
ScriptsFrame.Size = UDim2.new(1, 0, 1, 0)
ScriptsFrame.Position = UDim2.new(0, 0, 0, 0)
ScriptsFrame.BackgroundTransparency = 1
ScriptsFrame.ScrollBarThickness = 3
ScriptsFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScriptsFrame.Visible = true
ScriptsFrame.Parent = ContentFrame

-- Добавляем UIListLayout для автоматического расположения элементов
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = ScriptsFrame

-- Настраиваем ScrollingFrame
ScriptsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptsFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)  -- Оранжевый цвет как в вашем стиле
            
local GamesFrame = Instance.new("ScrollingFrame")
GamesFrame.Size = UDim2.new(1, 0, 1, 0)
GamesFrame.Position = UDim2.new(0, 0, 0, 0)
GamesFrame.BackgroundTransparency = 1
GamesFrame.ScrollBarThickness = 3
GamesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
GamesFrame.Visible = false
GamesFrame.Parent = ContentFrame

local TrollFrame = Instance.new("ScrollingFrame")
TrollFrame.Size = UDim2.new(1, 0, 1, 0)
TrollFrame.Position = UDim2.new(0, 0, 0, 0)
TrollFrame.BackgroundTransparency = 1
TrollFrame.ScrollBarThickness = 3
TrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
TrollFrame.Visible = false
TrollFrame.Parent = ContentFrame

-- WalkFling (в разделе Троллинг)
local WalkFlingContainer = Instance.new("Frame")
WalkFlingContainer.Name = "WalkFlingSettings"
WalkFlingContainer.Size = UDim2.new(1, -20, 0, 40)
WalkFlingContainer.Position = UDim2.new(0, 10, 0, 10) -- Первая позиция в TrollFrame
WalkFlingContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
WalkFlingContainer.BackgroundTransparency = 0.5
WalkFlingContainer.Parent = TrollFrame

local WalkFlingCorner = Instance.new("UICorner")
WalkFlingCorner.CornerRadius = UDim.new(0, 6)
WalkFlingCorner.Parent = WalkFlingContainer

local WalkFlingLabel = Instance.new("TextLabel")
WalkFlingLabel.Name = "Label"
WalkFlingLabel.Size = UDim2.new(0, 120, 1, 0)
WalkFlingLabel.Position = UDim2.new(0, 10, 0, 0)
WalkFlingLabel.BackgroundTransparency = 1
WalkFlingLabel.Text = "Walk Fling"
WalkFlingLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
WalkFlingLabel.Font = Enum.Font.GothamBold
WalkFlingLabel.TextSize = 14
WalkFlingLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkFlingLabel.Parent = WalkFlingContainer

-- Контейнер для элементов управления
local WalkFlingControlContainer = Instance.new("Frame")
WalkFlingControlContainer.Size = UDim2.new(0, 150, 0, 25)
WalkFlingControlContainer.Position = UDim2.new(1, -110, 0.5, -12)
WalkFlingControlContainer.BackgroundTransparency = 1
WalkFlingControlContainer.Parent = WalkFlingContainer

-- Поле ввода для мощности
local WalkFlingPowerInput = Instance.new("TextBox")
WalkFlingPowerInput.Name = "PowerInput"
WalkFlingPowerInput.Size = UDim2.new(0, 40, 1, 0)
WalkFlingPowerInput.Position = UDim2.new(0, 0, 0, 0)
WalkFlingPowerInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
WalkFlingPowerInput.TextColor3 = Color3.new(1, 1, 1)
WalkFlingPowerInput.Font = Enum.Font.Gotham
WalkFlingPowerInput.TextSize = 14
WalkFlingPowerInput.Text = "10000"
WalkFlingPowerInput.Parent = WalkFlingControlContainer

-- Переключатель
local WalkFlingToggleFrame = Instance.new("Frame")
WalkFlingToggleFrame.Name = "ToggleFrame"
WalkFlingToggleFrame.Size = UDim2.new(0, 50, 0, 25)
WalkFlingToggleFrame.Position = UDim2.new(0, 50, 0, 0)
WalkFlingToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
WalkFlingToggleFrame.Parent = WalkFlingControlContainer

local WalkFlingToggleCorner = Instance.new("UICorner")
WalkFlingToggleCorner.CornerRadius = UDim.new(1, 0)
WalkFlingToggleCorner.Parent = WalkFlingToggleFrame

local WalkFlingToggleButton = Instance.new("TextButton")
WalkFlingToggleButton.Name = "ToggleButton"
WalkFlingToggleButton.Size = UDim2.new(0, 21, 0, 21)
WalkFlingToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
WalkFlingToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
WalkFlingToggleButton.Text = ""
WalkFlingToggleButton.Parent = WalkFlingToggleFrame

local WalkFlingButtonCorner = Instance.new("UICorner")
WalkFlingButtonCorner.CornerRadius = UDim.new(1, 0)
WalkFlingButtonCorner.Parent = WalkFlingToggleButton

-- Логика WalkFling (сохранена оригинальная функциональность)
local walkFlingEnabled = false
local walkFlingPower = 10000
local walkFlingConnections = {}
local noclipEnabled = false

local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

local function updateWalkFlingToggle()
    local goal = {
        Position = walkFlingEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = walkFlingEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    WalkFlingToggleFrame.BackgroundColor3 = walkFlingEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(WalkFlingToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function enableNoclip()
    noclipEnabled = true
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
    
    table.insert(walkFlingConnections, character.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end))
end

local function disableNoclip()
    noclipEnabled = false
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

local function enableWalkFling()
    walkFlingEnabled = true
    updateWalkFlingToggle()
    enableNoclip()
    
    -- Подключение для обработки смерти персонажа
    table.insert(walkFlingConnections, LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            disableWalkFling()
        end)
    end))
    
    -- Основной цикл WalkFling (сохранен оригинальный алгоритм)
    table.insert(walkFlingConnections, RunService.Heartbeat:Connect(function()
        if not walkFlingEnabled then return end
        
        local character = LocalPlayer.Character
        local root = getRoot(character)
        if not (character and root) then return end
        
        local vel = root.Velocity
        root.Velocity = vel * walkFlingPower + Vector3.new(0, walkFlingPower, 0)
        
        -- Добавляем небольшой "толчок" вверх-вниз для эффекта
        RunService.RenderStepped:Wait()
        if character and root then
            root.Velocity = vel
        end
        
        RunService.Stepped:Wait()
        if character and root then
            root.Velocity = vel + Vector3.new(0, 0.1, 0)
        end
    end))
end

local function disableWalkFling()
    walkFlingEnabled = false
    updateWalkFlingToggle()
    disableNoclip()
    
    for _, connection in ipairs(walkFlingConnections) do
        connection:Disconnect()
    end
    walkFlingConnections = {}
    
    -- Возвращаем нормальную физику
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

WalkFlingToggleButton.MouseButton1Click:Connect(function()
    if walkFlingEnabled then
        disableWalkFling()
    else
        enableWalkFling()
    end
end)

WalkFlingPowerInput.FocusLost:Connect(function()
    local num = tonumber(WalkFlingPowerInput.Text)
    if num and num >= 1000 and num <= 50000 then
        walkFlingPower = num
    else
        WalkFlingPowerInput.Text = tostring(walkFlingPower)
    end
end)

-- Обработчик смерти персонажа
local function onCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if walkFlingEnabled then
            disableWalkFling()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

-- Очистка при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableWalkFling()
    end
end)

-- Инициализация
updateWalkFlingToggle()

-- Head Sit (в разделе Троллинг, после WalkFling)
local HeadSitContainer = Instance.new("Frame")
HeadSitContainer.Name = "HeadSitSettings"
HeadSitContainer.Size = UDim2.new(1, -20, 0, 40)
HeadSitContainer.Position = UDim2.new(0, 10, 0, 60) -- Позиция под WalkFling (+50 по Y)
HeadSitContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
HeadSitContainer.BackgroundTransparency = 0.5
HeadSitContainer.Parent = TrollFrame

local HeadSitCorner = Instance.new("UICorner")
HeadSitCorner.CornerRadius = UDim.new(0, 6)
HeadSitCorner.Parent = HeadSitContainer

local HeadSitLabel = Instance.new("TextLabel")
HeadSitLabel.Name = "Label"
HeadSitLabel.Size = UDim2.new(0, 120, 1, 0)
HeadSitLabel.Position = UDim2.new(0, 10, 0, 0)
HeadSitLabel.BackgroundTransparency = 1
HeadSitLabel.Text = "Head Sit"
HeadSitLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
HeadSitLabel.Font = Enum.Font.GothamBold
HeadSitLabel.TextSize = 14
HeadSitLabel.TextXAlignment = Enum.TextXAlignment.Left
HeadSitLabel.Parent = HeadSitContainer

local HeadSitToggleButton = Instance.new("TextButton")
HeadSitToggleButton.Name = "HeadSitToggle"
HeadSitToggleButton.Size = UDim2.new(0, 120, 0, 25)
HeadSitToggleButton.Position = UDim2.new(1, -130, 0.5, -12)
HeadSitToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HeadSitToggleButton.Text = "Select ▷"
HeadSitToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
HeadSitToggleButton.Font = Enum.Font.Gotham
HeadSitToggleButton.TextSize = 12
HeadSitToggleButton.Parent = HeadSitContainer

local HeadSitButtonCorner = Instance.new("UICorner")
HeadSitButtonCorner.CornerRadius = UDim.new(0, 4)
HeadSitButtonCorner.Parent = HeadSitToggleButton

-- Меню игроков для Head Sit
local HeadSitPlayersMenu = Instance.new("Frame")
HeadSitPlayersMenu.Name = "HeadSitPlayersMenu"
HeadSitPlayersMenu.Size = UDim2.new(0, 150, 0, 0)
HeadSitPlayersMenu.Position = UDim2.new(0, HeadSitContainer.AbsolutePosition.X + HeadSitContainer.AbsoluteSize.X + 5, 0, HeadSitContainer.AbsolutePosition.Y - 135)
HeadSitPlayersMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
HeadSitPlayersMenu.BorderSizePixel = 0
HeadSitPlayersMenu.Visible = false
HeadSitPlayersMenu.ClipsDescendants = true
HeadSitPlayersMenu.Parent = ScreenGui

local HeadSitUICorner = Instance.new("UICorner")
HeadSitUICorner.CornerRadius = UDim.new(0, 6)
HeadSitUICorner.Parent = HeadSitPlayersMenu

local HeadSitUIStroke = Instance.new("UIStroke")
HeadSitUIStroke.Color = Color3.fromRGB(80, 80, 80)
HeadSitUIStroke.Thickness = 1
HeadSitUIStroke.Parent = HeadSitPlayersMenu

local HeadSitPlayersList = Instance.new("ScrollingFrame")
HeadSitPlayersList.Size = UDim2.new(1, -5, 1, -5)
HeadSitPlayersList.Position = UDim2.new(0, 5, 0, 5)
HeadSitPlayersList.BackgroundTransparency = 1
HeadSitPlayersList.ScrollBarThickness = 3
HeadSitPlayersList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
HeadSitPlayersList.Parent = HeadSitPlayersMenu

local HeadSitPlayersListLayout = Instance.new("UIListLayout")
HeadSitPlayersListLayout.Padding = UDim.new(0, 5)
HeadSitPlayersListLayout.Parent = HeadSitPlayersList

HeadSitPlayersListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HeadSitPlayersList.CanvasSize = UDim2.new(0, 0, 0, HeadSitPlayersListLayout.AbsoluteContentSize.Y)
    HeadSitPlayersMenu.Size = UDim2.new(0, 150, 0, math.min(HeadSitPlayersListLayout.AbsoluteContentSize.Y + 10, 300))
end)

local function updateHeadSitMenuPosition()
    HeadSitPlayersMenu.Position = UDim2.new(
        0, HeadSitContainer.AbsolutePosition.X + HeadSitContainer.AbsoluteSize.X + 5,
        0, HeadSitContainer.AbsolutePosition.Y - 135
    )
end

HeadSitContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateHeadSitMenuPosition)
HeadSitContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHeadSitMenuPosition)

-- Переменные для Head Sit
local headSitConnection = nil
local currentHeadSitTarget = nil

local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

local function startHeadSit(player)
    if headSitConnection then
        headSitConnection:Disconnect()
        headSitConnection = nil
    end
    
    currentHeadSitTarget = player
    local localPlayer = game.Players.LocalPlayer
    
    headSitConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not localPlayer.Character or not player.Character then
            if headSitConnection then
                headSitConnection:Disconnect()
                headSitConnection = nil
            end
            return
        end
        
        local targetRoot = getRoot(player.Character)
        local localRoot = getRoot(localPlayer.Character)
        local localHumanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        
        if targetRoot and localRoot and localHumanoid then
            localHumanoid.Sit = true
            localRoot.CFrame = targetRoot.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 1.6, 0.4)
        else
            if headSitConnection then
                headSitConnection:Disconnect()
                headSitConnection = nil
            end
        end
    end)
    
    HeadSitToggleButton.Text = player.Name .. " ◁"
    HeadSitPlayersMenu.Visible = false
end

local function stopHeadSit()
    if headSitConnection then
        headSitConnection:Disconnect()
        headSitConnection = nil
    end
    
    currentHeadSitTarget = nil
    HeadSitToggleButton.Text = "Select ▷"
    
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = false
        end
    end
end

local function createHeadSitPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = HeadSitPlayersList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        startHeadSit(player)
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
    end)
    
    return button
end

local isHeadSitMenuOpen = false
HeadSitToggleButton.MouseButton1Click:Connect(function()
    if headSitConnection then
        stopHeadSit()
    else
        isHeadSitMenuOpen = not isHeadSitMenuOpen
        
        if isHeadSitMenuOpen then
            HeadSitToggleButton.Text = "Select ◁"
            updateHeadSitMenuPosition()
            HeadSitPlayersMenu.Visible = true
        else
            HeadSitToggleButton.Text = "Select ▷"
            HeadSitPlayersMenu.Visible = false
        end
    end
end)

-- Создаем кнопки для всех игроков
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        createHeadSitPlayerButton(player)
    end
end

-- Обработчики добавления/удаления игроков
game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        createHeadSitPlayerButton(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    for _, child in ipairs(HeadSitPlayersList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            child:Destroy()
            break
        end
    end
    
    if currentHeadSitTarget == player then
        stopHeadSit()
    end
end)

-- Закрытие меню при клике вне его
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local menuPos = HeadSitPlayersMenu.AbsolutePosition
        local menuSize = HeadSitPlayersMenu.AbsoluteSize
        local buttonPos = HeadSitToggleButton.AbsolutePosition
        local buttonSize = HeadSitToggleButton.AbsoluteSize
        
        if isHeadSitMenuOpen and 
           (mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
            mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y) and
           (mousePos.X < buttonPos.X or mousePos.X > buttonPos.X + buttonSize.X or
            mousePos.Y < buttonPos.Y or mousePos.Y > buttonPos.Y + buttonSize.Y) then
            isHeadSitMenuOpen = false
            HeadSitPlayersMenu.Visible = false
            HeadSitToggleButton.Text = "Select ▷"
        end
    end
end)

-- Автоматическая остановка при смерти
local function onCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        stopHeadSit()
    end)
end

game.Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if game.Players.LocalPlayer.Character then
    onCharacterAdded(game.Players.LocalPlayer.Character)
end

-- Очистка при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == game.Players.LocalPlayer then
        stopHeadSit()
    end
end)

-- Функция переключения вкладок
local function switchTab(tab)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TrollTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    ScriptsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    TrollTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    
    ScriptsFrame.Visible = false
    GamesFrame.Visible = false
    TrollFrame.Visible = false
    
    if tab == "scripts" then
        ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 0, 1, -2)}):Play()
        ScriptsFrame.Visible = true
    elseif tab == "games" then
        GamesTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        GamesTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.33, 0, 1, -2)}):Play()
        GamesFrame.Visible = true
    else
        TrollTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TrollTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.66, 0, 1, -2)}):Play()
        TrollFrame.Visible = true
    end
end

-- Обработчики вкладок
ScriptsTab.MouseButton1Click:Connect(function() switchTab("scripts") end)
GamesTab.MouseButton1Click:Connect(function() switchTab("games") end)
TrollTab.MouseButton1Click:Connect(function() switchTab("troll") end)

-- Функция минимизации
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 30)
        ContentFrame.Visible = false
        TabBar.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        ContentFrame.Visible = true
        TabBar.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Функция закрытия
CloseButton.MouseButton1Click:Connect(function()
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Size = UDim2.new(0, 250, 0, 120)
    MessageFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MessageFrame.Parent = ScreenGui
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 0, 60)
    MessageLabel.Position = UDim2.new(0, 10, 0, 10)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = "Закрыть Vanegood Hub?"
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Font = Enum.Font.GothamBold
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = MessageFrame
    
    local YesButton = Instance.new("TextButton")
    YesButton.Size = UDim2.new(0, 100, 0, 30)
    YesButton.Position = UDim2.new(0.5, -105, 1, -40)
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50) -- Оранжевая
    YesButton.Text = "Да"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.GothamBold
    YesButton.TextSize = 14
    YesButton.Parent = MessageFrame
    
    local NoButton = Instance.new("TextButton")
    NoButton.Size = UDim2.new(0, 100, 0, 30)
    NoButton.Position = UDim2.new(0.5, 5, 1, -40)
    NoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    NoButton.Text = "Нет"
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.GothamBold
    NoButton.TextSize = 14
    NoButton.Parent = MessageFrame
    
    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        TinyImageGui:Destroy()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end)

-- Функция для кнопки с картинкой
local hubVisible = true
imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubVisible = not hubVisible
        ScreenGui.Enabled = hubVisible
        
        -- Анимация для обратной связи
        if hubVisible then
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
        else
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
        end
    end
end)

-- Инициализация
switchTab("scripts")
