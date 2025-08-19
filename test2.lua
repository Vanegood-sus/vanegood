-- Vanegood Test Hub
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService") 
local LocalPlayer = Players.LocalPlayer 

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

-- Back Ride (сидение на спине) в разделе Троллинг
local BackRideContainer = Instance.new("Frame")
BackRideContainer.Name = "BackRideSettings"
BackRideContainer.Size = UDim2.new(1, -20, 0, 40)
BackRideContainer.Position = UDim2.new(0, 10, 0, 10) -- Первая позиция в TrollFrame
BackRideContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
BackRideContainer.BackgroundTransparency = 0.5
BackRideContainer.Parent = TrollFrame

local BackRideCorner = Instance.new("UICorner")
BackRideCorner.CornerRadius = UDim.new(0, 6)
BackRideCorner.Parent = BackRideContainer

local BackRideLabel = Instance.new("TextLabel")
BackRideLabel.Name = "Label"
BackRideLabel.Size = UDim2.new(0, 120, 1, 0)
BackRideLabel.Position = UDim2.new(0, 10, 0, 0)
BackRideLabel.BackgroundTransparency = 1
BackRideLabel.Text = "Back Ride"
BackRideLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
BackRideLabel.Font = Enum.Font.GothamBold
BackRideLabel.TextSize = 14
BackRideLabel.TextXAlignment = Enum.TextXAlignment.Left
BackRideLabel.Parent = BackRideContainer

-- Контейнер для элементов управления
local BackRideControlContainer = Instance.new("Frame")
BackRideControlContainer.Size = UDim2.new(0, 150, 0, 25)
BackRideControlContainer.Position = UDim2.new(1, -160, 0.5, -12)
BackRideControlContainer.BackgroundTransparency = 1
BackRideControlContainer.Parent = BackRideContainer

-- Выбор игрока
local BackRidePlayerInput = Instance.new("TextBox")
BackRidePlayerInput.Name = "PlayerInput"
BackRidePlayerInput.Size = UDim2.new(0, 80, 1, 0)
BackRidePlayerInput.Position = UDim2.new(0, 0, 0, 0)
BackRidePlayerInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
BackRidePlayerInput.TextColor3 = Color3.new(1, 1, 1)
BackRidePlayerInput.Font = Enum.Font.Gotham
BackRidePlayerInput.TextSize = 12
BackRidePlayerInput.PlaceholderText = "Имя/часть"
BackRidePlayerInput.Text = ""
BackRidePlayerInput.Parent = BackRideControlContainer

-- Переключатель
local BackRideToggleFrame = Instance.new("Frame")
BackRideToggleFrame.Name = "ToggleFrame"
BackRideToggleFrame.Size = UDim2.new(0, 50, 0, 25)
BackRideToggleFrame.Position = UDim2.new(0, 90, 0, 0)
BackRideToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
BackRideToggleFrame.Parent = BackRideControlContainer

local BackRideToggleCorner = Instance.new("UICorner")
BackRideToggleCorner.CornerRadius = UDim.new(1, 0)
BackRideToggleCorner.Parent = BackRideToggleFrame

local BackRideToggleButton = Instance.new("TextButton")
BackRideToggleButton.Name = "ToggleButton"
BackRideToggleButton.Size = UDim2.new(0, 21, 0, 21)
BackRideToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
BackRideToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
BackRideToggleButton.Text = ""
BackRideToggleButton.Parent = BackRideToggleFrame

local BackRideButtonCorner = Instance.new("UICorner")
BackRideButtonCorner.CornerRadius = UDim.new(1, 0)
BackRideButtonCorner.Parent = BackRideToggleButton

-- ДОБАВЬ ЭТИ ФУНКЦИИ ПЕРЕД ЛОГИКОЙ Back Ride:
local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

local function updateBackRideToggle()
    local goal = {
        Position = backRideEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = backRideEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    BackRideToggleFrame.BackgroundColor3 = backRideEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(BackRideToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function findBestPlayerMatch(searchText)
    if searchText == "" then return nil end
    
    local searchLower = string.lower(searchText)
    local players = Players:GetPlayers()
    local matches = {}
    
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            local nameLower = string.lower(player.Name)
            local displayLower = string.lower(player.DisplayName)
            
            if nameLower == searchLower or displayLower == searchLower then
                return player
            elseif string.find(nameLower, searchLower) or string.find(displayLower, searchLower) then
                table.insert(matches, player)
            end
        end
    end
    
    if #matches > 0 then
        return matches[1]
    end
    
    return nil
end

-- Логика Back Ride
local backRideEnabled = false
local backRideConnection = nil
local currentBackTarget = nil

local function findBestPlayerMatch(searchText)
    if searchText == "" then return nil end
    
    local searchLower = string.lower(searchText)
    local players = Players:GetPlayers()
    local matches = {}
    
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            local nameLower = string.lower(player.Name)
            local displayLower = string.lower(player.DisplayName)
            
            if nameLower == searchLower or displayLower == searchLower then
                return player
            elseif string.find(nameLower, searchLower) or string.find(displayLower, searchLower) then
                table.insert(matches, player)
            end
        end
    end
    
    if #matches > 0 then
        return matches[1]
    end
    
    return nil
end

local function updateBackRideToggle()
    local goal = {
        Position = backRideEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = backRideEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    BackRideToggleFrame.BackgroundColor3 = backRideEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(BackRideToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

--еще тут изменил как ты и говорил,верно?

local function enableBackRide()
    local searchText = BackRidePlayerInput.Text
    if searchText == "" then
        BackRidePlayerInput.PlaceholderText = "Введите имя!"
        return
    end
    
    local target = findBestPlayerMatch(searchText)
    if not target then
        BackRidePlayerInput.Text = ""
        BackRidePlayerInput.PlaceholderText = "Игрок не найден!"
        return
    end
    
    -- Проверяем что у целевого игрока есть персонаж и корневая часть
    if not target.Character or not getRoot(target.Character) then
        BackRidePlayerInput.Text = ""
        BackRidePlayerInput.PlaceholderText = "Нет персонажа!"
        return
    end
    
    currentBackTarget = target
    backRideEnabled = true
    updateBackRideToggle()
    
    BackRidePlayerInput.PlaceholderText = "Найден: " .. target.Name
    
    -- Заставляем персонажа сесть
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = true
        
        -- Немного ждем прежде чем начать телепортацию
        wait(0.2)
    end
    
    -- Создаем соединение для сидения на спине
    backRideConnection = RunService.Heartbeat:Connect(function()
        if not backRideEnabled or not currentBackTarget then return end
        
        -- Проверяем что оба игрока и их корневые части существуют
        if Players:FindFirstChild(currentBackTarget.Name) and currentBackTarget.Character and 
           getRoot(currentBackTarget.Character) and LocalPlayer.Character and 
           getRoot(LocalPlayer.Character) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and 
           LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit == true then
            
            -- Телепортируемся на спину целевого игрока
            local targetRoot = getRoot(currentBackTarget.Character)
            local myRoot = getRoot(LocalPlayer.Character)
            
            myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0.5, 0.8)
        else
            disableBackRide()
        end
    end)
end

local function disableBackRide()
    backRideEnabled = false
    currentBackTarget = nil
    updateBackRideToggle()
    
    if backRideConnection then
        backRideConnection:Disconnect()
        backRideConnection = nil
    end
    
    BackRidePlayerInput.PlaceholderText = "Имя/часть"
    
    -- Встаем
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
    end
end

BackRideToggleButton.MouseButton1Click:Connect(function()
    if backRideEnabled then
        disableBackRide()
    else
        enableBackRide()
    end
end)

-- Автопоиск при нажатии Enter
BackRidePlayerInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and not backRideEnabled then
        enableBackRide()
    end
end)

-- Обработчик смерти персонажа
local function onCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if backRideEnabled then
            disableBackRide()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

-- Очистка при выходе целевого игрока
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableBackRide()
    elseif player == currentBackTarget then
        disableBackRide()
    end
end)

-- Инициализация
updateBackRideToggle()

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
