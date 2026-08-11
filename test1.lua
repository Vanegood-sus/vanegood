-- Загрузка библиотеки UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/test2.lua"))()

-- Основные сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Создание окна
local Window = Library:CreateWindow({
    Name = "VANEGOOD HUB"
})

-- Создание вкладок
local ScriptsTab = Window:CreateTab("Скрипты")
local GamesTab = Window:CreateTab("Игры")
local TrollTab = Window:CreateTab("Троллинг")

-- =======================================================
-- ВКЛАДКА: СКРИПТЫ
-- =======================================================

-- 1. Anti-AFK
local afkEnabled = false
local virtualUser = game:GetService("VirtualUser")

LocalPlayer.Idled:Connect(function()
    if afkEnabled then
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end
end)

ScriptsTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(state)
        afkEnabled = state
    end
})

-- 2. ESP
local espEnabled = false
local espObjects = {}
local lastEspUpdate = 0
local espUpdateInterval = 0.2

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj.highlight then obj.highlight:Destroy() end
        if obj.label then obj.label:Destroy() end
    end
    espObjects = {}
end

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

RunService.Heartbeat:Connect(function()
    if not espEnabled then return end
    
    local currentTime = os.clock()
    if currentTime - lastEspUpdate < espUpdateInterval then return end
    lastEspUpdate = currentTime
    
    local parentObj = (gethui and gethui()) or game:GetService("CoreGui"):FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                local enemy = isEnemy(player)
                local ally = isAlly(player)
                
                if not espObjects[player] then
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
                    label.Parent = parentObj
                    
                    espObjects[player] = {
                        highlight = highlight,
                        label = label
                    }
                end
                
                local espData = espObjects[player]
                if enemy then
                    espData.highlight.FillColor = Color3.fromRGB(255, 70, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(180, 0, 0)
                elseif ally then
                    espData.highlight.FillColor = Color3.fromRGB(70, 255, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(0, 180, 0)
                else
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
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        if espObjects[player].label then espObjects[player].label:Destroy() end
        espObjects[player] = nil
    end
end)

ScriptsTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(state)
        espEnabled = state
        if not espEnabled then clearESP() end
    end
})

-- 3. HitBox
_G.HitBoxSize = 20
_G.HitBoxDisabled = false

local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Size = Vector3.new(2, 2, 1)
                rootPart.Transparency = 0
                rootPart.BrickColor = BrickColor.new("Medium stone grey")
                rootPart.Material = Enum.Material.Plastic
                rootPart.CanCollide = true
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if _G.HitBoxDisabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.Size = Vector3.new(_G.HitBoxSize, _G.HitBoxSize, _G.HitBoxSize)
                        rootPart.Transparency = 0.7
                        rootPart.BrickColor = BrickColor.new("Really red")
                        rootPart.Material = Enum.Material.Neon
                        rootPart.CanCollide = false
                    end
                end)
            end
        end
    end
end)

ScriptsTab:CreateToggle({
    Name = "HitBox",
    CurrentValue = false,
    Callback = function(state)
        _G.HitBoxDisabled = state
        if not _G.HitBoxDisabled then
            resetHitboxes()
        end
    end
})

ScriptsTab:CreateSlider({
    Name = "HitBox Size",
    Min = 1,
    Max = 100,
    Default = 20,
    Callback = function(val)
        _G.HitBoxSize = val
    end
})

-- 4. Fly
local flyEnabled = false
local flySpeed = 50
local flyConnections = {}

local function setupFlyCharacter(character)
    if flyEnabled and character:FindFirstChild("HumanoidRootPart") then
        if character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
            character.HumanoidRootPart.VelocityHandler:Destroy()
        end
        if character.HumanoidRootPart:FindFirstChild("GyroHandler") then
            character.HumanoidRootPart.GyroHandler:Destroy()
        end
        
        local bv = Instance.new("BodyVelocity")
        bv.Name = "VelocityHandler"
        bv.Parent = character.HumanoidRootPart
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "GyroHandler"
        bg.Parent = character.HumanoidRootPart
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 1000
        bg.D = 50
        
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = true
        end
    end
end

local function disableFly()
    flyEnabled = false
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
            LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
        end
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
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
    if #flyConnections == 0 then
        table.insert(flyConnections, LocalPlayer.CharacterAdded:Connect(function(character)
            setupFlyCharacter(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                if flyEnabled then
                    task.wait()
                    if LocalPlayer.Character then setupFlyCharacter(LocalPlayer.Character) end
                end
            end)
        end))
        
        table.insert(flyConnections, RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and 
               LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
               LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and 
               LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                
                if flyEnabled then
                    LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                    LocalPlayer.Character.Humanoid.PlatformStand = true
                    
                    LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = Camera.CoordinateFrame
                    
                    local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
                    local direction = controlModule:GetMoveVector()
                    LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
                    
                    if direction.X > 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + Camera.CFrame.RightVector * (direction.X * flySpeed)
                    end
                    if direction.X < 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + Camera.CFrame.RightVector * (direction.X * flySpeed)
                    end
                    if direction.Z > 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - Camera.CFrame.LookVector * (direction.Z * flySpeed)
                    end
                    if direction.Z < 0 then
                        LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - Camera.CFrame.LookVector * (direction.Z * flySpeed)
                    end
                end
            end
        end))
    end
    
    if LocalPlayer.Character then
        setupFlyCharacter(LocalPlayer.Character)
    end
end

ScriptsTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(state)
        if state then enableFly() else disableFly() end
    end
})

ScriptsTab:CreateSlider({
    Name = "Fly Speed",
    Min = 1,
    Max = 300,
    Default = 50,
    Callback = function(val)
        flySpeed = val
    end
})

-- 5. Speed
local speedEnabled = false
local currentSpeed = 16
local speedConnection = nil

local function setCharacterSpeed(character, speed)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
    end
end

ScriptsTab:CreateToggle({
    Name = "Speed",
    CurrentValue = false,
    Callback = function(state)
        speedEnabled = state
        if speedEnabled then
            if not speedConnection then
                speedConnection = RunService.Heartbeat:Connect(function()
                    if speedEnabled and LocalPlayer.Character then
                        setCharacterSpeed(LocalPlayer.Character, currentSpeed)
                    end
                end)
            end
            if LocalPlayer.Character then setCharacterSpeed(LocalPlayer.Character, currentSpeed) end
        else
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            if LocalPlayer.Character then setCharacterSpeed(LocalPlayer.Character, 16) end
        end
    end
})

ScriptsTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 300,
    Default = 16,
    Callback = function(val)
        currentSpeed = val
        if speedEnabled and LocalPlayer.Character then
            setCharacterSpeed(LocalPlayer.Character, currentSpeed)
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(character)
    if speedEnabled then
        task.wait(0.2)
        setCharacterSpeed(character, currentSpeed)
    end
end)

-- 6. Inf Jump
local infJumpEnabled = false
local infJumpConnection = nil

ScriptsTab:CreateToggle({
    Name = "Inf Jump",
    CurrentValue = false,
    Callback = function(state)
        infJumpEnabled = state
        if infJumpEnabled then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                if infJumpEnabled and LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:ChangeState("Jumping") end
                end
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

-- 7. Spectate & Teleport Players
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then table.insert(names, "None") end
    return names
end

local selectedTargetPlayer = nil

ScriptsTab:CreateDropdown({
    Name = "Select Player",
    Options = getPlayerNames(),
    Callback = function(val)
        selectedTargetPlayer = Players:FindFirstChild(val)
    end
})

ScriptsTab:CreateToggle({
    Name = "Spectate Player",
    CurrentValue = false,
    Callback = function(state)
        if state and selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = selectedTargetPlayer.Character.Humanoid
        else
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
            end
        end
    end
})

ScriptsTab:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = selectedTargetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

-- 8. Server Utilities
ScriptsTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local placeId = game.PlaceId
        local jobId = game.JobId
        local servers = {}
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"))
        end)
        
        if success and result and result.data then
            for _, v in pairs(result.data) do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= jobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], LocalPlayer)
        else
            warn("Server Hop: Couldn't find a server.")
        end
    end
})

ScriptsTab:CreateButton({
    Name = "Server Low",
    Callback = function()
        local placeID = game.PlaceId
        local allIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        
        local function tpReturner()
            local site
            if foundAnything == "" then
                site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeID .. "/servers/Public?sortOrder=Asc&limit=100"))
            else
                site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
            end
            
            if site.nextPageCursor and site.nextPageCursor ~= "null" and site.nextPageCursor ~= nil then
                foundAnything = site.nextPageCursor
            end
            
            local num = 0
            for _, v in pairs(site.data) do
                local possible = true
                local id = tostring(v.id)
                
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _, existing in pairs(allIDs) do
                        if num ~= 0 then
                            if id == tostring(existing) then possible = false end
                        else
                            if tonumber(actualHour) ~= tonumber(existing) then
                                allIDs = {}
                                table.insert(allIDs, actualHour)
                            end
                        end
                        num = num + 1
                    end
                    
                    if possible then
                        table.insert(allIDs, id)
                        task.wait()
                        pcall(function()
                            TeleportService:TeleportToPlaceInstance(placeID, id, LocalPlayer)
                        end)
                        task.wait(4)
                    end
                end
            end
        end
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            pcall(function()
                tpReturner()
            end)
        end)
        
        task.delay(30, function()
            if connection then connection:Disconnect() end
        end)
    end
})

ScriptsTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-- =======================================================
-- ВКЛАДКА: ИГРЫ
-- =======================================================

GamesTab:CreateButton({
    Name = "Muscle Legends",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/MuscleLegends.lua"))()
    end
})

GamesTab:CreateButton({
    Name = "Legends Of Speed",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/LegendsOfSpeed.lua"))()
    end
})

-- =======================================================
-- ВКЛАДКА: ТРОЛЛИНГ
-- =======================================================

local walkFlingEnabled = false
local walkFlingPower = 10000
local walkFlingConnections = {}
local noclipEnabled = false

local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
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

local function disableWalkFling()
    walkFlingEnabled = false
    disableNoclip()
    
    for _, connection in ipairs(walkFlingConnections) do
        connection:Disconnect()
    end
    walkFlingConnections = {}
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

local function enableWalkFling()
    walkFlingEnabled = true
    enableNoclip()
    
    table.insert(walkFlingConnections, LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            disableWalkFling()
        end)
    end))
    
    table.insert(walkFlingConnections, RunService.Heartbeat:Connect(function()
        if not walkFlingEnabled then return end
        
        local character = LocalPlayer.Character
        local root = getRoot(character)
        if not (character and root) then return end
        
        local vel = root.Velocity
        root.Velocity = vel * walkFlingPower + Vector3.new(0, walkFlingPower, 0)
        
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

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if walkFlingEnabled then
            disableWalkFling()
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        disableWalkFling()
    end
end)

TrollTab:CreateToggle({
    Name = "Walk Fling",
    CurrentValue = false,
    Callback = function(state)
        if state then
            enableWalkFling()
        else
            disableWalkFling()
        end
    end
})

TrollTab:CreateSlider({
    Name = "Fling Power",
    Min = 1000,
    Max = 50000,
    Default = 10000,
    Callback = function(val)
        walkFlingPower = val
    end
})
