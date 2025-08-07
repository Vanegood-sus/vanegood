-- Vanegood Hub by Vanegood-sus
-- GitHub: https://github.com/Vanegood-sus/vanegood

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Неоновая обводка
local NeonBorder = Instance.new("Frame")
NeonBorder.Size = UDim2.new(1, 4, 1, 4)
NeonBorder.Position = UDim2.new(0, -2, 0, -2)
NeonBorder.BackgroundTransparency = 1
NeonBorder.BorderSizePixel = 0
NeonBorder.ZIndex = 0
NeonBorder.Parent = MainFrame

local NeonUIStroke = Instance.new("UIStroke")
NeonUIStroke.Color = Color3.fromRGB(0, 255, 255)  -- Голубой цвет как в Anti-AFK
NeonUIStroke.Thickness = 2
NeonUIStroke.Transparency = 0.5
NeonUIStroke.Parent = NeonBorder

local NeonUIStroke = Instance.new("UIStroke")
NeonUIStroke.Color = Color3.fromRGB(255, 40, 40)
NeonUIStroke.Thickness = 2
NeonUIStroke.Transparency = 0.5
NeonUIStroke.Parent = NeonBorder

-- Анимация неоновой обводки
local pulseSpeed = 1
local pulseIntensity = 0.7
RunService.Heartbeat:Connect(function(dt)
    local time = os.clock() * pulseSpeed
    local alpha = (math.sin(time) + 1) / 2 * pulseIntensity + (1 - pulseIntensity)
    NeonUIStroke.Transparency = 1 - alpha
end)

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
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
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Панель вкладок
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Вкладка "Скрипты"
local ScriptsTab = Instance.new("TextButton")
ScriptsTab.Size = UDim2.new(0.5, 0, 1, 0)
ScriptsTab.Position = UDim2.new(0, 0, 0, 0)
ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ScriptsTab.Text = "СКРИПТЫ"
ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
ScriptsTab.Font = Enum.Font.GothamBold
ScriptsTab.TextSize = 12
ScriptsTab.Parent = TabBar

-- Вкладка "Игры"
local GamesTab = Instance.new("TextButton")
GamesTab.Size = UDim2.new(0.5, 0, 1, 0)
GamesTab.Position = UDim2.new(0.5, 0, 0, 0)
GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GamesTab.Text = "ИГРЫ"
GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
GamesTab.Font = Enum.Font.GothamBold
GamesTab.TextSize = 12
GamesTab.Parent = TabBar

-- Индикатор активной вкладки
local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(0.5, 0, 0, 2)
ActiveTabIndicator.Position = UDim2.new(0, 0, 1, -2)
ActiveTabIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 255)  -- Голубой цвет
ActiveTabIndicator.BorderSizePixel = 0
ActiveTabIndicator.Parent = TabBar

-- Контентная область
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Фрейм для скриптов
local ScriptsFrame = Instance.new("ScrollingFrame")
ScriptsFrame.Size = UDim2.new(1, 0, 1, 0)
ScriptsFrame.Position = UDim2.new(0, 0, 0, 0)
ScriptsFrame.BackgroundTransparency = 1
ScriptsFrame.ScrollBarThickness = 3
ScriptsFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScriptsFrame.Visible = true
ScriptsFrame.Parent = ContentFrame

local UIListLayoutScripts = Instance.new("UIListLayout")
UIListLayoutScripts.Padding = UDim.new(0, 5)
UIListLayoutScripts.Parent = ScriptsFrame

-- Фрейм для игр
local GamesFrame = Instance.new("ScrollingFrame")
GamesFrame.Size = UDim2.new(1, 0, 1, 0)
GamesFrame.Position = UDim2.new(0, 0, 0, 0)
GamesFrame.BackgroundTransparency = 1
GamesFrame.ScrollBarThickness = 3
GamesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
GamesFrame.Visible = false
GamesFrame.Parent = ContentFrame

local UIListLayoutGames = Instance.new("UIListLayout")
UIListLayoutGames.Padding = UDim.new(0, 5)
UIListLayoutGames.Parent = GamesFrame

-- Функция создания кнопки
local function createButton(name, description)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 50)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    button.Text = ""
    button.AutoButtonColor = false
    button.Parent = ScriptsFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(80, 80, 80)
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(220, 220, 220)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = button
    
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -10, 0, 20)
    desc.Position = UDim2.new(0, 10, 0, 25)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Color3.fromRGB(180, 180, 180)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 60, 60)}):Play()
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 255, 255)}):Play()  -- Голубой
end)
    
    return button
end

-- Функция загрузки скрипта
local function loadScript(scriptName)
    local success, err = pcall(function()
        local url = "https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/"..scriptName
        local response = game:HttpGet(url, true)
        loadstring(response)()
    end)
    
    if not success then
        warn("Ошибка загрузки скрипта: "..err)
    end
end

-- Список скриптов
local scripts = {
    {Name = "Fly", File = "Fly.lua", Desc = "Полет"},
    {Name = "Anti-Afk", File = "Anti-Afk.lua", Desc = "Защита от кика за бездействие"},
    {Name = "Shiftlock", File = "Shiftlock.lua", Desc = "Фикс камеры от третьего лица"},
    {Name = "Spectator", File = "Spectator.lua", Desc = "Режим наблюдателя"},
    {Name = "Spin", File = "Spin.lua", Desc = "Вращение персонажа"},
    {Name = "Esp", File = "Esp.lua", Desc = "Обозначение людей"},
    {Name = "HitBox", File = "HitBox.lua", Desc = "Прибавить хитбокс"},
    {Name = "Teleport", File = "Tp.lua", Desc = "Телепортация к игроку"},
    {Name = "Set Speed", File = "Speed.lua", Desc = "Изменить скорость"},
    {Name = "Infinity Jump", File = "InfJump.lua", Desc = "Бесконечные прыжки"},
    {Name = "Rejoin", File = "Rejoin.lua", Desc = "Перезаход на тот сервер,где ты сейчас"},
    {Name = "Aimbot", File = "Aim.lua", Desc = "Автонаводка"},
    {Name = "Server-Hope", File = "Hope.lua", Desc = "Зайти на сервер с большим онлайном"}
}

-- Список игр
local games = {
    {Name = "Legend of Speed", File = "LegendOfSpeed.lua", Desc = "Автофарм орбов,перерождений"},
    {Name = "Muscle Legends", File = "MuscleLegends.lua", Desc = "Автофарм,автооткрытие яиц и многое другое"},
    {Name = "NPC or Die", File = "NpcOrDie.lua", Desc = "Авто выполнение заданий,авто паркур"}
}

-- Создаем кнопки скриптов
for _, script in pairs(scripts) do
    local button = createButton(script.Name, script.Desc)
    button.Parent = ScriptsFrame
    
    button.MouseButton1Click:Connect(function()
        loadScript(script.File)
    end)
end

-- Создаем кнопки игр
for _, game in pairs(games) do
    local button = createButton(game.Name, game.Desc)
    button.Parent = GamesFrame
end

-- Функция переключения вкладок
local function switchTab(tab)
    if tab == "scripts" then
        ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
        
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 0, 1, -2)}):Play()
        
        ScriptsFrame.Visible = true
        GamesFrame.Visible = false
    else
        GamesTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        GamesTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        ScriptsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        ScriptsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
        
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.5, 0, 1, -2)}):Play()
        
        GamesFrame.Visible = true
        ScriptsFrame.Visible = false
    end
end

-- Обработчики вкладок
ScriptsTab.MouseButton1Click:Connect(function()
    switchTab("scripts")
end)

GamesTab.MouseButton1Click:Connect(function()
    switchTab("games")
end)

-- Функция минимизации
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 320, 0, 30)
        ContentFrame.Visible = false
        TabBar.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 320, 0, 450)
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
    MessageFrame.BackgroundTransparency = 0.1
    MessageFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MessageFrame
    
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
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
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

-- Автоматическая подгонка размеров
ScriptsFrame.ChildAdded:Connect(function()
    ScriptsFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutScripts.AbsoluteContentSize.Y)
end)

GamesFrame.ChildAdded:Connect(function()
    GamesFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutGames.AbsoluteContentSize.Y)
end)

-- Инициализация (открываем скрипты по умолчанию)
switchTab("scripts")
