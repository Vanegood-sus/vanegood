local gui = Instance.new("ScreenGui")
local notification = Instance.new("Frame")
local corner = Instance.new("UICorner")
local title = Instance.new("TextLabel")
local status = Instance.new("TextLabel")
local gradient = Instance.new("UIGradient")

-- Настройка GUI
gui.Name = "AntiAfkNotification"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основной фрейм уведомления (стилизованный под основное меню)
notification.Name = "Notification"
notification.Parent = gui
notification.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
notification.BackgroundTransparency = 0.25
notification.Position = UDim2.new(1, -220, 1, -80)
notification.Size = UDim2.new(0, 180, 0, 60)
notification.BorderSizePixel = 0
notification.AnchorPoint = Vector2.new(1, 1)

-- Скругление углов (как в основном меню)
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = notification

-- Верхняя панель (как в основном меню)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = notification
TopBar.Size = UDim2.new(1, 0, 0, 20)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Заголовок (vanegood hub - как в основном меню)
title.Name = "Title"
title.Parent = TopBar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 0)
title.Size = UDim2.new(0, 100, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "vanegood hub"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- Статус
status.Name = "Status"
status.Parent = notification
status.BackgroundTransparency = 1
status.Position = UDim2.new(0, 10, 0, 25)
status.Size = UDim2.new(1, -10, 0, 30)
status.Font = Enum.Font.GothamBold
status.Text = "Anti-AFK: ON"
status.TextColor3 = Color3.fromRGB(0, 255, 255)
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left

-- Функция для быстрого показа и скрытия уведомления
local function showNotification(text, color, duration)
    status.Text = text
    status.TextColor3 = color
    
    -- Анимация появления
    notification.Position = UDim2.new(1, 200, 1, -80)
    notification.Visible = true
    notification:TweenPosition(UDim2.new(1, -220, 1, -80), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    
    -- Автоматическое скрытие через duration секунд
    wait(duration)
    
    -- Анимация исчезновения
    notification:TweenPosition(UDim2.new(1, 200, 1, -80), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true, 
        function()
            notification.Visible = false
        end)
end

-- Показываем уведомление при запуске на 2 секунды
showNotification("Anti-AFK: ON", Color3.fromRGB(0, 255, 255), 2)

-- Anti-AFK логика
local virtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    
    -- Показываем уведомление о блокировке AFK на 2 секунды
    showNotification("Anti-AFK: Blocked kick!", Color3.fromRGB(255, 80, 80), 2)
    
    -- Возвращаем исходный текст через 2 секунды
    wait(2)
    showNotification("Anti-AFK: ON", Color3.fromRGB(0, 255, 255), 2)
end)  
