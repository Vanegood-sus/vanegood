
-- Combined Vanegood Hub + Muscle Legends functions

-- Vanegood Hub
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


-- Compatibility shim: minimal 'library' that emulates AddWindow/AddTab/AddFolder/AddSwitch/AddButton/AddLabel/AddDropdown/AddTextBox
local library = {}
local function createContainer(parent, title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(220,220,220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Parent = frame
    return frame
end

function library:AddWindow(title, opts)
    local window = {}
    window._container = ScriptsFrame -- attach to the hub scripts area
    function window:AddTab(name)
        local tab = {}
        tab._frame = Instance.new("Frame")
        tab._frame.Size = UDim2.new(1, 0, 0, 20)
        tab._frame.BackgroundTransparency = 1
        tab._frame.Parent = window._container

        tab._layout = Instance.new("UIListLayout")
        tab._layout.Parent = tab._frame
        tab._layout.SortOrder = Enum.SortOrder.LayoutOrder
        tab._layout.Padding = UDim.new(0, 6)

        function tab:AddFolder(folderName)
            local folder = {}
            folder._frame = Instance.new("Frame")
            folder._frame.Size = UDim2.new(1, 0, 0, 40)
            folder._frame.BackgroundTransparency = 1
            folder._frame.Parent = tab._frame

            folder._layout = Instance.new("UIListLayout")
            folder._layout.Parent = folder._frame
            folder._layout.SortOrder = Enum.SortOrder.LayoutOrder
            folder._layout.Padding = UDim.new(0, 6)

            function folder:AddLabel(text)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 20)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(220,220,220)
                lbl.Font = Enum.Font.Gotham
                lbl.TextSize = 14
                lbl.Parent = folder._frame
                return lbl
            end

            function folder:AddButton(text, cb, tooltip)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                btn.TextColor3 = Color3.fromRGB(220,220,220)
                btn.Text = text
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 14
                btn.Parent = folder._frame
                if cb then btn.MouseButton1Click:Connect(function() pcall(cb) end) end
                return btn
            end

            function folder:AddSwitch(text, cb, default)
                local container = Instance.new("Frame")
                container.Size = UDim2.new(1, 0, 0, 28)
                container.BackgroundTransparency = 1
                container.Parent = folder._frame

                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0.8, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(220,220,220)
                lbl.Font = Enum.Font.Gotham
                lbl.TextSize = 14
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = container

                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0.18, -4, 1, -4)
                btn.Position = UDim2.new(0.82, 0, 0, 2)
                btn.BackgroundColor3 = default and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,100,100)
                btn.Text = default and "ON" or "OFF"
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 12
                btn.Parent = container

                local state = default or false
                local function setState(s)
                    state = s and true or false
                    btn.BackgroundColor3 = state and Color3.fromRGB(0,150,0) or Color3.fromRGB(100,100,100)
                    btn.Text = state and "ON" or "OFF"
                    if cb then pcall(cb, state) end
                end
                btn.MouseButton1Click:Connect(function() setState(not state) end)

                local wrapper = {Set = setState}
                return wrapper
            end

            function folder:AddDropdown(text, cb)
                local dropdown = {}
                dropdown._frame = Instance.new("Frame")
                dropdown._frame.Size = UDim2.new(1, 0, 0, 28)
                dropdown._frame.BackgroundTransparency = 1
                dropdown._frame.Parent = folder._frame

                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0.6, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(220,220,220)
                lbl.Font = Enum.Font.Gotham
                lbl.TextSize = 14
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = dropdown._frame

                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0.4, 0, 1, 0)
                btn.Position = UDim2.new(0.6, 0, 0, 0)
                btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                btn.Text = "Select"
                btn.TextColor3 = Color3.fromRGB(220,220,220)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 14
                btn.Parent = dropdown._frame

                dropdown._options = {}
                function dropdown:Add(opt)
                    table.insert(dropdown._options, opt)
                end
                btn.MouseButton1Click:Connect(function()
                    -- cycle options for simplicity
                    if #dropdown._options > 0 then
                        dropdown._index = (dropdown._index or 0) + 1
                        if dropdown._index > #dropdown._options then dropdown._index = 1 end
                        local sel = dropdown._options[dropdown._index]
                        btn.Text = tostring(sel)
                        if cb then pcall(cb, sel) end
                    end
                end)

                return dropdown
            end

            function folder:AddTextBox(text, cb)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,30)
                frame.BackgroundTransparency = 1
                frame.Parent = folder._frame

                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0.4,0,1,0)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(220,220,220)
                lbl.Font = Enum.Font.Gotham
                lbl.TextSize = 14
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = frame

                local tb = Instance.new("TextBox")
                tb.Size = UDim2.new(0.6, -4, 1, -4)
                tb.Position = UDim2.new(0.4, 4, 0, 2)
                tb.BackgroundColor3 = Color3.fromRGB(50,50,60)
                tb.TextColor3 = Color3.fromRGB(220,220,220)
                tb.Text = ""
                tb.Font = Enum.Font.Gotham
                tb.TextSize = 14
                tb.Parent = frame

                tb.FocusLost:Connect(function(enter)
                    if cb then pcall(cb, tb.Text) end
                end)

                return tb
            end

            return folder
        end

        function tab:AddLabel(text)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1,0,0,20)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(220,220,220)
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.Parent = tab._frame
            return lbl
        end

        function tab:AddSwitch(text, cb, default)
            local fakeFolder = tab:AddFolder("")
            return fakeFolder:AddSwitch(text, cb, default)
        end

        function tab:AddButton(text, cb, tooltip)
            local fakeFolder = tab:AddFolder("")
            return fakeFolder:AddButton(text, cb, tooltip)
        end

        function tab:AddDropdown(text, cb)
            local fakeFolder = tab:AddFolder("")
            return fakeFolder:AddDropdown(text, cb)
        end

        function tab:AddTextBox(text, cb)
            local fakeFolder = tab:AddFolder("")
            return fakeFolder:AddTextBox(text, cb)
        end

        return tab
    end
    return window
end


-- Initialize minimal game variables expected by the Muscle Legends code
local player = Players.LocalPlayer
local VirtualUser = game:GetService('VirtualUser')
local antiAFKConnection = nil

-- Create window and tabs/folders placeholders used by the Muscle Legends script
local window = library:AddWindow('Muscle Legends', {main_color = Color3.fromRGB(255,165,50), min_size = Vector2.new(800,900), can_resize = true})
local mainTab = window:AddTab('Меню')
local farmPlusTab = window:AddTab('Фарм')
mainTab:AddLabel('Добро Пожаловать!')

local autoBrawlsFolder = mainTab:AddFolder('Авто бой')
local farmGymsFolder = mainTab:AddFolder('Залы')
local opThingsFolder = mainTab:AddFolder('Остальное')
local autoRockFolder = farmPlusTab:AddFolder('Бить камень')
local rebirthsFolder = farmPlusTab:AddFolder('Перерождения')
local autoEquipToolsFolder = farmPlusTab:AddFolder('Автоматически качатся')
local statsFolder = farmPlusTab:AddFolder('Статистика')
local pets = window:AddTab('Петы')
local miscTab = window:AddTab('Другое')
local misc1Folder = miscTab:AddFolder('Авто рулетка и подарки')
local killerTab = window:AddTab('Убийства')
local teleportTab = window:AddTab('Телепорт')

-- Now append the extracted Muscle Legends code (functions and UI bindings)

local function setupAntiAFK()
    -- Disconnect previous connection if it exists
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end


    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-Афк")
    end)


mainTab:AddSwitch("Анти-Афк", function(bool)
    antiAFKEnabled = bool
    
    if bool then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
            print("Anti-AFK system disabled")
        end


local autoWinBrawlSwitch = autoBrawlsFolder:AddSwitch("Авто выйгрыш", function(bool)
    getgenv().autoWinBrawl = bool
    
    -- Equip Punch Tool function - will be called repeatedly
    local function equipPunch()
        if not getgenv().autoWinBrawl then return end
        
        local character = game.Players.LocalPlayer.Character
        if not character then return false end


    local function isValidTarget(player)
        if not player or not player.Parent then return false end


    local function isLocalPlayerReady()
        local player = game.Players.LocalPlayer
        if not player then return false end


    local function safeTouchInterest(targetPart, localPart)
        if not targetPart or not targetPart.Parent then return false end


        local success, err = pcall(function()
            firetouchinterest(targetPart, localPart, 0)
            task.wait(0.01)
            firetouchinterest(targetPart, localPart, 1)
        end)


    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if not getgenv().autoWinBrawl then break end


    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.1) do
            if not getgenv().autoWinBrawl then break end


                pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)


                pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)


    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.05) do
            if not getgenv().autoWinBrawl then break end


                    pcall(function()
                        if isValidTarget(player) then
                            local targetRoot = player.Character.HumanoidRootPart
                            
                            -- Try left hand
                            if leftHand then
                                safeTouchInterest(targetRoot, leftHand)
                            end


    task.spawn(function()
        local lastPlayerCount = 0
        local stuckCounter = 0
        
        while getgenv().autoWinBrawl and task.wait(1) do
            if not getgenv().autoWinBrawl then break end


                    pcall(function()
                        local character = game.Players.LocalPlayer.Character
                        if character and character:FindFirstChild("Punch") then
                            character.Punch.Parent = game.Players.LocalPlayer.Backpack
                            task.wait(0.1)
                            equipPunch()
                        else
                            equipPunch()
                        end


autoBrawlsFolder:AddSwitch("Автоматом вступать в бой", function(bool)
    getgenv().autoJoinBrawl = bool
    
    task.spawn(function()
        while getgenv().autoJoinBrawl and task.wait(0.5) do
            if not getgenv().autoJoinBrawl then break end
            
            if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                -- Set the label to not visible to prevent multiple joins
                game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end


local function teleportAndStart(workoutType, position)
    if not position then return end


    task.spawn(function()
        while getgenv().workingGym do
            if not getgenv().workingGym then break end


            local success, err = pcall(function()
                -- Trigger workout events based on type
                if workoutType == "Жим лежа" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("benchPress")
                elseif workoutType == "Жим с присяда" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("squat")
                elseif workoutType == "Становая тяга" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("deadlift")
                elseif workoutType == "Поднимать камень" then
                    game.ReplicatedStorage.rEvents.workoutEvent:FireServer("pullUp")
                end


    local dropdown = farmGymsFolder:AddDropdown(spanishWorkoutName .. " - Зал", function(selected)
        _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] = selected
    end)


    local toggle = farmGymsFolder:AddSwitch(spanishWorkoutName, function(bool)
        getgenv().workingGym = bool
        getgenv().currentWorkoutType = workoutType
        
        if bool then
            local selectedGym = _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] or gymLocations[1]
            
            -- Make sure we have a valid position
            if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGym] then
                -- Stop any other workout that might be running
                for otherType, otherToggle in pairs(gymToggles) do
                    if otherType ~= workoutType and otherToggle then
                        otherToggle:Set(false)
                    end


opThingsFolder:AddSwitch("Анти отбрасывание", function(Value)
    if Value then
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.P = 1250
        bodyVelocity.Parent = rootPart
    else
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
        if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
            existingVelocity:Destroy()
        end


local function lockPlayerPosition(position)
    if positionLockConnection then
        positionLockConnection:Disconnect()
    end


    positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = position
        end


local function unlockPlayerPosition()
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end


opThingsFolder:AddSwitch("Стоять на месте", function(bool)
    if bool then
        -- Get current position and lock it
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            lockPlayerPosition(currentPosition)
        end


local frameToggle = opThingsFolder:AddSwitch("Скрывать рамки", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end


local speedGrind = opThingsFolder:AddSwitch("Быстрая сила", function(bool)
    local isGrinding = bool
    
    if not bool then
        unequipAllPets()
        return
    end


        task.spawn(function()
            while isGrinding do
                player.muscleEvent:FireServer("rep")
                task.wait()
            end


function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end


autoRockFolder:AddSwitch("Маленький камень - 0", function(Value)
    selectrock = "Tiny Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Средний камень - 100", function(Value)
    selectrock = "Starter Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Золотой камень - 5000", function(Value)
    selectrock = "Legend Beach Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Ледяной камень - 150000", function(Value)
    selectrock = "Frost Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 150000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Мифический камень - 400000", function(Value)
    selectrock = "Mythical Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 400000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Адский камень - 750000", function(Value)
    selectrock = "Eternal Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 750000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Легендарный камень - 1000000", function(Value)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 1000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Королевский камень - 5000000", function(Value)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


autoRockFolder:AddSwitch("Камень в Джунглях 10000000", function(Value)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 10000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end


rebirthsFolder:AddTextBox("Сколько нужно?", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет " .. targetRebirthValue .. " перерождений",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Всё",
            Text = "Остановил как и обещал",
            Duration = 0
        })
    end


local targetSwitch = rebirthsFolder:AddSwitch("Начать перерождется по твоему количеству", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        -- Turn off infinite rebirth if it's on
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end


        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Ооо",
                        Text = "Пошло дело пошло",
                        Duration = 5
                    })
                    
                    break
                end


infiniteSwitch = rebirthsFolder:AddSwitch("Перерождатся бесконечно", function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        -- Turn off target rebirth if it's on
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end


        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end


local sizeSwitch = rebirthsFolder:AddSwitch("Всегда рост 1", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)


local teleportSwitch = rebirthsFolder:AddSwitch("Телепортироватся в короля", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end


autoEquipToolsFolder:AddButton("Автолифт", function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end


autoEquipToolsFolder:AddSwitch("Авто гантеля", function(Value)
    _G.AutoWeight = Value
    
    if Value then
        local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if weightTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
        end


    task.spawn(function()
        while _G.AutoWeight do
            if not _G.AutoWeight then break end


autoEquipToolsFolder:AddSwitch("Авто отжимания", function(Value)
    _G.AutoPushups = Value
    
    if Value then
        local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
        if pushupsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
        end


    task.spawn(function()
        while _G.AutoPushups do
            if not _G.AutoPushups then break end


autoEquipToolsFolder:AddSwitch("Авто отжимания стоя на руках", function(Value)
    _G.AutoHandstands = Value
    
    if Value then
        local handstandsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
        if handstandsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(handstandsTool)
        end


    task.spawn(function()
        while _G.AutoHandstands do
            if not _G.AutoHandstands then break end


autoEquipToolsFolder:AddSwitch("Авто пресс", function(Value)
    _G.AutoSitups = Value
    
    if Value then
        local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
        if situpsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
        end


    task.spawn(function()
        while _G.AutoSitups do
            if not _G.AutoSitups then break end


autoEquipToolsFolder:AddSwitch("Авто удары", function(Value)
    _G.fastHitActive = Value
    
    if Value then
        -- Function to equip and modify punch
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end


        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end


autoEquipToolsFolder:AddSwitch("Быстрые предметы", function(Value)
    _G.FastTools = Value
    
    local defaultSpeeds = {
        {
            "Punch",
            "attackTime",
            Value and 0 or 0.35
        },
        {
            "Ground Slam",
            "attackTime",
            Value and 0 or 6
        },
        {
            "Stomp",
            "attackTime",
            Value and 0 or 7
        },
        {
            "Handstands",
            "repTime",
            Value and 0 or 2
        },
        {
            "Situps",
            "repTime",
            Value and 0 or 2.5
        },
        {
            "Pushups",
            "repTime",
            Value and 0 or 2.5
        },
        {
            "Weight",
            "repTime",
            Value and 0 or 3
        }
    }
    
    for _, toolData in pairs(defaultSpeeds) do
        local toolName, property, speed = toolData[1], toolData[2], toolData[3]
        
        -- Check backpack
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
        if backpackTool and backpackTool:FindFirstChild(property) then
            backpackTool[property].Value = speed
        end


autoEquipToolsFolder:AddSwitch("Анти лаг", function(Value)
    _G.AntiLag = Value
    
    if Value then
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        
        for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                obj.Material = "Plastic"
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end


local function formatNumber(number)
    if number >= 1e15 then return string.format("%.2fQ", number/1e15)
    elseif number >= 1e12 then return string.format("%.2fT", number/1e12)
    elseif number >= 1e9 then return string.format("%.2fB", number/1e9)
    elseif number >= 1e6 then return string.format("%.2fM", number/1e6)
    elseif number >= 1e3 then return string.format("%.2fK", number/1e3)
    end


local function formatNumberWithCommas(number)
    local formatted = tostring(math.floor(number))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end


local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if days > 0 then
        return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end


local function startTracking()
    if not hasStartedTracking then
        local player = game.Players.LocalPlayer
        sessionStartStrength = player.leaderstats.Strength.Value
        sessionStartDurability = player.Durability.Value
        sessionStartKills = player.leaderstats.Kills.Value
        sessionStartRebirths = player.leaderstats.Rebirths.Value
        sessionStartBrawls = player.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end


local function updateStats()
    local player = game.Players.LocalPlayer
    
    -- Iniciar seguimiento si aún no ha comenzado
    if not hasStartedTracking then
        startTracking()
    end


spawn(function()
    while wait(2) do
        updateStats()
    end


statsFolder:AddButton("Очистить статистику", function()
    local player = game.Players.LocalPlayer
    sessionStartStrength = player.leaderstats.Strength.Value
    sessionStartDurability = player.Durability.Value
    sessionStartKills = player.leaderstats.Kills.Value
    sessionStartRebirths = player.leaderstats.Rebirths.Value
    sessionStartBrawls = player.leaderstats.Brawls.Value
    sessionStartTime = os.time()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Ты очистил",
        Duration = 0
    })
end)


statsFolder:AddButton("Скопировать", function()
    local player = game.Players.LocalPlayer
    local statsText = "Muscle Legends:\n\n"
    
    statsText = statsText .. "Сила: " .. formatNumberWithCommas(player.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Долговечность: " .. formatNumberWithCommas(player.Durability.Value) .. "\n"
    statsText = statsText .. "Перерождения: " .. formatNumberWithCommas(player.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Убийства: " .. formatNumberWithCommas(player.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Поединки: " .. formatNumberWithCommas(player.leaderstats.Brawls.Value) .. "\n\n"
    
    -- Agregar estadísticas de sesión si el seguimiento ha comenzado
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        local strengthGain = player.leaderstats.Strength.Value - sessionStartStrength
        local durabilityGain = player.Durability.Value - sessionStartDurability
        local killsGain = player.leaderstats.Kills.Value - sessionStartKills
        local rebirthsGain = player.leaderstats.Rebirths.Value - sessionStartRebirths
        local brawlsGain = player.leaderstats.Brawls.Value - sessionStartBrawls
        
        statsText = statsText .. "--- Estadísticas de Sesión ---\n"
        statsText = statsText .. "Time Of Session: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Strength Gained: " .. formatNumberWithCommas(strengthGain) .. "\n"
        statsText = statsText .. "Durability Gained: " .. formatNumberWithCommas(durabilityGain) .. "\n"
        statsText = statsText .. "Rebirths Gained: " .. formatNumberWithCommas(rebirthsGain) .. "\n"
        statsText = statsText .. "Kills Gained: " .. formatNumberWithCommas(killsGain) .. "\n"
        statsText = statsText .. "Brawls Gained: " .. formatNumberWithCommas(brawlsGain) .. "\n"
    end


local petDropdown = pets:AddDropdown("Выбери пета", function(text)
    selectedPet = text
    print("Mascota seleccionada: " .. text)
end)


pets:AddSwitch("Купить", function(bool)
    _G.AutoHatchPet = bool
    
    if bool then
        spawn(function()
            while _G.AutoHatchPet and selectedPet ~= "" do
                local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
                if petToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
                end
                task.wait(1)
            end


local auraDropdown = pets:AddDropdown("Выбери ауру", function(text)
    selectedAura = text
    print("Aura seleccionada: " .. text)
end)


pets:AddSwitch("Купить", function(bool)
    _G.AutoHatchAura = bool
    
    if bool then
        spawn(function()
            while _G.AutoHatchAura and selectedAura ~= "" do
                local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
                if auraToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
                end
                task.wait(1)
            end


misc1Folder:AddSwitch("Авто прокрутка колеса удачи", function(bool)
    _G.AutoSpinWheel = bool
    
    if bool then
        spawn(function()
            while _G.AutoSpinWheel and wait(1) do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
            end
        end)


misc1Folder:AddSwitch("Авто сбор подарков", function(bool)
    _G.AutoClaimGifts = bool
    
    if bool then
        spawn(function()
            while _G.AutoClaimGifts and wait(1) do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
            end


local function checkCharacter()
    local player = game.Players.LocalPlayer
    
    if not player then
        return nil
    end


local function gettool()
    pcall(function()
        -- Check if we have a character and humanoid
        if not game.Players.LocalPlayer.Character or 
           not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            return
        end
        
        -- Try to equip the punch tool
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "Punch" then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end


local function killPlayer(target)
    -- Make sure we have our own character
    local character = checkCharacter()
    if not character then return end


    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
        task.wait(0.01) -- Small wait to ensure the touch registers
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
        gettool()
    end)


local function findClosestPlayer(input)
    if not input or input == "" then return nil end


local function updateWhitelistedPlayersLabel()
    if #_G.whitelistedPlayers == 0 then
        whitelistedPlayersLabel.Text = "Белый список: Нету"
    else
        local displayText = "Players on the White List: "
        for i, playerInfo in ipairs(_G.whitelistedPlayers) do
            if i > 1 then displayText = displayText .. ", " end


local function updateTargetPlayerLabel()
    if _G.targetPlayer == "" then
        targetPlayerLabel.Text = "Кого убивать: Нету"
    else
        targetPlayerLabel.Text = "Кого убивать: " .. _G.targetPlayer
    end


local autoWhitelistFriendsSwitch = killerTab:AddSwitch("Автоматом друзей в белый список", function(bool)
    _G.autoWhitelistFriends = bool
    
    if bool then
        pcall(function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                    local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
                    if not table.find(_G.whitelistedPlayers, playerInfo) then
                        table.insert(_G.whitelistedPlayers, playerInfo)
                    end
                end


game.Players.PlayerAdded:Connect(function(player)
    if _G.autoWhitelistFriends then
        pcall(function()
            if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
                if not table.find(_G.whitelistedPlayers, playerInfo) then
                    table.insert(_G.whitelistedPlayers, playerInfo)
                    updateWhitelistedPlayersLabel()
                end
            end


killerTab:AddTextBox("Добавить в белый список (ник)", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
            
            local alreadyWhitelisted = false
            for _, info in ipairs(_G.whitelistedPlayers) do
                if info:find(player.Name, 1, true) then
                    alreadyWhitelisted = true
                    break
                end


killerTab:AddTextBox("Удалить с белого списка (ник)", function(text)
    if text and text ~= "" then
        local textLower = text:lower()
        for i, playerInfo in ipairs(_G.whitelistedPlayers) do
            if playerInfo:lower():find(textLower, 1, true) then
                table.remove(_G.whitelistedPlayers, i)
                updateWhitelistedPlayersLabel()
                return
            end


killerTab:AddButton("Очистить белый список", function()
    _G.whitelistedPlayers = {}
    updateWhitelistedPlayersLabel()
end)


local autoKillAllSwitch = killerTab:AddSwitch("Убивать всех (кроме тех,кто в белом списке)", function(bool)
    _G.autoKillAll = bool
    
    if bool then
        spawn(function()
            while _G.autoKillAll do
                pcall(function()
                    local players = game:GetService("Players"):GetPlayers()
                    
                    for _, player in ipairs(players) do
                        if player == game.Players.LocalPlayer or not _G.autoKillAll then
                            continue
                        end
                        
                        -- Check if player is whitelisted
                        local isWhitelisted = false
                        for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                            if whitelistedInfo:find(player.Name, 1, true) then
                                isWhitelisted = true
                                break
                            end
                        end


                            pcall(function()
                                killPlayer(player)
                            end)


killerTab:AddTextBox("Убивать кого: (ник)", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end


killerTab:AddButton("Очистить убийство", function()
    _G.targetPlayer = ""
    updateTargetPlayerLabel()
end)


local autoKillTargetSwitch = killerTab:AddSwitch("Убийство выбранного", function(bool)
    _G.autoKillTarget = bool
    
    if bool and _G.targetPlayer ~= "" then
        spawn(function()
            while _G.autoKillTarget and _G.targetPlayer ~= "" do
                pcall(function()
                    local targetName = _G.targetPlayer:match("^([^%(]+)")
                    if targetName then
                        targetName = targetName:gsub("%s+$", "")
                        local targetPlayer = game.Players:FindFirstChild(targetName)
                        if targetPlayer and targetPlayer.Character and 
                           targetPlayer.Character:FindFirstChild("HumanoidRootPart") and
                           targetPlayer.Character:FindFirstChild("Humanoid") and
                           targetPlayer.Character.Humanoid.Health > 0 then
                            
                            killPlayer(targetPlayer)
                        end
                    end
                end)


killerTab:AddButton("Очистить всё (кроме белого списка)", function()
    pcall(function()
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local isWhitelisted = false
                for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                    if whitelistedInfo:find(player.Name, 1, true) then
                        isWhitelisted = true
                        break
                    end
                end


killerTab:AddButton("Удалить куклу для киллов", function()
    if _G.targetPlayer ~= "" then
        pcall(function()
            local targetName = _G.targetPlayer:match("^([^%(]+)")
            if targetName then
                targetName = targetName:gsub("%s+$", "")
                local targetPlayer = game.Players:FindFirstChild(targetName)
                if targetPlayer then
                    killPlayer(targetPlayer)
                end
            end


teleportTab:AddButton("Спавн", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Прямиком на спавн",
        Duration = 0
    })
end)


teleportTab:AddButton("Секретная арена", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "У-хх СЕКРЕТ!",
        Duration = 0
    })
end)


teleportTab:AddButton("Маленький остров 0-1к", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это для тебя малыш",
        Duration = 0
    })
end)


teleportTab:AddButton("Ледяной зал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тут холодновато",
        Duration = 0
    })
end)


teleportTab:AddButton("Мифический портал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Вот это Да,Мистика!",
        Duration = 0
    })
end)


teleportTab:AddButton("Адский портал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Жарковье,прям под сатану",
        Duration = 0
    })
end)


teleportTab:AddButton("Легендарный остров", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тихо!Он только для легенд",
        Duration = 0
    })
end)


teleportTab:AddButton("Портал мускульного короля", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Ты на стояке у Роналдо,двойная сила!",
        Duration = 0
    })
end)


teleportTab:AddButton("Джунгли", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Алё,надо побрить,тут уже обезьянки бегают",
        Duration = 0
    })
end)


teleportTab:AddButton("Бой в лаве", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это бой в лаве",
        Duration = 0
    })
end)


teleportTab:AddButton("Бой в пустыне", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это бой в песчанике",
        Duration = 0
    })
end)


teleportTab:AddButton("Бой на ринге", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тебе завидует Майк Тайсон",
        Duration = 0
    })
end)
