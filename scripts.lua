-- Anti-AFK
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local AntiAfkContainer = Instance.new("Frame")
AntiAfkContainer.Name = "AntiAfk"
AntiAfkContainer.Size = UDim2.new(1, -20, 0, 40)
AntiAfkContainer.Position = UDim2.new(0, 10, 0, 10)
AntiAfkContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AntiAfkContainer.BackgroundTransparency = 0.5
AntiAfkContainer.Parent = ScriptsFrame

local AntiAfkCorner = Instance.new("UICorner")
AntiAfkCorner.CornerRadius = UDim.new(0, 6)
AntiAfkCorner.Parent = AntiAfkContainer

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

updateAfkToggle()

-- ESP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ScreenGui = CoreGui:FindFirstChild("VanegoodHub") or CoreGui:FindFirstChild("VanegoodHub_Scripts")
if not ScreenGui then
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VanegoodHub_Scripts"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
end

local ScriptsFrame = ScriptsFrame or ScreenGui:FindFirstChild("ScriptsFrame")

local espEnabled = false
local espObjects = {}
local lastUpdate = 0
local updateInterval = 0.2

local EspContainer = Instance.new("Frame")
EspContainer.Name = "ESPSettings"
EspContainer.Size = UDim2.new(1, -20, 0, 40)
EspContainer.Position = UDim2.new(0, 10, 0, 60)
EspContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
EspContainer.BackgroundTransparency = 0.5
EspContainer.Parent = ScriptsFrame or ScreenGui

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 6)
EspCorner.Parent = EspContainer

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

local function updateEspToggle()
    local goal = {
        Position = espEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = espEnabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    }
    EspToggleFrame.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    local tween = TweenService:Create(EspToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function clearESP()
    for id, obj in pairs(espObjects) do
        if obj.highlight and obj.highlight.Parent then obj.highlight:Destroy() end
        if obj.label and obj.label.Parent then obj.label:Destroy() end
        espObjects[id] = nil
    end
end

local function isEnemy(player)
    if player:FindFirstChild("Team") and type(player.Team.Name) == "string" and string.find(player.Team.Name:lower(), "killer") then
        return true
    end
    if player.Team and LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    end
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool or (humanoid and humanoid:GetAttribute and humanoid:GetAttribute("CanAttack") == true) then
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

local function ensureESPForPlayer(player)
    local id = player.UserId
    if espObjects[id] then return espObjects[id] end

    local container = {}
    local ok, highlight = pcall(function()
        local h = Instance.new("Highlight")
        h.Name = "ESPHighlight"
        h.Adornee = player.Character
        h.FillTransparency = 0.85
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = player.Character
        return h
    end)
    container.highlight = ok and highlight or nil

    local label = Instance.new("TextLabel")
    label.Name = "ESPLabel"
    label.Size = UDim2.new(0, 200, 0, 20)
    label.AnchorPoint = Vector2.new(0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextStrokeTransparency = 0.7
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Parent = ScreenGui
    container.label = label

    espObjects[id] = container
    return container
end

local function removeESPForPlayer(player)
    local id = player.UserId
    if espObjects[id] then
        if espObjects[id].highlight and espObjects[id].highlight.Parent then espObjects[id].highlight:Destroy() end
        if espObjects[id].label and espObjects[id].label.Parent then espObjects[id].label:Destroy() end
        espObjects[id] = nil
    end
end

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
                local obj = ensureESPForPlayer(player)

                if obj.highlight then
                    if enemy then
                        obj.highlight.FillColor = Color3.fromRGB(255, 70, 70)
                        obj.highlight.OutlineColor = Color3.fromRGB(180, 0, 0)
                    elseif ally then
                        obj.highlight.FillColor = Color3.fromRGB(70, 255, 70)
                        obj.highlight.OutlineColor = Color3.fromRGB(0, 180, 0)
                    else
                        obj.highlight.FillColor = Color3.fromRGB(70, 70, 255)
                        obj.highlight.OutlineColor = Color3.fromRGB(0, 0, 180)
                    end
                end

                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = 0
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        distance = math.floor((rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                    end
                    obj.label.Text = string.format("%s [%d]", player.Name, distance)
                    obj.label.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 35)
                    obj.label.Visible = true
                else
                    obj.label.Visible = false
                end
            else
                removeESPForPlayer(player)
            end
        else
            removeESPForPlayer(player)
        end
    end
end

EspToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateEspToggle()
    if not espEnabled then clearESP() end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESPForPlayer(player)
end)

RunService.Heartbeat:Connect(updateESP)
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
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

local FlyControlContainer = Instance.new("Frame")
FlyControlContainer.Size = UDim2.new(0, 150, 0, 25)
FlyControlContainer.Position = UDim2.new(1, -110, 0.5, -12)
FlyControlContainer.BackgroundTransparency = 1
FlyControlContainer.Parent = FlyContainer

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
            if character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
                character.HumanoidRootPart.VelocityHandler:Destroy()
            end
            if character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                character.HumanoidRootPart.GyroHandler:Destroy()
            end
            
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
    
    for _, connection in pairs(flyConnections) do
        connection:Disconnect()
    end
    flyConnections = {}
end

local function enableFly()
    flyEnabled = true
    updateFlyToggle()
    
    if #flyConnections == 0 then
        table.insert(flyConnections, LocalPlayer.CharacterAdded:Connect(function(character)
            setupCharacter(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                if flyEnabled then
                    task.wait()
                    if LocalPlayer.Character then
                        setupCharacter(LocalPlayer.Character)
                    end
                end
            end)
        end))
        
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
                    
                    if direction.X ~= 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * flySpeed)
                    end
                    if direction.Z ~= 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * flySpeed)
                    end
                end
            end
        end))
        
        table.insert(flyConnections, FlySpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
            if tonumber(FlySpeedInput.Text) then
                flySpeed = tonumber(FlySpeedInput.Text)
            end
        end))
    end
    
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

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableFly()
    end
end)

updateFlyToggle()

