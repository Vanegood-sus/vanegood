-- Vanegood Hub 
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
local afkEnabled = false
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
EspContainer.Position = UDim2.new(0, 10, 0, 60) 
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

-- Логика определения врагов/союзников
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

-- Обновление ESP 
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

_G.Size = 20
_G.Disabled = false

-- Создаем контейнер для HitBox 
local HitBoxContainer = Instance.new("Frame")
HitBoxContainer.Name = "HitBoxSettings"
HitBoxContainer.Size = UDim2.new(1, -20, 0, 40)
HitBoxContainer.Position = UDim2.new(0, 10, 0, 110) 
HitBoxContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
HitBoxContainer.BackgroundTransparency = 0.5
HitBoxContainer.Parent = ScriptsFrame

local HitBoxCorner = Instance.new("UICorner")
HitBoxCorner.CornerRadius = UDim.new(0, 6)
HitBoxCorner.Parent = HitBoxContainer

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

-- Контейнер для элементов управления 
local ControlContainer = Instance.new("Frame")
ControlContainer.Size = UDim2.new(0, 150, 0, 25)
ControlContainer.Position = UDim2.new(1, -110, 0.5, -12)  -- Сдвинуто левее
ControlContainer.BackgroundTransparency = 1
ControlContainer.Parent = HitBoxContainer

-- Поле ввода для размера 
local SizeInput = Instance.new("TextBox")
SizeInput.Name = "SizeInput"
SizeInput.Size = UDim2.new(0, 40, 1, 0)
SizeInput.Position = UDim2.new(0, 0, 0, 0)
SizeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SizeInput.TextColor3 = Color3.new(1, 1, 1)
SizeInput.Font = Enum.Font.Gotham
SizeInput.TextSize = 14
SizeInput.Text = tostring(_G.Size)
SizeInput.Parent = ControlContainer

-- Переключатель
local HitBoxToggleFrame = Instance.new("Frame")
HitBoxToggleFrame.Name = "ToggleFrame"
HitBoxToggleFrame.Size = UDim2.new(0, 50, 0, 25)
HitBoxToggleFrame.Position = UDim2.new(0, 50, 0, 0)
HitBoxToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HitBoxToggleFrame.Parent = ControlContainer

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

local function updateHitBoxToggle()
    local goal = {
        Position = _G.Disabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = _G.Disabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    HitBoxToggleFrame.BackgroundColor3 = _G.Disabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(HitBoxToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

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

SizeInput.FocusLost:Connect(function()
    local num = tonumber(SizeInput.Text)
    if num and num >= 1 and num <= 100 then
        _G.Size = num
    else
        SizeInput.Text = tostring(_G.Size)
    end
end)

HitBoxToggleButton.MouseButton1Click:Connect(function()
    _G.Disabled = not _G.Disabled
    updateHitBoxToggle()
    
    if not _G.Disabled then
        resetHitboxes()
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.Disabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- Делаем хитбокс квадратным (кубическим)
                        rootPart.Size = Vector3.new(_G.Size, _G.Size, _G.Size)
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

updateHitBoxToggle()

-- Fly 
local FlyContainer = Instance.new("Frame")
FlyContainer.Name = "FlySettings"
FlyContainer.Size = UDim2.new(1, -20, 0, 40)
FlyContainer.Position = UDim2.new(0, 10, 0, 160) -- Позиция ниже HitBox
FlyContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FlyContainer.BackgroundTransparency = 0.5
FlyContainer.Parent = ScriptsFrame

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 6)
FlyCorner.Parent = FlyContainer

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Name = "Label"
FlyLabel.Size = UDim2.new(0, 120, 1, 0)
FlyLabel.Position = UDim2.new(0, 10, 0, 0)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "Fly"
FlyLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyLabel.Font = Enum.Font.GothamBold
FlyLabel.TextSize = 14
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.Parent = FlyContainer

-- Контейнер для элементов управления
local FlyControlContainer = Instance.new("Frame")
FlyControlContainer.Size = UDim2.new(0, 150, 0, 25)
FlyControlContainer.Position = UDim2.new(1, -110, 0.5, -12)
FlyControlContainer.BackgroundTransparency = 1
FlyControlContainer.Parent = FlyContainer

-- Поле ввода для скорости полета
local FlySpeedInput = Instance.new("TextBox")
FlySpeedInput.Name = "SpeedInput"
FlySpeedInput.Size = UDim2.new(0, 40, 1, 0)
FlySpeedInput.Position = UDim2.new(0, 0, 0, 0)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FlySpeedInput.TextColor3 = Color3.new(1, 1, 1)
FlySpeedInput.Font = Enum.Font.Gotham
FlySpeedInput.TextSize = 14
FlySpeedInput.Text = "50"
FlySpeedInput.Parent = FlyControlContainer

-- Переключатель
local FlyToggleFrame = Instance.new("Frame")
FlyToggleFrame.Name = "ToggleFrame"
FlyToggleFrame.Size = UDim2.new(0, 50, 0, 25)
FlyToggleFrame.Position = UDim2.new(0, 50, 0, 0)
FlyToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
FlyToggleFrame.Parent = FlyControlContainer

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(1, 0)
FlyToggleCorner.Parent = FlyToggleFrame

local FlyToggleButton = Instance.new("TextButton")
FlyToggleButton.Name = "ToggleButton"
FlyToggleButton.Size = UDim2.new(0, 21, 0, 21)
FlyToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
FlyToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
FlyToggleButton.Text = ""
FlyToggleButton.Parent = FlyToggleFrame

local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(1, 0)
FlyButtonCorner.Parent = FlyToggleButton

-- Логика полета
local flyEnabled = false
local flySpeed = 50
local bv, bg
local flyConnections = {}

local function updateFlyToggle()
    local goal = {
        Position = flyEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    FlyToggleFrame.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(FlyToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function setupCharacter(character)
    if flyEnabled then
        if character:FindFirstChild("HumanoidRootPart") then
            -- Удаляем старые обработчики, если они есть
            if character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
                character.HumanoidRootPart.VelocityHandler:Destroy()
            end
            if character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                character.HumanoidRootPart.GyroHandler:Destroy()
            end
            
            -- Создаем новые обработчики
            bv = Instance.new("BodyVelocity")
            bv.Name = "VelocityHandler"
            bv.Parent = character.HumanoidRootPart
            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            bv.Velocity = Vector3.new(0,0,0)
            
            bg = Instance.new("BodyGyro")
            bg.Name = "GyroHandler"
            bg.Parent = character.HumanoidRootPart
            bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
            bg.P = 1000
            bg.D = 50
            
            character.Humanoid.PlatformStand = true
        end
    end
end

local function disableFly()
    flyEnabled = false
    updateFlyToggle()
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
        if LocalPlayer.Character.HumanoidRootPart and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
        end
        if LocalPlayer.Character.HumanoidRootPart and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
            LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
        end
    end
    
    -- Отключаем все соединения полета
    for _, connection in pairs(flyConnections) do
        connection:Disconnect()
    end
    flyConnections = {}
end

local function enableFly()
    flyEnabled = true
    updateFlyToggle()
    
    -- Устанавливаем соединения только если их еще нет
    if #flyConnections == 0 then
        -- Обработчик добавления персонажа
        table.insert(flyConnections, LocalPlayer.CharacterAdded:Connect(function(character)
            setupCharacter(character)
            
            -- Обработчик смерти персонажа
            character:WaitForChild("Humanoid").Died:Connect(function()
                if flyEnabled then
                    -- После смерти автоматически восстанавливаем полет
                    task.wait() -- Даем время для респавна
                    if LocalPlayer.Character then
                        setupCharacter(LocalPlayer.Character)
                    end
                end
            end)
        end))
        
        -- Обработчик рендера
        table.insert(flyConnections, RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and 
               LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
               LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and 
               LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                
                if flyEnabled then
                    LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
                    LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
                    LocalPlayer.Character.Humanoid.PlatformStand = true
                    
                    local camera = workspace.CurrentCamera
                    LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
                    
                    local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
                    local direction = controlModule:GetMoveVector()
                    LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
                    
                    if direction.X > 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*flySpeed)
                    end
                    if direction.X < 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*flySpeed)
                    end
                    if direction.Z > 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*flySpeed)
                    end
                    if direction.Z < 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*flySpeed)
                    end
                end
            end
        end))
        
        -- Обработчик изменения скорости
        table.insert(flyConnections, FlySpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
            if tonumber(FlySpeedInput.Text) then
                flySpeed = tonumber(FlySpeedInput.Text)
            end
        end))
    end
    
    -- Устанавливаем полет для текущего персонажа
    if LocalPlayer.Character then
        setupCharacter(LocalPlayer.Character)
    end
end

FlyToggleButton.MouseButton1Click:Connect(function()
    if flyEnabled then
        disableFly()
    else
        enableFly()
    end
end)

FlySpeedInput.FocusLost:Connect(function()
    local num = tonumber(FlySpeedInput.Text)
    if num and num >= 1 and num <= 500 then
        flySpeed = num
    else
        FlySpeedInput.Text = tostring(flySpeed)
    end
end)

-- Очистка при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableFly()
    end
end)

-- Инициализация
updateFlyToggle()

--Speed
local SpeedContainer = Instance.new("Frame")
SpeedContainer.Name = "SpeedSettings"
SpeedContainer.Size = UDim2.new(1, -20, 0, 40)
SpeedContainer.Position = UDim2.new(0, 10, 0, 260) -- Позиция ниже InfJump
SpeedContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedContainer.BackgroundTransparency = 0.5
SpeedContainer.Parent = ScriptsFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedContainer

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "Label"
SpeedLabel.Size = UDim2.new(0, 120, 1, 0)
SpeedLabel.Position = UDim2.new(0, 10, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed"
SpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedContainer

-- Контейнер для элементов управления
local SpeedControlContainer = Instance.new("Frame")
SpeedControlContainer.Size = UDim2.new(0, 150, 0, 25)
SpeedControlContainer.Position = UDim2.new(1, -110, 0.5, -12)
SpeedControlContainer.BackgroundTransparency = 1
SpeedControlContainer.Parent = SpeedContainer

-- Поле ввода для скорости
local SpeedValueInput = Instance.new("TextBox")
SpeedValueInput.Name = "SpeedInput"
SpeedValueInput.Size = UDim2.new(0, 40, 1, 0)
SpeedValueInput.Position = UDim2.new(0, 0, 0, 0)
SpeedValueInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedValueInput.TextColor3 = Color3.new(1, 1, 1)
SpeedValueInput.Font = Enum.Font.Gotham
SpeedValueInput.TextSize = 14
SpeedValueInput.Text = "16" -- Стандартная скорость
SpeedValueInput.Parent = SpeedControlContainer

-- Переключатель
local SpeedToggleFrame = Instance.new("Frame")
SpeedToggleFrame.Name = "ToggleFrame"
SpeedToggleFrame.Size = UDim2.new(0, 50, 0, 25)
SpeedToggleFrame.Position = UDim2.new(0, 50, 0, 0)
SpeedToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedToggleFrame.Parent = SpeedControlContainer

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(1, 0)
SpeedToggleCorner.Parent = SpeedToggleFrame

local SpeedToggleButton = Instance.new("TextButton")
SpeedToggleButton.Name = "ToggleButton"
SpeedToggleButton.Size = UDim2.new(0, 21, 0, 21)
SpeedToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
SpeedToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
SpeedToggleButton.Text = ""
SpeedToggleButton.Parent = SpeedToggleFrame

local SpeedButtonCorner = Instance.new("UICorner")
SpeedButtonCorner.CornerRadius = UDim.new(1, 0)
SpeedButtonCorner.Parent = SpeedToggleButton

-- Логика Speed
local speedEnabled = false
local currentSpeed = 16
local speedConnection = nil

local function updateSpeedToggle()
    local goal = {
        Position = speedEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    SpeedToggleFrame.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(SpeedToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function setCharacterSpeed(character, speed)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
    end
end

local function enableSpeed()
    speedEnabled = true
    updateSpeedToggle()
    
    -- Устанавливаем соединения
    if not speedConnection then
        speedConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if speedEnabled and LocalPlayer.Character then
                setCharacterSpeed(LocalPlayer.Character, currentSpeed)
            end
        end)
    end
    
    -- Применяем сразу к текущему персонажу
    if LocalPlayer.Character then
        setCharacterSpeed(LocalPlayer.Character, currentSpeed)
    end
end

local function disableSpeed()
    speedEnabled = false
    updateSpeedToggle()
    
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    -- Возвращаем стандартную скорость
    if LocalPlayer.Character then
        setCharacterSpeed(LocalPlayer.Character, 16) -- 16 - стандартная скорость в Roblox
    end
end

SpeedToggleButton.MouseButton1Click:Connect(function()
    if speedEnabled then
        disableSpeed()
    else
        enableSpeed()
    end
end)

SpeedValueInput.FocusLost:Connect(function()
    local num = tonumber(SpeedValueInput.Text)
    if num and num >= 16 and num <= 500 then
        currentSpeed = num
        if speedEnabled and LocalPlayer.Character then
            setCharacterSpeed(LocalPlayer.Character, currentSpeed)
        end
    else
        SpeedValueInput.Text = tostring(currentSpeed)
    end
end)

-- Обработчик добавления нового персонажа
LocalPlayer.CharacterAdded:Connect(function(character)
    if speedEnabled then
        setCharacterSpeed(character, currentSpeed)
    end
end)

-- Очистка при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableSpeed()
    end
end)

-- Инициализация
updateSpeedToggle()


--InfJump
local InfJumpContainer = Instance.new("Frame")
InfJumpContainer.Name = "InfJump"
InfJumpContainer.Size = UDim2.new(1, -20, 0, 40)
InfJumpContainer.Position = UDim2.new(0, 10, 0, 210) -- Позиция ниже Fly
InfJumpContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
InfJumpContainer.BackgroundTransparency = 0.5
InfJumpContainer.Parent = ScriptsFrame

local InfJumpCorner = Instance.new("UICorner")
InfJumpCorner.CornerRadius = UDim.new(0, 6)
InfJumpCorner.Parent = InfJumpContainer

local InfJumpLabel = Instance.new("TextLabel")
InfJumpLabel.Name = "Label"
InfJumpLabel.Size = UDim2.new(0, 120, 1, 0)
InfJumpLabel.Position = UDim2.new(0, 10, 0, 0)
InfJumpLabel.BackgroundTransparency = 1
InfJumpLabel.Text = "Inf Jump"
InfJumpLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
InfJumpLabel.Font = Enum.Font.GothamBold
InfJumpLabel.TextSize = 14
InfJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
InfJumpLabel.Parent = InfJumpContainer

local InfJumpToggleFrame = Instance.new("Frame")
InfJumpToggleFrame.Name = "ToggleFrame"
InfJumpToggleFrame.Size = UDim2.new(0, 50, 0, 25)
InfJumpToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
InfJumpToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
InfJumpToggleFrame.Parent = InfJumpContainer

local InfJumpToggleCorner = Instance.new("UICorner")
InfJumpToggleCorner.CornerRadius = UDim.new(1, 0)
InfJumpToggleCorner.Parent = InfJumpToggleFrame

local InfJumpToggleButton = Instance.new("TextButton")
InfJumpToggleButton.Name = "ToggleButton"
InfJumpToggleButton.Size = UDim2.new(0, 21, 0, 21)
InfJumpToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
InfJumpToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
InfJumpToggleButton.Text = ""
InfJumpToggleButton.Parent = InfJumpToggleFrame

local InfJumpButtonCorner = Instance.new("UICorner")
InfJumpButtonCorner.CornerRadius = UDim.new(1, 0)
InfJumpButtonCorner.Parent = InfJumpToggleButton

-- Логика InfJump
local infJumpEnabled = false
local infJumpConnection = nil

local function updateInfJumpToggle()
    local goal = {
        Position = infJumpEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    
    InfJumpToggleFrame.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(InfJumpToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function enableInfJump()
    infJumpEnabled = true
    updateInfJumpToggle()
    
    infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infJumpEnabled and game:GetService("Players").LocalPlayer.Character then
            local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState("Jumping")
            end
        end
    end)
end

local function disableInfJump()
    infJumpEnabled = false
    updateInfJumpToggle()
    
    if infJumpConnection then
        infJumpConnection:Disconnect()
        infJumpConnection = nil
    end
end

InfJumpToggleButton.MouseButton1Click:Connect(function()
    if infJumpEnabled then
        disableInfJump()
    else
        enableInfJump()
    end
end)

-- Очистка при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == game:GetService("Players").LocalPlayer then
        disableInfJump()
    end
end)

-- Инициализация
updateInfJumpToggle()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Добавляем наблюдателя в ваш хаб
local SpectateContainer = Instance.new("Frame")
SpectateContainer.Name = "SpectateSettings"
SpectateContainer.Size = UDim2.new(1, -20, 0, 40)
SpectateContainer.Position = UDim2.new(0, 10, 0, 610) -- Измените позицию по необходимости
SpectateContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpectateContainer.BackgroundTransparency = 0.5
SpectateContainer.Parent = ScriptsFrame -- Предполагается, что ScriptsFrame уже существует в вашем хабе

local SpectateCorner = Instance.new("UICorner")
SpectateCorner.CornerRadius = UDim.new(0, 6)
SpectateCorner.Parent = SpectateContainer

local SpectateLabel = Instance.new("TextLabel")
SpectateLabel.Name = "Label"
SpectateLabel.Size = UDim2.new(0, 120, 1, 0)
SpectateLabel.Position = UDim2.new(0, 10, 0, 0)
SpectateLabel.BackgroundTransparency = 1
SpectateLabel.Text = "Spectate"
SpectateLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SpectateLabel.Font = Enum.Font.GothamBold
SpectateLabel.TextSize = 14
SpectateLabel.TextXAlignment = Enum.TextXAlignment.Left
SpectateLabel.Parent = SpectateContainer

local SpectateToggleButton = Instance.new("TextButton")
SpectateToggleButton.Name = "SpectateToggle"
SpectateToggleButton.Size = UDim2.new(0, 120, 0, 25)
SpectateToggleButton.Position = UDim2.new(1, -130, 0.5, -12)
SpectateToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpectateToggleButton.Text = "Select ▷"
SpectateToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
SpectateToggleButton.Font = Enum.Font.Gotham
SpectateToggleButton.TextSize = 12
SpectateToggleButton.Parent = SpectateContainer

local SpectateButtonCorner = Instance.new("UICorner")
SpectateButtonCorner.CornerRadius = UDim.new(0, 4)
SpectateButtonCorner.Parent = SpectateToggleButton

local PlayersSideMenu = Instance.new("Frame")
PlayersSideMenu.Name = "PlayersSideMenu"
PlayersSideMenu.Size = UDim2.new(0, 150, 0, 0)
PlayersSideMenu.Position = UDim2.new(0, SpectateContainer.AbsolutePosition.X + SpectateContainer.AbsoluteSize.X + 5, 0, SpectateContainer.AbsolutePosition.Y - 110)
PlayersSideMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PlayersSideMenu.BorderSizePixel = 0
PlayersSideMenu.Visible = false
PlayersSideMenu.ClipsDescendants = true
PlayersSideMenu.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = PlayersSideMenu

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Thickness = 1
UIStroke.Parent = PlayersSideMenu

local PlayersList = Instance.new("ScrollingFrame")
PlayersList.Size = UDim2.new(1, -5, 1, -5)
PlayersList.Position = UDim2.new(0, 5, 0, 5)
PlayersList.BackgroundTransparency = 1
PlayersList.ScrollBarThickness = 3
PlayersList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
PlayersList.Parent = PlayersSideMenu

local PlayersListLayout = Instance.new("UIListLayout")
PlayersListLayout.Padding = UDim.new(0, 5)
PlayersListLayout.Parent = PlayersList

PlayersListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayersList.CanvasSize = UDim2.new(0, 0, 0, PlayersListLayout.AbsoluteContentSize.Y)
    PlayersSideMenu.Size = UDim2.new(0, 150, 0, math.min(PlayersListLayout.AbsoluteContentSize.Y + 10, 300))
end)

local function updateMenuPosition()
    PlayersSideMenu.Position = UDim2.new(
        0, SpectateContainer.AbsolutePosition.X + SpectateContainer.AbsoluteSize.X + 5,
        0, SpectateContainer.AbsolutePosition.Y - 110
    )
end

SpectateContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateMenuPosition)
SpectateContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateMenuPosition)

-- Функции наблюдателя
local currentSubject = nil

local function spectatePlayer(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        currentSubject = player
        game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        return true
    end
    return false
end

local function stopSpectating()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        currentSubject = nil
        game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end

local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = PlayersList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    local spectateButton = Instance.new("TextButton")
    spectateButton.Size = UDim2.new(0.4, -5, 0.8, 0)
    spectateButton.Position = UDim2.new(0.6, 5, 0.1, 0)
    spectateButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
    spectateButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    spectateButton.Font = Enum.Font.Gotham
    spectateButton.TextSize = 10
    spectateButton.Text = "Spectate"
    spectateButton.Parent = button
    
    local spectateCorner = Instance.new("UICorner")
    spectateCorner.CornerRadius = UDim.new(0, 4)
    spectateCorner.Parent = spectateButton
    
    local function updateButtonState()
        if currentSubject == player then
            spectateButton.Text = "Stop"
            spectateButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        else
            spectateButton.Text = "Spectate"
            spectateButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
        end
    end
    
    spectateButton.MouseButton1Click:Connect(function()
        if currentSubject == player then
            stopSpectating()
        else
            spectatePlayer(player)
        end
        updateButtonState()
    end)
    
    button.MouseButton1Click:Connect(function()
        if currentSubject ~= player then
            spectatePlayer(player)
            updateButtonState()
        end
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
    end)
    
    return button
end

local isMenuOpen = false
SpectateToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    
    if isMenuOpen then
        SpectateToggleButton.Text = "Select ◁"
        updateMenuPosition()
        PlayersSideMenu.Visible = true
    else
        SpectateToggleButton.Text = "Select ▷"
        PlayersSideMenu.Visible = false
    end
end)

-- Добавляем существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end

-- Обработчик новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end)

-- Обработчик ушедших игроков
Players.PlayerRemoving:Connect(function(player)
    if currentSubject == player then
        stopSpectating()
    end
    
    for _, child in ipairs(PlayersList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            child:Destroy()
            break
        end
    end
end)

-- Закрытие меню при клике вне его
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local menuPos = PlayersSideMenu.AbsolutePosition
        local menuSize = PlayersSideMenu.AbsoluteSize
        local buttonPos = SpectateToggleButton.AbsolutePosition
        local buttonSize = SpectateToggleButton.AbsoluteSize
        
        if isMenuOpen and 
           (mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
            mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y) and
           (mousePos.X < buttonPos.X or mousePos.X > buttonPos.X + buttonSize.X or
            mousePos.Y < buttonPos.Y or mousePos.Y > buttonPos.Y + buttonSize.Y) then
            isMenuOpen = false
            PlayersSideMenu.Visible = false
            SpectateToggleButton.Text = "Select ▷"
        end
    end
end)

-- Server Hop
local ServerHopContainer = Instance.new("Frame")
ServerHopContainer.Name = "ServerHop"
ServerHopContainer.Size = UDim2.new(1, -20, 0, 40)
ServerHopContainer.Position = UDim2.new(0, 10, 0, 460) -- Позиция ниже последнего элемента
ServerHopContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ServerHopContainer.BackgroundTransparency = 0.5
ServerHopContainer.Parent = ScriptsFrame

local ServerHopCorner = Instance.new("UICorner")
ServerHopCorner.CornerRadius = UDim.new(0, 6)
ServerHopCorner.Parent = ServerHopContainer

local ServerHopLabel = Instance.new("TextLabel")
ServerHopLabel.Name = "Label"
ServerHopLabel.Size = UDim2.new(0, 120, 1, 0)
ServerHopLabel.Position = UDim2.new(0, 10, 0, 0)
ServerHopLabel.BackgroundTransparency = 1
ServerHopLabel.Text = "Server Hop"
ServerHopLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ServerHopLabel.Font = Enum.Font.GothamBold
ServerHopLabel.TextSize = 14
ServerHopLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerHopLabel.Parent = ServerHopContainer

-- Кнопка с иконкой отпечатка
local FingerprintButton = Instance.new("ImageButton")
FingerprintButton.Name = "FingerprintButton"
FingerprintButton.Size = UDim2.new(0, 30, 0, 30)
FingerprintButton.Position = UDim2.new(1, -35, 0.5, -15)
FingerprintButton.BackgroundTransparency = 1
FingerprintButton.Image = "rbxassetid://132055134833572" -- 
FingerprintButton.Parent = ServerHopContainer

-- Функция Server Hop
local function serverHop()
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local servers = {}
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"))
    end)
    
    if success and result and result.data then
        for i, v in next, result.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
    else
        -- Уведомление (если у вас есть функция notify)
        -- notify("Server Hop", "Couldn't find a server.")
        warn("Server Hop: Couldn't find a server.")
    end
end

-- Анимация при наведении
FingerprintButton.MouseEnter:Connect(function()
    TweenService:Create(FingerprintButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 32, 0, 32)}):Play()
end)

FingerprintButton.MouseLeave:Connect(function()
    TweenService:Create(FingerprintButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
end)

-- Обработчик нажатия
FingerprintButton.MouseButton1Click:Connect(serverHop)

-- Server Low
local ServerLowContainer = Instance.new("Frame")
ServerLowContainer.Name = "ServerLow"
ServerLowContainer.Size = UDim2.new(1, -20, 0, 40)
ServerLowContainer.Position = UDim2.new(0, 10, 0, 510) -- Позиция ниже Server Hop
ServerLowContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ServerLowContainer.BackgroundTransparency = 0.5
ServerLowContainer.Parent = ScriptsFrame

local ServerLowCorner = Instance.new("UICorner")
ServerLowCorner.CornerRadius = UDim.new(0, 6)
ServerLowCorner.Parent = ServerLowContainer

local ServerLowLabel = Instance.new("TextLabel")
ServerLowLabel.Name = "Label"
ServerLowLabel.Size = UDim2.new(0, 120, 1, 0)
ServerLowLabel.Position = UDim2.new(0, 10, 0, 0)
ServerLowLabel.BackgroundTransparency = 1
ServerLowLabel.Text = "Server Low"
ServerLowLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ServerLowLabel.Font = Enum.Font.GothamBold
ServerLowLabel.TextSize = 14
ServerLowLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerLowLabel.Parent = ServerLowContainer

-- Кнопка с иконкой (используем тот же отпечаток)
local LowFingerprintButton = Instance.new("ImageButton")
LowFingerprintButton.Name = "LowFingerprintButton"
LowFingerprintButton.Size = UDim2.new(0, 30, 0, 30)
LowFingerprintButton.Position = UDim2.new(1, -35, 0.5, -15)
LowFingerprintButton.BackgroundTransparency = 1
LowFingerprintButton.Image = "rbxassetid://132055134833572" -- Ваш ID отпечатка
LowFingerprintButton.Parent = ServerLowContainer

-- Функция Server Low
local function serverLow()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local TeleportService = game:GetService("TeleportService")
    
    local function TPReturner()
        local Site
        if foundAnything == "" then
            Site = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'..PlaceID..'/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'..PlaceID..'/servers/Public?sortOrder=Asc&limit=100&cursor='..foundAnything))
        end
        
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        
        local num = 0
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end
                    end
                    num = num + 1
                end
                
                if Possible then
                    table.insert(AllIDs, ID)
                    task.wait()
                    
                    pcall(function()
                        task.wait()
                        TeleportService:TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    
                    task.wait(4)
                end
            end
        end
    end
    
    -- Запускаем процесс поиска
    local connection
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end)
    
    -- Отключаем через 30 секунд если не нашли
    delay(30, function()
        if connection then
            connection:Disconnect()
        end
    end)
end

-- Анимация при наведении
LowFingerprintButton.MouseEnter:Connect(function()
    TweenService:Create(LowFingerprintButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 32, 0, 32)}):Play()
end)

LowFingerprintButton.MouseLeave:Connect(function()
    TweenService:Create(LowFingerprintButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
end)

-- Обработчик нажатия
LowFingerprintButton.MouseButton1Click:Connect(serverLow)

-- Rejoin
local RejoinContainer = Instance.new("Frame")
RejoinContainer.Name = "RejoinSettings"
RejoinContainer.Size = UDim2.new(1, -20, 0, 40)
RejoinContainer.Position = UDim2.new(0, 10, 0, 560) -- Позиция ниже Server Low
RejoinContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
RejoinContainer.BackgroundTransparency = 0.5
RejoinContainer.Parent = ScriptsFrame

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 6)
RejoinCorner.Parent = RejoinContainer

local RejoinLabel = Instance.new("TextLabel")
RejoinLabel.Name = "Label"
RejoinLabel.Size = UDim2.new(0, 120, 1, 0)
RejoinLabel.Position = UDim2.new(0, 10, 0, 0)
RejoinLabel.BackgroundTransparency = 1
RejoinLabel.Text = "Rejoin"
RejoinLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
RejoinLabel.Font = Enum.Font.GothamBold
RejoinLabel.TextSize = 14
RejoinLabel.TextXAlignment = Enum.TextXAlignment.Left
RejoinLabel.Parent = RejoinContainer

-- Кнопка с иконкой (используем тот же отпечаток)
local RejoinButton = Instance.new("ImageButton")
RejoinButton.Name = "RejoinButton"
RejoinButton.Size = UDim2.new(0, 30, 0, 30)
RejoinButton.Position = UDim2.new(1, -35, 0.5, -15)
RejoinButton.BackgroundTransparency = 1
RejoinButton.Image = "rbxassetid://132055134833572" -- Ваш ID отпечатка
RejoinButton.Parent = RejoinContainer

-- Функция Rejoin
local function rejoin()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    
    -- Анимация перед реджоином
    TweenService:Create(RejoinButton, TweenInfo.new(0.3), {Rotation = 360}):Play()
    
    -- Задержка для анимации
    task.delay(0.3, function()
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
    end)
end

-- Анимация при наведении
RejoinButton.MouseEnter:Connect(function()
    TweenService:Create(RejoinButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 32, 0, 32)}):Play()
end)

RejoinButton.MouseLeave:Connect(function()
    TweenService:Create(RejoinButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
end)

-- Обработчик нажатия
RejoinButton.MouseButton1Click:Connect(rejoin)

-- Teleport 
local TeleportContainer = Instance.new("Frame")
TeleportContainer.Name = "TeleportSettings"
TeleportContainer.Size = UDim2.new(1, -20, 0, 40)
TeleportContainer.Position = UDim2.new(0, 10, 0, 610)
TeleportContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TeleportContainer.BackgroundTransparency = 0.5
TeleportContainer.Parent = ScriptsFrame

local TeleportCorner = Instance.new("UICorner")
TeleportCorner.CornerRadius = UDim.new(0, 6)
TeleportCorner.Parent = TeleportContainer

local TeleportLabel = Instance.new("TextLabel")
TeleportLabel.Name = "Label"
TeleportLabel.Size = UDim2.new(0, 120, 1, 0)
TeleportLabel.Position = UDim2.new(0, 10, 0, 0)
TeleportLabel.BackgroundTransparency = 1
TeleportLabel.Text = "Teleport"
TeleportLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TeleportLabel.Font = Enum.Font.GothamBold
TeleportLabel.TextSize = 14
TeleportLabel.TextXAlignment = Enum.TextXAlignment.Left
TeleportLabel.Parent = TeleportContainer

local TeleportToggleButton = Instance.new("TextButton")
TeleportToggleButton.Name = "TeleportToggle"
TeleportToggleButton.Size = UDim2.new(0, 120, 0, 25)
TeleportToggleButton.Position = UDim2.new(1, -130, 0.5, -12)
TeleportToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
TeleportToggleButton.Text = "Select ▷"
TeleportToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
TeleportToggleButton.Font = Enum.Font.Gotham
TeleportToggleButton.TextSize = 12
TeleportToggleButton.Parent = TeleportContainer

local TeleportButtonCorner = Instance.new("UICorner")
TeleportButtonCorner.CornerRadius = UDim.new(0, 4)
TeleportButtonCorner.Parent = TeleportToggleButton

local PlayersSideMenu = Instance.new("Frame")
PlayersSideMenu.Name = "PlayersSideMenu"
PlayersSideMenu.Size = UDim2.new(0, 150, 0, 0)
PlayersSideMenu.Position = UDim2.new(0, TeleportContainer.AbsolutePosition.X + TeleportContainer.AbsoluteSize.X + 5, 0, TeleportContainer.AbsolutePosition.Y - 135)
PlayersSideMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PlayersSideMenu.BorderSizePixel = 0
PlayersSideMenu.Visible = false
PlayersSideMenu.ClipsDescendants = true
PlayersSideMenu.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = PlayersSideMenu

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Thickness = 1
UIStroke.Parent = PlayersSideMenu

local PlayersList = Instance.new("ScrollingFrame")
PlayersList.Size = UDim2.new(1, -5, 1, -5)
PlayersList.Position = UDim2.new(0, 5, 0, 5)
PlayersList.BackgroundTransparency = 1
PlayersList.ScrollBarThickness = 3
PlayersList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
PlayersList.Parent = PlayersSideMenu

local PlayersListLayout = Instance.new("UIListLayout")
PlayersListLayout.Padding = UDim.new(0, 5)
PlayersListLayout.Parent = PlayersList

PlayersListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayersList.CanvasSize = UDim2.new(0, 0, 0, PlayersListLayout.AbsoluteContentSize.Y)
    PlayersSideMenu.Size = UDim2.new(0, 150, 0, math.min(PlayersListLayout.AbsoluteContentSize.Y + 10, 300))
end)

local function updateMenuPosition()
    PlayersSideMenu.Position = UDim2.new(
        0, TeleportContainer.AbsolutePosition.X + TeleportContainer.AbsoluteSize.X + 5,
        0, TeleportContainer.AbsolutePosition.Y - 135
    )
end

TeleportContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateMenuPosition)
TeleportContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateMenuPosition)

local function teleportToPlayer(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end
end

local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = PlayersList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        teleportToPlayer(player)
        PlayersSideMenu.Visible = false
        TeleportToggleButton.Text = "Select ▷"
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
    end)
    
    return button
end

local isMenuOpen = false
TeleportToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    
    if isMenuOpen then
        TeleportToggleButton.Text = "Select ◁"
        updateMenuPosition()
        PlayersSideMenu.Visible = true
    else
        TeleportToggleButton.Text = "Select ▷"
        PlayersSideMenu.Visible = false
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for _, child in ipairs(PlayersList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            child:Destroy()
            break
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local menuPos = PlayersSideMenu.AbsolutePosition
        local menuSize = PlayersSideMenu.AbsoluteSize
        local buttonPos = TeleportToggleButton.AbsolutePosition
        local buttonSize = TeleportToggleButton.AbsoluteSize
        
        if isMenuOpen and 
           (mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
            mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y) and
           (mousePos.X < buttonPos.X or mousePos.X > buttonPos.X + buttonSize.X or
            mousePos.Y < buttonPos.Y or mousePos.Y > buttonPos.Y + buttonSize.Y) then
            isMenuOpen = false
            PlayersSideMenu.Visible = false
            TeleportToggleButton.Text = "Select ▷"
        end
    end
end)
            
local GamesFrame = Instance.new("ScrollingFrame")
GamesFrame.Size = UDim2.new(1, 0, 1, 0)
GamesFrame.Position = UDim2.new(0, 0, 0, 0)
GamesFrame.BackgroundTransparency = 1
GamesFrame.ScrollBarThickness = 3
GamesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
GamesFrame.Visible = false
GamesFrame.Parent = ContentFrame

-- Создаем кнопку Muscle Legends
local MuscleLegendsButton = Instance.new("TextButton")
MuscleLegendsButton.Name = "MuscleLegendsButton"
MuscleLegendsButton.Size = UDim2.new(1, -20, 0, 40)
MuscleLegendsButton.Position = UDim2.new(0, 10, 0, 10) -- Первая позиция в GamesFrame
MuscleLegendsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MuscleLegendsButton.BackgroundTransparency = 0.5
MuscleLegendsButton.Text = "Muscle Legends"
MuscleLegendsButton.TextColor3 = Color3.fromRGB(220, 220, 220)
MuscleLegendsButton.Font = Enum.Font.GothamBold
MuscleLegendsButton.TextSize = 14
MuscleLegendsButton.Parent = GamesFrame

-- Скругление углов
local MuscleLegendsCorner = Instance.new("UICorner")
MuscleLegendsCorner.CornerRadius = UDim.new(0, 6)
MuscleLegendsCorner.Parent = MuscleLegendsButton

-- Иконка игры (можно заменить на другую)
local GameIcon = Instance.new("ImageLabel")
GameIcon.Name = "GameIcon"
GameIcon.Size = UDim2.new(0, 30, 0, 30)
GameIcon.Position = UDim2.new(0, 5, 0.5, -15)
GameIcon.BackgroundTransparency = 1
GameIcon.Image = "rbxassetid://132055134833572" -- Замените на нужный ID изображения
GameIcon.Parent = MuscleLegendsButton

-- Анимация при наведении
MuscleLegendsButton.MouseEnter:Connect(function()
    TweenService:Create(MuscleLegendsButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
    TweenService:Create(GameIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 4, 0.5, -16)}):Play()
end)

MuscleLegendsButton.MouseLeave:Connect(function()
    TweenService:Create(MuscleLegendsButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
    TweenService:Create(GameIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(0, 5, 0.5, -15)}):Play()
end)

-- Обработчик нажатия
MuscleLegendsButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/MuscleLegends.lua"))()
    
    -- Анимация нажатия
    TweenService:Create(MuscleLegendsButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
    TweenService:Create(MuscleLegendsButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)

-- Тут будет легенд оф спеад

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

-- You F*ck (в разделе Троллинг)
local YouFuckContainer = Instance.new("Frame")
YouFuckContainer.Name = "YouFuckSettings"
YouFuckContainer.Size = UDim2.new(1, -20, 0, 40)
YouFuckContainer.Position = UDim2.new(0, 10, 0, 60) -- Позиция после WalkFling
YouFuckContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
YouFuckContainer.BackgroundTransparency = 0.5
YouFuckContainer.Parent = TrollFrame

local YouFuckCorner = Instance.new("UICorner")
YouFuckCorner.CornerRadius = UDim.new(0, 6)
YouFuckCorner.Parent = YouFuckContainer

local YouFuckLabel = Instance.new("TextLabel")
YouFuckLabel.Name = "Label"
YouFuckLabel.Size = UDim2.new(0, 120, 1, 0)
YouFuckLabel.Position = UDim2.new(0, 10, 0, 0)
YouFuckLabel.BackgroundTransparency = 1
YouFuckLabel.Text = "Е**ть игроков"
YouFuckLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
YouFuckLabel.Font = Enum.Font.GothamBold
YouFuckLabel.TextSize = 14
YouFuckLabel.TextXAlignment = Enum.TextXAlignment.Left
YouFuckLabel.Parent = YouFuckContainer

local YouFuckToggleButton = Instance.new("TextButton")
YouFuckToggleButton.Name = "YouFuckToggle"
YouFuckToggleButton.Size = UDim2.new(0, 120, 0, 25)
YouFuckToggleButton.Position = UDim2.new(1, -130, 0.5, -12)
YouFuckToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
YouFuckToggleButton.Text = "Select ▷"
YouFuckToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
YouFuckToggleButton.Font = Enum.Font.Gotham
YouFuckToggleButton.TextSize = 12
YouFuckToggleButton.Parent = YouFuckContainer

local YouFuckButtonCorner = Instance.new("UICorner")
YouFuckButtonCorner.CornerRadius = UDim.new(0, 4)
YouFuckButtonCorner.Parent = YouFuckToggleButton

-- Меню выбора игрока
local YouFuckSideMenu = Instance.new("Frame")
YouFuckSideMenu.Name = "YouFuckSideMenu"
YouFuckSideMenu.Size = UDim2.new(0, 150, 0, 0)
YouFuckSideMenu.Position = UDim2.new(0, YouFuckContainer.AbsolutePosition.X + YouFuckContainer.AbsoluteSize.X + 5, 0, YouFuckContainer.AbsolutePosition.Y - 250)
YouFuckSideMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
YouFuckSideMenu.BorderSizePixel = 0
YouFuckSideMenu.Visible = false
YouFuckSideMenu.ClipsDescendants = true
YouFuckSideMenu.Parent = ScreenGui

local YouFuckUICorner = Instance.new("UICorner")
YouFuckUICorner.CornerRadius = UDim.new(0, 6)
YouFuckUICorner.Parent = YouFuckSideMenu

local YouFuckUIStroke = Instance.new("UIStroke")
YouFuckUIStroke.Color = Color3.fromRGB(80, 80, 80)
YouFuckUIStroke.Thickness = 1
YouFuckUIStroke.Parent = YouFuckSideMenu

local YouFuckPlayersList = Instance.new("ScrollingFrame")
YouFuckPlayersList.Size = UDim2.new(1, -5, 1, -5)
YouFuckPlayersList.Position = UDim2.new(0, 5, 0, 5)
YouFuckPlayersList.BackgroundTransparency = 1
YouFuckPlayersList.ScrollBarThickness = 3
YouFuckPlayersList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
YouFuckPlayersList.Parent = YouFuckSideMenu

local YouFuckPlayersListLayout = Instance.new("UIListLayout")
YouFuckPlayersListLayout.Padding = UDim.new(0, 5)
YouFuckPlayersListLayout.Parent = YouFuckPlayersList

YouFuckPlayersListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    YouFuckPlayersList.CanvasSize = UDim2.new(0, 0, 0, YouFuckPlayersListLayout.AbsoluteContentSize.Y)
    YouFuckSideMenu.Size = UDim2.new(0, 150, 0, math.min(YouFuckPlayersListLayout.AbsoluteContentSize.Y + 10, 300))
end)

local function updateYouFuckMenuPosition()
    YouFuckSideMenu.Position = UDim2.new(
        0, YouFuckContainer.AbsolutePosition.X + YouFuckContainer.AbsoluteSize.X + 5,
        0, YouFuckContainer.AbsolutePosition.Y - 250
    )
end

YouFuckContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateYouFuckMenuPosition)
YouFuckContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateYouFuckMenuPosition)

-- Переменные для YouFuck
local youFuckEnabled = false
local youFuckTarget = nil
local youFuckConnection = nil
local youFuckOffset = 0
local youFuckDirection = 1

local function youFuckPlayer(player)
    if not youFuckEnabled or not player or not player.Character then return end
    
    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
    local myRoot = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Torso"))
    
    if not (targetRoot and myRoot) then return end
    
    -- Меняем смещение для эффекта "движения"
    youFuckOffset = youFuckOffset + (0.2 * youFuckDirection)
    if math.abs(youFuckOffset) > 1.5 then
        youFuckDirection = youFuckDirection * -1
    end
    
    -- Вычисляем позицию за спиной игрока с небольшим смещением
    local targetCFrame = targetRoot.CFrame
    local offset = targetCFrame.LookVector * (-2 + youFuckOffset) + Vector3.new(0, 0.5, 0)
    
    myRoot.CFrame = CFrame.new(targetCFrame.Position + offset, targetCFrame.Position + targetCFrame.LookVector * 10)
end

local function createYouFuckPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = YouFuckPlayersList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if youFuckTarget == player then
            -- Если уже выбран этот игрок, отключаем
            youFuckEnabled = false
            youFuckTarget = nil
            YouFuckToggleButton.Text = "Select ▷"
            if youFuckConnection then
                youFuckConnection:Disconnect()
                youFuckConnection = nil
            end
        else
            -- Выбираем нового игрока
            youFuckTarget = player
            youFuckEnabled = true
            YouFuckToggleButton.Text = player.Name.." ◁"
            
            if youFuckConnection then
                youFuckConnection:Disconnect()
            end
            
            youFuckConnection = RunService.Heartbeat:Connect(function()
                youFuckPlayer(player)
            end)
        end
        
        YouFuckSideMenu.Visible = false
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
    end)
    
    return button
end

local isYouFuckMenuOpen = false
YouFuckToggleButton.MouseButton1Click:Connect(function()
    if youFuckEnabled and youFuckTarget then
        -- Если уже активировано, отключаем
        youFuckEnabled = false
        youFuckTarget = nil
        YouFuckToggleButton.Text = "Select ▷"
        if youFuckConnection then
            youFuckConnection:Disconnect()
            youFuckConnection = nil
        end
    else
        -- Открываем меню выбора
        isYouFuckMenuOpen = not isYouFuckMenuOpen
        
        if isYouFuckMenuOpen then
            YouFuckToggleButton.Text = "Select ◁"
            updateYouFuckMenuPosition()
            YouFuckSideMenu.Visible = true
        else
            YouFuckToggleButton.Text = "Select ▷"
            YouFuckSideMenu.Visible = false
        end
    end
end)

-- Добавляем существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createYouFuckPlayerButton(player)
    end
end

-- Обработка новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createYouFuckPlayerButton(player)
    end
end)

-- Обработка ушедших игроков
Players.PlayerRemoving:Connect(function(player)
    if player == youFuckTarget then
        youFuckEnabled = false
        youFuckTarget = nil
        YouFuckToggleButton.Text = "Select ▷"
        if youFuckConnection then
            youFuckConnection:Disconnect()
            youFuckConnection = nil
        end
    end
    
    for _, child in ipairs(YouFuckPlayersList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            child:Destroy()
            break
        end
    end
end)

-- Закрытие меню при клике вне его
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local menuPos = YouFuckSideMenu.AbsolutePosition
        local menuSize = YouFuckSideMenu.AbsoluteSize
        local buttonPos = YouFuckToggleButton.AbsolutePosition
        local buttonSize = YouFuckToggleButton.AbsoluteSize
        
        if isYouFuckMenuOpen and 
           (mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
            mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y) and
           (mousePos.X < buttonPos.X or mousePos.X > buttonPos.X + buttonSize.X or
            mousePos.Y < buttonPos.Y or mousePos.Y > buttonPos.Y + buttonSize.Y) then
            isYouFuckMenuOpen = false
            YouFuckSideMenu.Visible = false
            YouFuckToggleButton.Text = "Select ▷"
        end
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
