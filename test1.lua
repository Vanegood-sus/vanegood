-- Встроенный ESP в твой хаб Vanegood Hub by Vanegood-sus
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем мини-иконку (по твоему стилю)
local imageSize = 75
local imageFrame = Instance.new("Frame")
imageFrame.Name = "TinyRoundedImage"
imageFrame.Size = UDim2.new(0, imageSize, 0, imageSize)
imageFrame.Position = UDim2.new(0, 20, 0, 20)
imageFrame.BackgroundTransparency = 1
imageFrame.ClipsDescendants = true
imageFrame.Parent = ScreenGui

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

-- Перетаскивание мини-иконки
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

-- Основной хаб
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

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
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

-- Индикатор активной вкладки
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

-- Создаем вкладки
local ScriptsFrame = Instance.new("ScrollingFrame")
ScriptsFrame.Size = UDim2.new(1, 0, 1, 0)
ScriptsFrame.Position = UDim2.new(0, 0, 0, 0)
ScriptsFrame.BackgroundTransparency = 1
ScriptsFrame.ScrollBarThickness = 3
ScriptsFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScriptsFrame.Visible = true
ScriptsFrame.Parent = ContentFrame

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

-- Переключение вкладок
local function switchTab(tab)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
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
    elseif tab == "troll" then
        TrollTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TrollTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.66, 0, 1, -2)}):Play()
        TrollFrame.Visible = true
    end
end

ScriptsTab.MouseButton1Click:Connect(function() switchTab("scripts") end)
GamesTab.MouseButton1Click:Connect(function() switchTab("games") end)
TrollTab.MouseButton1Click:Connect(function() switchTab("troll") end)

-- Минимизация
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

-- Закрытие
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
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
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
    end)
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end)

-- Встроенная ESP вкладка
local espEnabled = false
local espObjects = {}
local lastUpdate = 0
local updateInterval = 0.2

local EspTab = Instance.new("TextButton")
EspTab.Size = UDim2.new(0.33, 0, 1, 0)
EspTab.Position = UDim2.new(0, 0, 0, 0)
EspTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
EspTab.Text = "ESP"
EspTab.TextColor3 = Color3.fromRGB(180, 180, 180)
EspTab.Font = Enum.Font.GothamBold
EspTab.TextSize = 12
EspTab.Parent = TabBar

local EspContent = Instance.new("Frame")
EspContent.Size = UDim2.new(1, 0, 1, 0)
EspContent.Position = UDim2.new(0, 0, 0, 0)
EspContent.BackgroundTransparency = 1
EspContent.Parent = ContentFrame

local espToggleFrame = Instance.new("Frame")
espToggleFrame.Size = UDim2.new(1, -20, 0, 40)
espToggleFrame.Position = UDim2.new(0, 10, 0, 10)
espToggleFrame.BackgroundTransparency = 1
espToggleFrame.Parent = EspContent

local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(0, 60, 1, 0)
espLabel.Position = UDim2.new(0, 0, 0, 0)
espLabel.BackgroundTransparency = 1
espLabel.Text = "ESP Включить"
espLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
espLabel.Font = Enum.Font.GothamMedium
espLabel.TextSize = 14
espLabel.TextXAlignment = Enum.TextXAlignment.Left
espLabel.Parent = espToggleFrame

local toggleSliderFrame = Instance.new("Frame")
toggleSliderFrame.Size = UDim2.new(0, 150, 0, 25)
toggleSliderFrame.Position = UDim2.new(0, 70, 0, 7)
toggleSliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
toggleSliderFrame.BorderSizePixel = 0
toggleSliderFrame.Parent = espToggleFrame

local sliderUICorner = Instance.new("UICorner")
sliderUICorner.CornerRadius = UDim.new(1, 0)
sliderUICorner.Parent = toggleSliderFrame

local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 21, 0, 21)
sliderButton.Position = UDim2.new(0, 2, 0.5, -10)
sliderButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
sliderButton.Text = ""
sliderButton.Parent = toggleSliderFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(1, 0)
sliderCorner.Parent = sliderButton

local espActive = false -- состояние переключателя

local function updateSliderPosition()
    local goalPos = espActive and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    local goalColor = espActive and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    local goalBgColor = espActive and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(sliderButton, TweenInfo.new(0.2), {Position = goalPos, BackgroundColor3 = goalColor})
    tween:Play()
end

sliderButton.MouseButton1Click:Connect(function()
    espActive = not espActive
    updateSliderPosition()
end)

-- Функция очистки ESP
local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj.highlight then obj.highlight:Destroy() end
        if obj.label then obj.label:Destroy() end
    end
    espObjects = {}
end

-- Проверка врага
local function isEnemy(player)
    if player:FindFirstChild("Team") and player.Team.Name:lower():find("killer") then
        return true
    end
    if player.Team and LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    end
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool or (humanoid and humanoid:GetAttribute("CanAttack") == true) then
            return true
        end
    end
    return false
end

local function isAlly(player)
    if player.Team and LocalPlayer.Team then
        return player.Team == LocalPlayer.Team
    end
    return false
end

-- Обновление ESP
local function updateESP()
    if not espActive then return end
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
                    label.TextColor3 = Color3.new(1,1,1)
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 12
                    label.TextStrokeTransparency = 0.7
                    label.TextStrokeColor3 = Color3.new(0,0,0)
                    label.Parent = ScreenGui

                    espObjects[player] = {highlight=highlight, label=label}
                end
                local data = espObjects[player]
                if enemy then
                    data.highlight.FillColor = Color3.fromRGB(255,70,70)
                    data.highlight.OutlineColor = Color3.fromRGB(180,0,0)
                elseif ally then
                    data.highlight.FillColor = Color3.fromRGB(70,255,70)
                    data.highlight.OutlineColor = Color3.fromRGB(0,180,0)
                else
                    data.highlight.FillColor = Color3.fromRGB(70,70,255)
                    data.highlight.OutlineColor = Color3.fromRGB(0,0,180)
                end
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and
                        (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0
                    data.label.Text = string.format("%s [%d]", player.Name, math.floor(distance))
                    data.label.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 35)
                    data.label.Visible = true
                else
                    data.label.Visible = false
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

-- Обрабатываем вкладку ESP
EspTab.MouseButton1Click:Connect(function()
    -- Сделать активной только вкладку ESP
    switchTab("troll") -- или другую, чтобы просто переключиться
    -- Но чтобы оставить активной вкладку и показывать ESP
    -- Можно оставить так или по желанию
end)

-- Основной цикл
RunService.Heartbeat:Connect(function()
    if espActive then
        updateESP()
    end
end)

-- Инициализация
updateSliderPosition()
