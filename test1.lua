-- Vanegood Hub by Vanegood-sus
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый хаб если есть
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

-- Anti-AFK 
local AntiAfkContainer = Instance.new("Frame")
AntiAfkContainer.Name = "AntiAfk"
AntiAfkContainer.Size = UDim2.new(1, -20, 0, 40)  -- Ширина с отступами по 10 с каждой стороны
AntiAfkContainer.Position = UDim2.new(0, 10, 0, 10)  -- Отступ сверху 10
AntiAfkContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AntiAfkContainer.BackgroundTransparency = 0.5
AntiAfkContainer.Parent = ScriptsFrame

-- Скругление углов
local AntiAfkCorner = Instance.new("UICorner")
AntiAfkCorner.CornerRadius = UDim.new(0, 6)
AntiAfkCorner.Parent = AntiAfkContainer

-- Текст "Anti-AFK"
local AntiAfkLabel = Instance.new("TextLabel")
AntiAfkLabel.Name = "Label"
AntiAfkLabel.Size = UDim2.new(0, 120, 1, 0)
AntiAfkLabel.Position = UDim2.new(0, 10, 0, 0)
AntiAfkLabel.BackgroundTransparency = 1
AntiAfkLabel.Text = "Anti-AFK"
AntiAfkLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AntiAfkLabel.Font = Enum.Font.GothamBold
AntiAfkLabel.TextSize = 14
AntiAfkLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAfkLabel.Parent = AntiAfkContainer

-- Стилизованный переключатель
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

-- Логика Anti-AFK
local afkEnabled = true
local virtualUser = game:service'VirtualUser'

local function updateAfkToggle()
    local goal = {
        Position = afkEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = afkEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    AntiAfkToggleFrame.BackgroundColor3 = afkEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(AntiAfkToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

AntiAfkToggleButton.MouseButton1Click:Connect(function()
    afkEnabled = not afkEnabled
    updateAfkToggle()
end)

game:service'Players'.LocalPlayer.Idled:connect(function()
    if afkEnabled then
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end
end)

updateAfkToggle()  -- Инициализация переключателя

-- ESP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки ESP
local espEnabled = false
local espObjects = {}
local lastUpdate = 0
local updateInterval = 0.2

-- Создаем контейнер для ESP 
local EspContainer = Instance.new("Frame")
EspContainer.Name = "ESPSettings"
EspContainer.Size = UDim2.new(1, -20, 0, 40)
EspContainer.Position = UDim2.new(0, 10, 0, 60) -- Под Anti-AFK
EspContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
EspContainer.BackgroundTransparency = 0.5
EspContainer.Parent = ScriptsFrame

-- Скругление углов
local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 6)
EspCorner.Parent = EspContainer

-- Текст "ESP"
local EspLabel = Instance.new("TextLabel")
EspLabel.Name = "Label"
EspLabel.Size = UDim2.new(0, 120, 1, 0)
EspLabel.Position = UDim2.new(0, 10, 0, 0)
EspLabel.BackgroundTransparency = 1
EspLabel.Text = "ESP"
EspLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
EspLabel.Font = Enum.Font.GothamBold
EspLabel.TextSize = 14
EspLabel.TextXAlignment = Enum.TextXAlignment.Left
EspLabel.Parent = EspContainer

-- Переключатель 
local EspToggleFrame = Instance.new("Frame")
EspToggleFrame.Name = "ToggleFrame"
EspToggleFrame.Size = UDim2.new(0, 50, 0, 25)
EspToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
EspToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
EspToggleFrame.Parent = EspContainer

local EspToggleCorner = Instance.new("UICorner")
EspToggleCorner.CornerRadius = UDim.new(1, 0)
EspToggleCorner.Parent = EspToggleFrame

local EspToggleButton = Instance.new("TextButton")
EspToggleButton.Name = "ToggleButton"
EspToggleButton.Size = UDim2.new(0, 21, 0, 21)
EspToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
EspToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
EspToggleButton.Text = ""
EspToggleButton.Parent = EspToggleFrame

local EspButtonCorner = Instance.new("UICorner")
EspButtonCorner.CornerRadius = UDim.new(1, 0)
EspButtonCorner.Parent = EspToggleButton

-- Анимация переключателя
local function updateEspToggle()
    local goal = {
        Position = espEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = espEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    EspToggleFrame.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(EspToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

-- Очистка ESP
local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj.highlight then obj.highlight:Destroy() end
        if obj.label then obj.label:Destroy() end
    end
    espObjects = {}
end

-- Логика определения врагов/союзников (взята из твоего второго скрипта)
local function isEnemy(player)
    -- Проверка на команду убийц
    if player:FindFirstChild("Team") and player.Team.Name:lower():find("killer") then
        return true
    end
    
    -- Проверка на противоположную команду
    if player.Team and LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    end
    
    -- Проверка на возможность нанести вред
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local tool = player.Character:FindFirstChildOfClass("Tool")
        
        -- Если у игрока есть оружие или он может атаковать
        if tool or (humanoid and humanoid:GetAttribute("CanAttack") == true) then
            return true
        end
    end
    
    return false
end

-- Проверка, является ли игрок союзником (вашей командой)
local function isAlly(player)
    -- Если есть система команд и игрок в вашей команде
    if player.Team and LocalPlayer.Team then
        return player.Team == LocalPlayer.Team
    end
    
    -- Дополнительные проверки для союзников
    return false
end

-- Обновление ESP (взято из твоего второго скрипта)
local function updateESP()
    if not espEnabled then return end
    
    local currentTime = os.clock()
    if currentTime - lastUpdate < updateInterval then return end
    lastUpdate = currentTime
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                local enemy = isEnemy(player)
                local ally = isAlly(player)
                
                if not espObjects[player] then
                    espObjects[player] = {}
                    
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 0.85
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = player.Character
                    
                    local label = Instance.new("TextLabel")
                    label.Name = "ESPLabel"
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 12
                    label.TextStrokeTransparency = 0.7
                    label.TextStrokeColor3 = Color3.new(0, 0, 0)
                    label.Parent = ScreenGui  -- Важно! Используем основной ScreenGui
                    
                    espObjects[player] = {
                        highlight = highlight,
                        label = label
                    }
                end
                
                local espData = espObjects[player]
                
                -- Устанавливаем цвет в зависимости от типа игрока
                if enemy then
                    -- Враги - красный
                    espData.highlight.FillColor = Color3.fromRGB(255, 70, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(180, 0, 0)
                elseif ally then
                    -- Союзники - зеленый
                    espData.highlight.FillColor = Color3.fromRGB(70, 255, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(0, 180, 0)
                else
                    -- Нейтральные игроки - синий
                    espData.highlight.FillColor = Color3.fromRGB(70, 70, 255)
                    espData.highlight.OutlineColor = Color3.fromRGB(0, 0, 180)
                end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) 
                        and (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude 
                        or 0
                    
                    espData.label.Text = string.format("%s [%d]", player.Name, math.floor(distance))
                    espData.label.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 35)
                    espData.label.Visible = true
                else
                    espData.label.Visible = false
                end
            else
                if espObjects[player] then
                    if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
                    if espObjects[player].label then espObjects[player].label:Destroy() end
                    espObjects[player] = nil
                end
            end
        else
            if espObjects[player] then
                if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
                if espObjects[player].label then espObjects[player].label:Destroy() end
                espObjects[player] = nil
            end
        end
    end
end

-- Обработчик переключателя
EspToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateEspToggle()
    if not espEnabled then clearESP() end
end)

-- Очистка при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        if espObjects[player].label then espObjects[player].label:Destroy() end
        espObjects[player] = nil
    end
end)

-- Основной цикл
RunService.Heartbeat:Connect(updateESP)

-- Инициализация
updateEspToggle()

-- HitBox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Настройки хитбоксов
_G.Size = 20
_G.Disabled = false

-- Создаем контейнер для HitBox 
local HitBoxContainer = Instance.new("Frame")
HitBoxContainer.Name = "HitBoxSettings"
HitBoxContainer.Size = UDim2.new(1, -20, 0, 40)
HitBoxContainer.Position = UDim2.new(0, 10, 0, 110) -- Под ESP
HitBoxContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
HitBoxContainer.BackgroundTransparency = 0.5
HitBoxContainer.Parent = ScriptsFrame

-- Скругление углов
local HitBoxCorner = Instance.new("UICorner")
HitBoxCorner.CornerRadius = UDim.new(0, 6)
HitBoxCorner.Parent = HitBoxContainer

-- Текст "HitBox"
local HitBoxLabel = Instance.new("TextLabel")
HitBoxLabel.Name = "Label"
HitBoxLabel.Size = UDim2.new(0, 120, 1, 0)
HitBoxLabel.Position = UDim2.new(0, 10, 0, 0)
HitBoxLabel.BackgroundTransparency = 1
HitBoxLabel.Text = "HitBox"
HitBoxLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
HitBoxLabel.Font = Enum.Font.GothamBold
HitBoxLabel.TextSize = 14
HitBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
HitBoxLabel.Parent = HitBoxContainer

-- Переключатель 
local HitBoxToggleFrame = Instance.new("Frame")
HitBoxToggleFrame.Name = "ToggleFrame"
HitBoxToggleFrame.Size = UDim2.new(0, 50, 0, 25)
HitBoxToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
HitBoxToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HitBoxToggleFrame.Parent = HitBoxContainer

local HitBoxToggleCorner = Instance.new("UICorner")
HitBoxToggleCorner.CornerRadius = UDim.new(1, 0)
HitBoxToggleCorner.Parent = HitBoxToggleFrame

local HitBoxToggleButton = Instance.new("TextButton")
HitBoxToggleButton.Name = "ToggleButton"
HitBoxToggleButton.Size = UDim2.new(0, 21, 0, 21)
HitBoxToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
HitBoxToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
HitBoxToggleButton.Text = ""
HitBoxToggleButton.Parent = HitBoxToggleFrame

local HitBoxButtonCorner = Instance.new("UICorner")
HitBoxButtonCorner.CornerRadius = UDim.new(1, 0)
HitBoxButtonCorner.Parent = HitBoxToggleButton

-- Анимация переключателя
local function updateHitBoxToggle()
    local goal = {
        Position = _G.Disabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = _G.Disabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    HitBoxToggleFrame.BackgroundColor3 = _G.Disabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(HitBoxToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

-- Функция сброса хитбоксов
local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Size = Vector3.new(2, 2, 1)
                rootPart.Transparency = 0
                rootPart.BrickColor = BrickColor.new("Medium stone grey")
                rootPart.Material = "Plastic"
                rootPart.CanCollide = true
            end
        end
    end
end

-- Обработчик переключателя
HitBoxToggleButton.MouseButton1Click:Connect(function()
    _G.Disabled = not _G.Disabled
    updateHitBoxToggle()
    
    if not _G.Disabled then
        resetHitboxes()
    end
end)

-- Основной цикл хитбоксов
RunService.RenderStepped:Connect(function()
    if _G.Disabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- Адаптивный размер хитбокса в зависимости от размера персонажа
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        local height = humanoid and humanoid.HipHeight * 2 or _G.Size
                        rootPart.Size = Vector3.new(_G.Size, height, _G.Size)
                        rootPart.Transparency = 0.7
                        rootPart.BrickColor = BrickColor.new("Really red")
                        rootPart.Material = "Neon"
                        rootPart.CanCollide = false
                    end
                end)
            end
        end
    end
end)

-- Сброс хитбоксов при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Size = Vector3.new(2, 2, 1)
            rootPart.Transparency = 0
            rootPart.BrickColor = BrickColor.new("Medium stone grey")
            rootPart.Material = "Plastic"
            rootPart.CanCollide = true
        end
    end
end)

-- Инициализация
updateHitBoxToggle()

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
