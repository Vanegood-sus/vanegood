-- Muscle Legends GUI [vanegood]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/test2.lua"))()

-- Core Services & Variables
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title or "Уведомление",
        Text = text or "",
        Duration = duration or 3
    })
end

-- Create Main Window
local Window = Library:CreateWindow({
    Name = "Muscle Legends - vanegood"
})

-- Create Tabs
local MainTab = Window:CreateTab("Меню")
local FarmTab = Window:CreateTab("Фарм")
local KillerTab = Window:CreateTab("Убийства")
local PetsTab = Window:CreateTab("Петы")
local TeleportTab = Window:CreateTab("Телепорт")
local MiscTab = Window:CreateTab("Другое")
local AuthorTab = Window:CreateTab("Создатель")

-- =======================================================
-- ВКЛАДКА: МЕНЮ
-- =======================================================

-- Anti-AFK
local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

MainTab:CreateToggle({
    Name = "Анти-АФК",
    CurrentValue = true,
    Callback = function(state)
        if state then
            setupAntiAFK()
        else
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
            end
        end
    end
})
setupAntiAFK()

-- Auto Brawl Logic
local brawlWhitelist = {}

local function equipPunch()
    local character = player.Character
    if not character then return false end
    if character:FindFirstChild("Punch") then return true end
    
    local backpack = player.Backpack
    if not backpack then return false end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool.ClassName == "Tool" and tool.Name == "Punch" then
            tool.Parent = character
            return true
        end
    end
    return false
end

local function isValidTarget(target)
    if not target or not target.Parent or target == player then return false end
    if brawlWhitelist[target.UserId] then return false end
    
    local char = target.Character
    if not char or not char.Parent then return false end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead then return false end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or not root.Parent then return false end
    
    return true
end

local function isLocalPlayerReady()
    local char = player.Character
    if not char or not char.Parent then return false end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    
    return (char:FindFirstChild("LeftHand") ~= nil or char:FindFirstChild("RightHand") ~= nil)
end

local function safeTouchInterest(targetPart, localPart)
    if not targetPart or not targetPart.Parent or not localPart or not localPart.Parent then return false end
    return pcall(function()
        firetouchinterest(targetPart, localPart, 0)
        task.wait(0.01)
        firetouchinterest(targetPart, localPart, 1)
    end)
end

MainTab:CreateToggle({
    Name = "Авто выигрыш в бою",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoWinBrawl = state
        
        if state then
            -- Join loop
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.5) do
                    if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                        ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                        player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                    end
                end
            end)
            
            -- Equip loop
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.5) do
                    equipPunch()
                end
            end)
            
            -- Punch loop
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.1) do
                    if isLocalPlayerReady() and ReplicatedStorage.brawlInProgress.Value then
                        pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                        pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
                    end
                end
            end)
            
            -- Main kill touch loop
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.05) do
                    if isLocalPlayerReady() and ReplicatedStorage.brawlInProgress.Value then
                        local char = player.Character
                        local leftHand = char:FindFirstChild("LeftHand")
                        local rightHand = char:FindFirstChild("RightHand")
                        
                        for _, p in pairs(Players:GetPlayers()) do
                            if not getgenv().autoWinBrawl then break end
                            pcall(function()
                                if isValidTarget(p) then
                                    local tRoot = p.Character.HumanoidRootPart
                                    if leftHand then safeTouchInterest(tRoot, leftHand) end
                                    if rightHand then safeTouchInterest(tRoot, rightHand) end
                                end
                            end)
                            task.wait(0.01)
                        end
                    end
                end
            end)
        end
    end
})

MainTab:CreateToggle({
    Name = "Автоматически вступать в бой",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoJoinBrawl = state
        if state then
            task.spawn(function()
                while getgenv().autoJoinBrawl and task.wait(0.5) do
                    if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                        ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                        player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                    end
                end
            end)
        end
    end
})

-- Workout Positions
local workoutPositions = {
    ["Жим лежа"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Портал Короля"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
    },
    ["Жим с присяда"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Становая тяга"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Поднимать камень"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    }
}
local gymLocations = {"Портал Ад", "Портал Легенды", "Портал Короля"}
local workoutTypes = {"Жим лежа", "Жим с присяда", "Становая тяга", "Поднимать камень"}

local function teleportAndStartWorkout(wType, position)
    if not position then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = position
    
    notify("Телепорт", "Телепортирован в зал для: " .. wType, 3)
    
    task.spawn(function()
        while getgenv().workingGym do
            pcall(function()
                if wType == "Жим лежа" then
                    ReplicatedStorage.rEvents.workoutEvent:FireServer("benchPress")
                elseif wType == "Жим с присяда" then
                    ReplicatedStorage.rEvents.workoutEvent:FireServer("squat")
                elseif wType == "Становая тяга" then
                    ReplicatedStorage.rEvents.workoutEvent:FireServer("deadlift")
                elseif wType == "Поднимать камень" then
                    ReplicatedStorage.rEvents.workoutEvent:FireServer("pullUp")
                end
            end)
            task.wait(0.1)
        end
    end)
end

for _, wType in ipairs(workoutTypes) do
    local sanitized = string.gsub(wType, " ", "")
    _G["selected" .. sanitized .. "Gym"] = gymLocations[1]
    
    MainTab:CreateDropdown({
        Name = wType .. " - Зал",
        Options = gymLocations,
        Callback = function(val)
            _G["selected" .. sanitized .. "Gym"] = val
        end
    })
    
    MainTab:CreateToggle({
        Name = "Качать: " .. wType,
        CurrentValue = false,
        Callback = function(state)
            getgenv().workingGym = state
            if state then
                local sGym = _G["selected" .. sanitized .. "Gym"] or gymLocations[1]
                if workoutPositions[wType] and workoutPositions[wType][sGym] then
                    teleportAndStartWorkout(wType, workoutPositions[wType][sGym])
                else
                    notify("Ошибка", "Координаты не найдены для " .. wType, 4)
                end
            end
        end
    })
end

-- Остальное
MainTab:CreateToggle({
    Name = "Анти-отбрасывание",
    CurrentValue = false,
    Callback = function(val)
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        if val then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "AntiKnockback"
            bv.MaxForce = Vector3.new(100000, 0, 100000)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.P = 1250
            bv.Parent = root
        else
            local existing = root:FindFirstChild("AntiKnockback")
            if existing then existing:Destroy() end
        end
    end
})

local posLockConn = nil
MainTab:CreateToggle({
    Name = "Стоять на месте (Freeze)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local lockedPos = player.Character.HumanoidRootPart.CFrame
                posLockConn = RunService.Heartbeat:Connect(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = lockedPos
                    end
                end)
            end
        else
            if posLockConn then
                posLockConn:Disconnect()
                posLockConn = nil
            end
        end
    end
})

MainTab:CreateToggle({
    Name = "Скрывать рамки (Frames)",
    CurrentValue = false,
    Callback = function(state)
        for _, obj in pairs(ReplicatedStorage:GetChildren()) do
            if obj.Name:match("Frame$") then
                obj.Visible = not state
            end
        end
    end
})

-- =======================================================
-- ВКЛАДКА: ФАРМ
-- =======================================================

local function hitTool()
    pcall(function()
        for _, v in pairs(player.Backpack:GetChildren()) do
            if v.Name == "Punch" and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:EquipTool(v)
            end
        end
        player.muscleEvent:FireServer("punch", "leftHand")
        player.muscleEvent:FireServer("punch", "rightHand")
    end)
end

local function createRockToggle(name, durReq)
    FarmTab:CreateToggle({
        Name = name .. " [" .. durReq .. "]",
        CurrentValue = false,
        Callback = function(state)
            getgenv()["rockFarm_" .. durReq] = state
            if state then
                task.spawn(function()
                    while getgenv()["rockFarm_" .. durReq] do
                        task.wait(0.05)
                        if player.Durability.Value >= durReq and player.Character then
                            local rHand = player.Character:FindFirstChild("RightHand")
                            local lHand = player.Character:FindFirstChild("LeftHand")
                            if rHand and lHand then
                                for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                                    if v.Name == "neededDurability" and v.Value == durReq and v.Parent:FindFirstChild("Rock") then
                                        firetouchinterest(v.Parent.Rock, rHand, 0)
                                        firetouchinterest(v.Parent.Rock, rHand, 1)
                                        firetouchinterest(v.Parent.Rock, lHand, 0)
                                        firetouchinterest(v.Parent.Rock, lHand, 1)
                                        hitTool()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })
end

createRockToggle("Маленький камень", 0)
createRockToggle("Средний камень", 100)
createRockToggle("Золотой камень", 5000)
createRockToggle("Ледяной камень", 150000)
createRockToggle("Мифический камень", 400000)
createRockToggle("Адский камень", 750000)
createRockToggle("Легендарный камень", 1000000)
createRockToggle("Королевский камень", 5000000)
createRockToggle("Камень в Джунглях", 10000000)

-- Rebirths
local targetRebirthVal = 0
FarmTab:CreateToggle({
    Name = "Бесконечные перерождения",
    CurrentValue = false,
    Callback = function(state)
        _G.infiniteRebirth = state
        if state then
            task.spawn(function()
                while _G.infiniteRebirth and task.wait(0.1) do
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end
            end)
        end
    end
})

FarmTab:CreateToggle({
    Name = "Всегда рост 1",
    CurrentValue = false,
    Callback = function(state)
        _G.lockSize1 = state
        if state then
            task.spawn(function()
                while _G.lockSize1 and task.wait(0.2) do
                    ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                end
            end)
        end
    end
})

FarmTab:CreateButton({
    Name = "Разблокировать AutoLift Gamepass",
    Callback = function()
        pcall(function()
            local gpFolder = ReplicatedStorage.gamepassIds
            for _, gp in pairs(gpFolder:GetChildren()) do
                local val = Instance.new("IntValue")
                val.Name = gp.Name
                val.Value = gp.Value
                val.Parent = player.ownedGamepasses
            end
            notify("Успех", "AutoLift Gamepass добавлен!", 3)
        end)
    end
})

-- Auto Workouts
local function setupAutoTool(name, toolName)
    FarmTab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Callback = function(state)
            _G["auto_" .. toolName] = state
            if state then
                local tool = player.Backpack:FindFirstChild(toolName)
                if tool and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:EquipTool(tool)
                end
                task.spawn(function()
                    while _G["auto_" .. toolName] do
                        player.muscleEvent:FireServer("rep")
                        task.wait(0.1)
                    end
                end)
            else
                local equipped = player.Character and player.Character:FindFirstChild(toolName)
                if equipped then equipped.Parent = player.Backpack end
            end
        end
    end)
end

setupAutoTool("Авто гантели", "Weight")
setupAutoTool("Авто отжимания", "Pushups")
setupAutoTool("Авто стойка на руках", "Handstands")
setupAutoTool("Авто пресс", "Situps")

FarmTab:CreateToggle({
    Name = "Быстрые удары",
    CurrentValue = false,
    Callback = function(state)
        _G.fastHits = state
        if state then
            task.spawn(function()
                while _G.fastHits do
                    local punch = player.Backpack:FindFirstChild("Punch")
                    if punch and player.Character then
                        punch.Parent = player.Character
                        if punch:FindFirstChild("attackTime") then
                            punch.attackTime.Value = 0
                        end
                    end
                    task.wait(0.2)
                end
            end)
            task.spawn(function()
                while _G.fastHits do
                    player.muscleEvent:FireServer("punch", "rightHand")
                    player.muscleEvent:FireServer("punch", "leftHand")
                    if player.Character and player.Character:FindFirstChild("Punch") then
                        player.Character.Punch:Activate()
                    end
                    task.wait(0.01)
                end
            end)
        else
            local equipped = player.Character and player.Character:FindFirstChild("Punch")
            if equipped then equipped.Parent = player.Backpack end
        end
    end
})

FarmTab:CreateToggle({
    Name = "Быстрые предметы (0 delay)",
    CurrentValue = false,
    Callback = function(state)
        local speeds = {
            {"Punch", "attackTime", state and 0 or 0.35},
            {"Ground Slam", "attackTime", state and 0 or 6},
            {"Stomp", "attackTime", state and 0 or 7},
            {"Handstands", "repTime", state and 0 or 2},
            {"Situps", "repTime", state and 0 or 2.5},
            {"Pushups", "repTime", state and 0 or 2.5},
            {"Weight", "repTime", state and 0 or 3}
        }
        for _, data in ipairs(speeds) do
            local bpTool = player.Backpack:FindFirstChild(data[1])
            if bpTool and bpTool:FindFirstChild(data[2]) then bpTool[data[2]].Value = data[3] end
            local charTool = player.Character and player.Character:FindFirstChild(data[1])
            if charTool and charTool:FindFirstChild(data[2]) then charTool[data[2]].Value = data[3] end
        end
    end
})

FarmTab:CreateToggle({
    Name = "Анти-лаг (Boost FPS)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").FogEnd = 9e9
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                    obj.Material = Enum.Material.Plastic
                    obj.Reflectance = 0
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj:Destroy()
                end
            end
        end
    end
})

-- =======================================================
-- ВКЛАДКА: УБИЙСТВА
-- =======================================================

local whitelistedTargets = {}
local targetPlayerName = ""

local function killTargetChar(target)
    local char = player.Character
    if not (char and char:FindFirstChild("LeftHand") and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then return end
    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, char.LeftHand, 0)
        task.wait(0.01)
        firetouchinterest(target.Character.HumanoidRootPart, char.LeftHand, 1)
        hitTool()
    end)
end

local function getTargetList()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then table.insert(names, "Нет игроков") end
    return names
end

KillerTab:CreateDropdown({
    Name = "Выбрать цель",
    Options = getTargetList(),
    Callback = function(val)
        targetPlayerName = val
    end
})

KillerTab:CreateToggle({
    Name = "Авто-убийство цели",
    CurrentValue = false,
    Callback = function(state)
        _G.killTargetActive = state
        if state then
            task.spawn(function()
                while _G.killTargetActive do
                    local tPlayer = Players:FindFirstChild(targetPlayerName)
                    if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Humanoid") and tPlayer.Character.Humanoid.Health > 0 then
                        killTargetChar(tPlayer)
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

KillerTab:CreateToggle({
    Name = "Убивать всех (Kill All)",
    CurrentValue = false,
    Callback = function(state)
        _G.killAllActive = state
        if state then
            task.spawn(function()
                while _G.killAllActive do
                    for _, p in ipairs(Players:GetPlayers()) do
                        if not _G.killAllActive then break end
                        if p ~= player and not whitelistedTargets[p.UserId] and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            killTargetChar(p)
                            task.wait(0.05)
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end
})

KillerTab:CreateToggle({
    Name = "Авто-вайтлист друзей",
    CurrentValue = false,
    Callback = function(state)
        _G.whitelistFriends = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p:IsFriendsWith(player.UserId) then
                    whitelistedTargets[p.UserId] = true
                end
            end
        end
    end
})

-- =======================================================
-- ВКЛАДКА: ПЕТЫ
-- =======================================================

local petList = {
    "Neon Guardian", "Blue Birdie", "Blue Bunny", "Blue Firecaster", "Blue Pheonix",
    "Crimson Falcon", "Cybernetic Showdown Dragon", "Dark Golem", "Dark Legends Manticore",
    "Dark Vampy", "Darkstar Hunter", "Eternal Strike Leviathan", "Frostwave Legends Penguin",
    "Gold Warrior", "Golden Pheonix", "Golden Viking", "Green Butterfly", "Green Firecaster",
    "Infernal Dragon", "Lightning Strike Phantom", "Magic Butterfly", "Muscle Sensei",
    "Orange Hedgehog", "Orange Pegasus", "Phantom Genesis Dragon", "Purple Dragon",
    "Purple Falcon", "Red Dragon", "Red Firecaster", "Red Kitty", "Silver Dog",
    "Ultimate Supernova Pegasus", "Ultra Birdie", "White Pegasus", "White Pheonix", "Yellow Butterfly"
}
local selectedPetName = petList[1]

PetsTab:CreateDropdown({
    Name = "Выбери пета",
    Options = petList,
    Callback = function(val)
        selectedPetName = val
    end
})

PetsTab:CreateToggle({
    Name = "Авто открытие петов",
    CurrentValue = false,
    Callback = function(state)
        _G.autoHatchPet = state
        if state then
            task.spawn(function()
                while _G.autoHatchPet do
                    local petObj = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPetName)
                    if petObj then
                        ReplicatedStorage.cPetShopRemote:InvokeServer(petObj)
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

local auraList = {
    "Astral Electro", "Azure Tundra", "Blue Aura", "Dark Electro", "Dark Lightning",
    "Dark Storm", "Electro", "Enchanted Mirage", "Entropic Blast", "Eternal Megastrike",
    "Grand Supernova", "Green Aura", "Inferno", "Lightning", "Muscle King",
    "Power Lightning", "Purple Aura", "Purple Nova", "Red Aura", "Supernova",
    "Ultra Inferno", "Ultra Mirage", "Unstable Mirage", "Yellow Aura"
}
local selectedAuraName = auraList[1]

PetsTab:CreateDropdown({
    Name = "Выбери ауру",
    Options = auraList,
    Callback = function(val)
        selectedAuraName = val
    end
})

PetsTab:CreateToggle({
    Name = "Авто открытие аур",
    CurrentValue = false,
    Callback = function(state)
        _G.autoHatchAura = state
        if state then
            task.spawn(function()
                while _G.autoHatchAura do
                    local auraObj = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAuraName)
                    if auraObj then
                        ReplicatedStorage.cPetShopRemote:InvokeServer(auraObj)
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- =======================================================
-- ВКЛАДКА: ТЕЛЕПОРТ
-- =======================================================

local function tpTo(cf, msg)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = cf
        notify("Телепорт", msg or "Успешно!", 2)
    end
end

TeleportTab:CreateButton({Name = "Спавн", Callback = function() tpTo(CFrame.new(2, 8, 115), "Прямиком на спавн") end})
TeleportTab:CreateButton({Name = "Секретная арена", Callback = function() tpTo(CFrame.new(1947, 2, 6191), "Секретная арена") end})
TeleportTab:CreateButton({Name = "Маленький остров (0-1к)", Callback = function() tpTo(CFrame.new(-34, 7, 1903), "Маленький остров") end})
TeleportTab:CreateButton({Name = "Ледяной зал", Callback = function() tpTo(CFrame.new(-2600, 4, -404), "Ледяной зал") end})
TeleportTab:CreateButton({Name = "Мифический портал", Callback = function() tpTo(CFrame.new(2255, 7, 1071), "Мифический портал") end})
TeleportTab:CreateButton({Name = "Адский портал", Callback = function() tpTo(CFrame.new(-6768, 7, -1287), "Адский портал") end})
TeleportTab:CreateButton({Name = "Легендарный остров", Callback = function() tpTo(CFrame.new(4604, 991, -3887), "Легендарный остров") end})
TeleportTab:CreateButton({Name = "Портал Мускульного Короля", Callback = function() tpTo(CFrame.new(-8646, 17, -5738), "Мускульный Король") end})
TeleportTab:CreateButton({Name = "Джунгли", Callback = function() tpTo(CFrame.new(-8659, 6, 2384), "Джунгли") end})
TeleportTab:CreateButton({Name = "Бой в лаве", Callback = function() tpTo(CFrame.new(4471, 119, -8836), "Арена Лавы") end})
TeleportTab:CreateButton({Name = "Бой в пустыне", Callback = function() tpTo(CFrame.new(960, 17, -7398), "Арена Пустыни") end})
TeleportTab:CreateButton({Name = "Бой на ринге", Callback = function() tpTo(CFrame.new(-1849, 20, -6335), "Боксерский ринг") end})

-- =======================================================
-- ВКЛАДКА: ДРУГОЕ
-- =======================================================

MiscTab:CreateToggle({
    Name = "Авто-рулетка колеса",
    CurrentValue = false,
    Callback = function(state)
        _G.spinWheel = state
        if state then
            task.spawn(function()
                while _G.spinWheel and task.wait(1) do
                    ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
                end
            end)
        end
    end
})

MiscTab:CreateToggle({
    Name = "Авто-сбор подарков",
    CurrentValue = false,
    Callback = function(state)
        _G.claimGifts = state
        if state then
            task.spawn(function()
                while _G.claimGifts and task.wait(1) do
                    for i = 1, 8 do
                        ReplicatedStorage.rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                    end
                end
            end)
        end
    end
})

-- =======================================================
-- ВКЛАДКА: СОЗДАТЕЛЬ
-- =======================================================

AuthorTab:CreateButton({
    Name = "Создано: vanegood",
    Callback = function()
        notify("Создатель", "Скрипт полностью адаптирован под UI vanegood!", 4)
    end
})
