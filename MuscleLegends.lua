-- Muscle Legends GUI [vanegood]
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    warn("Ошибка загрузки Rayfield!")
    return
end

-- Core Services & Variables
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local function notify(title, text, duration)
    pcall(function()
        Rayfield:Notify({
            Title = title or "Уведомление",
            Content = text or "",
            Duration = duration or 3,
            Image = 4483362458
        })
    end)
end

-- Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Muscle Legends - vanegood",
    LoadingTitle = "vanegood Hub",
    LoadingSubtitle = "Muscle Legends",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Create Tabs
local MainTab = Window:CreateTab("Меню", 4483362458)
local FarmTab = Window:CreateTab("Фарм", 4483362458)
local RocksTab = Window:CreateTab("Камни", 4483362458)
local RebirthsTab = Window:CreateTab("Перерождения", 4483362458)
local GlitchListTab = Window:CreateTab("Баг-рерождения", 4483362458)
local BrawlTab = Window:CreateTab("Драка", 4483362458)
local KillerTab = Window:CreateTab("Убийства", 4483362458)
local PetsTab = Window:CreateTab("Петы", 4483362458)
local TeleportTab = Window:CreateTab("Телепорт", 4483362458)
local MiscTab = Window:CreateTab("Другое", 4483362458)

-- =======================================================
-- ВКЛАДКА: МЕНЮ
-- =======================================================

local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then antiAFKConnection:Disconnect() end
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

MainTab:CreateToggle({
    Name = "Скрывать рамки (GUI)",
    CurrentValue = false,
    Callback = function(bool)
        for _, obj in pairs(ReplicatedStorage:GetChildren()) do
            if obj.Name:match("Frame$") then
                obj.Visible = not bool
            end
        end
    end
})

-- =======================================================
-- ВКЛАДКА: ДРАКА (BRAWL)
-- =======================================================

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

BrawlTab:CreateToggle({
    Name = "Авто выигрыш в бою",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoWinBrawl = state
        if state then
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.5) do
                    pcall(function()
                        if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                            ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                            player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                        end
                    end)
                end
            end)
            
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.5) do
                    equipPunch()
                end
            end)
            
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.1) do
                    if isLocalPlayerReady() and ReplicatedStorage:FindFirstChild("brawlInProgress") and ReplicatedStorage.brawlInProgress.Value then
                        pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                        pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
                    end
                end
            end)
            
            task.spawn(function()
                while getgenv().autoWinBrawl and task.wait(0.05) do
                    if isLocalPlayerReady() and ReplicatedStorage:FindFirstChild("brawlInProgress") and ReplicatedStorage.brawlInProgress.Value then
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

BrawlTab:CreateToggle({
    Name = "Автоматически вступать в бой",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoJoinBrawl = state
        if state then
            task.spawn(function()
                while getgenv().autoJoinBrawl and task.wait(0.5) do
                    pcall(function()
                        if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                            ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                            player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                        end
                    end)
                end
            end)
        end
    end
})

-- =======================================================
-- ВКЛАДКА: БАГ-ПЕРЕРОЖДЕНИЯ
-- =======================================================

local fullGlitchRebirthListInfo = {
    "--- УСЛОВИЕ ---",
    "Необходимые условия: Unique pet",
    "--- KING ROCK ---",
    "80 (+ 5)", "280 (+ 10)", "580 (+ 15)", "980 (+ 20)", "1480 (+ 25)",
    "2080 (+ 30)", "2780 (+ 35)", "3580 (+ 40)", "4480 (+ 45)", "5480 (+ 50)",
    "6580 (+ 55)", "7780 (+ 60)", "9080 (+ 65)", "10480 (+ 70)", "11980 (+ 75)",
    "13580 (+ 80)", "15280 (+ 85)", "17080 (+ 90)", "18980 (+ 95)",
    "--- JUNGLE ROCK ---",
    "56 (+ 5)", "60 (+ 5)", "208 (+ 10)", "440 (+ 15)", "748 (+ 20)",
    "1132 (+ 25)", "1592 (+ 30)", "2132 (+ 35)", "2748 (+ 40)", "3440 (+ 45)",
    "4208 (+ 50)", "5056 (+ 55)", "5980 (+ 60)", "6980 (+ 65)", "8056 (+ 70)",
    "9208 (+ 75)", "10440 (+ 80)", "11748 (+ 85)", "13132 (+ 90)", "14580 (+ 95)"
}

GlitchListTab:CreateDropdown({
    Name = "Справочник багов",
    Options = fullGlitchRebirthListInfo,
    CurrentOption = fullGlitchRebirthListInfo[1],
    Callback = function(val)
        notify("Баг-рерождения", "Выбрано: " .. tostring(val), 3)
    end
})

-- =======================================================
-- ВКЛАДКА: КАМНИ (БИТЬ КАМЕНЬ)
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
    RocksTab:CreateToggle({
        Name = name .. " [" .. durReq .. "]",
        CurrentValue = false,
        Callback = function(state)
            getgenv()["rockFarm_" .. durReq] = state
            if state then
                task.spawn(function()
                    while getgenv()["rockFarm_" .. durReq] do
                        task.wait(0.05)
                        if player:FindFirstChild("Durability") and player.Durability.Value >= durReq and player.Character then
                            local rHand = player.Character:FindFirstChild("RightHand")
                            local lHand = player.Character:FindFirstChild("LeftHand")
                            if rHand and lHand and workspace:FindFirstChild("machinesFolder") then
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

-- =======================================================
-- ВКЛАДКА: ПЕРЕРОЖДЕНИЯ
-- =======================================================

local targetRebirthValue = 0

RebirthsTab:CreateInput({
    Name = "Сколько нужно перерождений?",
    PlaceholderText = "Введите число...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local newValue = tonumber(text)
        if newValue and newValue > 0 then
            targetRebirthValue = newValue
            notify("Перерождения", "Цель: " .. targetRebirthValue, 3)
        end
    end
})

RebirthsTab:CreateToggle({
    Name = "Перерождаться по лимиту",
    CurrentValue = false,
    Callback = function(bool)
        _G.targetRebirthActive = bool
        if bool then
            task.spawn(function()
                while _G.targetRebirthActive and task.wait(0.1) do
                    local currentRebirths = player.leaderstats and player.leaderstats:FindFirstChild("Rebirths") and player.leaderstats.Rebirths.Value or 0
                    if targetRebirthValue > 0 and currentRebirths >= targetRebirthValue then
                        _G.targetRebirthActive = false
                        notify("Успех", "Цель достигнута!", 5)
                        break
                    end
                    pcall(function()
                        ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
            end)
        end
    end
})

RebirthsTab:CreateToggle({
    Name = "Авто-перерождения (Бесконечно)",
    CurrentValue = false,
    Callback = function(state)
        _G.infRebirth = state
        if state then
            task.spawn(function()
                while _G.infRebirth and task.wait(0.2) do
                    pcall(function()
                        ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
            end)
        end
    end
})

-- =======================================================
-- ВКЛАДКА: ФАРМ
-- =======================================================

FarmTab:CreateToggle({
    Name = "Всегда рост 1",
    CurrentValue = false,
    Callback = function(state)
        _G.lockSize1 = state
        if state then
            task.spawn(function()
                while _G.lockSize1 and task.wait(0.2) do
                    pcall(function()
                        ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                    end)
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
                        pcall(function() player.muscleEvent:FireServer("rep") end)
                        task.wait(0.1)
                    end
                end)
            else
                local equipped = player.Character and player.Character:FindFirstChild(toolName)
                if equipped then equipped.Parent = player.Backpack end
            end
        end
    })
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
                    pcall(function()
                        player.muscleEvent:FireServer("punch", "rightHand")
                        player.muscleEvent:FireServer("punch", "leftHand")
                        if player.Character and player.Character:FindFirstChild("Punch") then
                            player.Character.Punch:Activate()
                        end
                    end)
                    task.wait(0.01)
                end
            end)
        else
            local equipped = player.Character and player.Character:FindFirstChild("Punch")
            if equipped then equipped.Parent = player.Backpack end
        end
    end
})

-- =======================================================
-- ВКЛАДКА: УБИЙСТВА (КИЛЛЕР)
-- =======================================================

local whitelistedTargets = {}
local targetPlayerName = ""
local targetKillLimit = 0

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
    if #names == 0 then table.insert(names, "Никого нет") end
    return names
end

KillerTab:CreateDropdown({
    Name = "Выбрать цель",
    Options = getTargetList(),
    CurrentOption = getTargetList()[1],
    Callback = function(val)
        targetPlayerName = val
    end
})

KillerTab:CreateInput({
    Name = "Лимит убийств",
    PlaceholderText = "Число...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then
            targetKillLimit = num
            notify("Убийства", "Лимит: " .. num, 2)
        end
    end
})

KillerTab:CreateToggle({
    Name = "Авто-убийство цели",
    CurrentValue = false,
    Callback = function(state)
        _G.killTargetActive = state
        if state then
            task.spawn(function()
                local kills = 0
                while _G.killTargetActive do
                    if targetKillLimit > 0 and kills >= targetKillLimit then
                        notify("Убийства", "Лимит достигнут!", 3)
                        _G.killTargetActive = false
                        break
                    end
                    local tPlayer = Players:FindFirstChild(targetPlayerName)
                    if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Humanoid") and tPlayer.Character.Humanoid.Health > 0 then
                        killTargetChar(tPlayer)
                        kills = kills + 1
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
                local totalKills = 0
                while _G.killAllActive do
                    if targetKillLimit > 0 and totalKills >= targetKillLimit then
                        notify("Убийства", "Лимит достигнут!", 3)
                        _G.killAllActive = false
                        break
                    end
                    for _, p in ipairs(Players:GetPlayers()) do
                        if not _G.killAllActive then break end
                        if targetKillLimit > 0 and totalKills >= targetKillLimit then break end
                        if p ~= player and not whitelistedTargets[p.UserId] and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            killTargetChar(p)
                            totalKills = totalKills + 1
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
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                pcall(function()
                    if p:IsFriendsWith(player.UserId) then
                        whitelistedTargets[p.UserId] = true
                    end
                end)
            end
            notify("Вайтлист", "Друзья добавлены в белый список", 3)
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
    CurrentOption = petList[1],
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
                    pcall(function()
                        local petObj = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPetName)
                        if petObj then
                            ReplicatedStorage.cPetShopRemote:InvokeServer(petObj)
                        end
                    end)
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

TeleportTab:CreateButton({ Name = "Спавн", Callback = function() tpTo(CFrame.new(2, 8, 115), "Спавн") end })
TeleportTab:CreateButton({ Name = "Секретная арена", Callback = function() tpTo(CFrame.new(1947, 2, 6191), "Секретная арена") end })
TeleportTab:CreateButton({ Name = "Маленький остров", Callback = function() tpTo(CFrame.new(-34, 7, 1903), "Маленький остров") end })
TeleportTab:CreateButton({ Name = "Ледяной зал", Callback = function() tpTo(CFrame.new(-2600, 4, -404), "Ледяной зал") end })
TeleportTab:CreateButton({ Name = "Мифический портал", Callback = function() tpTo(CFrame.new(2255, 7, 1071), "Мифический портал") end })
TeleportTab:CreateButton({ Name = "Адский портал", Callback = function() tpTo(CFrame.new(-6768, 7, -1287), "Адский портал") end })
TeleportTab:CreateButton({ Name = "Легендарный остров", Callback = function() tpTo(CFrame.new(4604, 991, -3887), "Легендарный остров") end })
TeleportTab:CreateButton({ Name = "Мускульный Король", Callback = function() tpTo(CFrame.new(-8646, 17, -5738), "Мускульный Король") end })
TeleportTab:CreateButton({ Name = "Джунгли", Callback = function() tpTo(CFrame.new(-8659, 6, 2384), "Джунгли") end })

-- =======================================================
-- ВКЛАДКА: ДРУГОЕ
-- =======================================================

local posLockConn = nil
MiscTab:CreateToggle({
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

MiscTab:CreateButton({
    Name = "Включить Анти-лаг (Boost FPS)",
    Callback = function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not (obj.Parent and obj.Parent:FindFirstChild("Humanoid")) then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end
        notify("Анти-лаг", "Текстуры упрощены", 3)
    end
})

MiscTab:CreateToggle({
    Name = "Авто-рулетка колеса",
    CurrentValue = false,
    Callback = function(state)
        _G.spinWheel = state
        if state then
            task.spawn(function()
                while _G.spinWheel and task.wait(1) do
                    pcall(function()
                        ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
                    end)
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
                    pcall(function()
                        for i = 1, 8 do
                            ReplicatedStorage.rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                        end
                    end)
                end
            end)
        end
    end
})
