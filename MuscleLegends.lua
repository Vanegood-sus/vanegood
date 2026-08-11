-- Muscle Legends GUI [vanegood]
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/test2.lua"))()
end)

if not success or not Library then
    warn("Ошибка загрузки UI библиотеки!")
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
        StarterGui:SetCore("SendNotification", {
            Title = title or "Уведомление",
            Text = text or "",
            Duration = duration or 3
        })
    end)
end

-- Create Main Window
local Window = nil
if type(Library.CreateWindow) == "function" then
    pcall(function() Window = Library:CreateWindow({ Name = "Muscle Legends - vanegood" }) end)
    if not Window then
        pcall(function() Window = Library:CreateWindow("Muscle Legends - vanegood") end)
    end
end
if not Window then Window = Library end

-- Universal element helper
local function addTab(win, name)
    if win.CreateTab then return win:CreateTab(name) end
    if win.AddTab then return win:AddTab(name) end
    if win.Tab then return win:Tab(name) end
    return win
end

local function addToggle(tab, name, default, callback)
    if tab.CreateToggle then
        local ok = pcall(function()
            tab:CreateToggle({
                Name = name,
                CurrentValue = default,
                Callback = callback
            })
        end)
        if not ok then
            pcall(function() tab:CreateToggle(name, default, callback) end)
        end
    elseif tab.AddToggle then
        pcall(function() tab:AddToggle(name, { Default = default, Callback = callback }) end)
    end
end

local function addButton(tab, name, callback)
    if tab.CreateButton then
        local ok = pcall(function()
            tab:CreateButton({
                Name = name,
                Callback = callback
            })
        end)
        if not ok then
            pcall(function() tab:CreateButton(name, callback) end)
        end
    elseif tab.AddButton then
        pcall(function() tab:AddButton(name, callback) end)
    end
end

local function addDropdown(tab, name, options, callback)
    if tab.CreateDropdown then
        local ok = pcall(function()
            tab:CreateDropdown({
                Name = name,
                Options = options,
                Callback = callback
            })
        end)
        if not ok then
            pcall(function() tab:CreateDropdown(name, options, callback) end)
        end
    elseif tab.AddDropdown then
        pcall(function() tab:AddDropdown(name, { Values = options, Callback = callback }) end)
    end
end

local function addInput(tab, name, placeholder, callback)
    if tab.CreateInput then
        local ok = pcall(function()
            tab:CreateInput({
                Name = name,
                PlaceholderText = placeholder,
                Callback = callback
            })
        end)
        if not ok then
            pcall(function() tab:CreateInput(name, placeholder, callback) end)
        end
    elseif tab.CreateTextBox then
        pcall(function() tab:CreateTextBox(name, placeholder, callback) end)
    elseif tab.AddInput then
        pcall(function() tab:AddInput(name, { Placeholder = placeholder, Callback = callback }) end)
    elseif tab.AddTextBox then
        pcall(function() tab:AddTextBox(name, { Placeholder = placeholder, Callback = callback }) end)
    end
end

-- Create Tabs
local MainTab = addTab(Window, "Меню")
local FarmTab = addTab(Window, "Фарм")
local KillerTab = addTab(Window, "Убийства")
local PetsTab = addTab(Window, "Петы")
local TeleportTab = addTab(Window, "Телепорт")
local MiscTab = addTab(Window, "Другое")

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

addToggle(MainTab, "Анти-АФК", true, function(state)
    if state then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
    end
end)
setupAntiAFK()

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

addToggle(MainTab, "Авто выигрыш в бою", false, function(state)
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
end)

addToggle(MainTab, "Автоматически вступать в бой", false, function(state)
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
end)

-- Улучшенный Анти-отброс через физику и Heartbeat
local antiKnockConn = nil
addToggle(MainTab, "Анти-отбрасывание", false, function(val)
    if antiKnockConn then
        antiKnockConn:Disconnect()
        antiKnockConn = nil
    end
    
    if val then
        antiKnockConn = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
                    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end
end)

local posLockConn = nil
addToggle(MainTab, "Стоять на месте (Freeze)", false, function(state)
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
end)

-- Скрытие рамок UI
addToggle(MainTab, "Скрывать рамки (GUI)", false, function(state)
    local pGui = player:FindFirstChild("PlayerGui")
    if pGui then
        for _, gui in pairs(pGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "LibraryGui" and not gui.Name:match("vanegood") then
                for _, obj in pairs(gui:GetDescendants()) do
                    if obj:IsA("Frame") and obj.Name:lower():match("frame") then
                        obj.Visible = not state
                    end
                end
            end
        end
    end
end)

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
    addToggle(FarmTab, name .. " [" .. durReq .. "]", false, function(state)
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
    end)
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

local targetRebirthCount = 0
addInput(FarmTab, "Лимит перерождений (число)", "Введи число...", function(text)
    local num = tonumber(text)
    if num then
        targetRebirthCount = num
        notify("Перерождения", "Цель установлена: " .. num, 2)
    end
end)

addToggle(FarmTab, "Авто-перерождения (до лимита)", false, function(state)
    _G.targetRebirth = state
    if state then
        task.spawn(function()
            local done = 0
            while _G.targetRebirth do
                local curRebirths = player.leaderstats and player.leaderstats:FindFirstChild("Rebirths") and player.leaderstats.Rebirths.Value or 0
                if targetRebirthCount > 0 and (done >= targetRebirthCount or curRebirths >= targetRebirthCount) then
                    notify("Перерождения", "Целевое количество достигнуто!", 4)
                    _G.targetRebirth = false
                    break
                end
                pcall(function()
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    done = done + 1
                end)
                task.wait(0.2)
            end
        end)
    end
end)

addToggle(FarmTab, "Всегда рост 1", false, function(state)
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
end)

addButton(FarmTab, "Разблокировать AutoLift Gamepass", function()
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
end)

local function setupAutoTool(name, toolName)
    addToggle(FarmTab, name, false, function(state)
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
    end)
end

setupAutoTool("Авто гантели", "Weight")
setupAutoTool("Авто отжимания", "Pushups")
setupAutoTool("Авто стойка на руках", "Handstands")
setupAutoTool("Авто пресс", "Situps")

addToggle(FarmTab, "Быстрые удары", false, function(state)
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
end)

addToggle(FarmTab, "Быстрые предметы (0 delay)", false, function(state)
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
end)

-- Антилаг переведен на разовую кнопку
addButton(FarmTab, "Включить Анти-лаг (Boost FPS)", function()
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
end)

-- =======================================================
-- ВКЛАДКА: УБИЙСТВА
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
    if #names == 0 then table.insert(names, "Нет игроков") end
    return names
end

addDropdown(KillerTab, "Выбрать цель", getTargetList(), function(val)
    targetPlayerName = val
end)

addInput(KillerTab, "Лимит убийств (число)", "Введи число...", function(text)
    local num = tonumber(text)
    if num then
        targetKillLimit = num
        notify("Убийства", "Лимит установлен: " .. num, 2)
    end
end)

addToggle(KillerTab, "Авто-убийство цели", false, function(state)
    _G.killTargetActive = state
    if state then
        task.spawn(function()
            local kills = 0
            while _G.killTargetActive do
                if targetKillLimit > 0 and kills >= targetKillLimit then
                    notify("Убийства", "Лимит убийств достигнут!", 3)
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
end)

addToggle(KillerTab, "Убивать всех (Kill All)", false, function(state)
    _G.killAllActive = state
    if state then
        task.spawn(function()
            local totalKills = 0
            while _G.killAllActive do
                if targetKillLimit > 0 and totalKills >= targetKillLimit then
                    notify("Убийства", "Лимит убийств достигнут!", 3)
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
end)

addToggle(KillerTab, "Авто-вайтлист друзей", false, function(state)
    _G.whitelistFriends = state
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            pcall(function()
                if p:IsFriendsWith(player.UserId) then
                    whitelistedTargets[p.UserId] = true
                end
            end)
        end
    end
end)

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

addDropdown(PetsTab, "Выбери пета", petList, function(val)
    selectedPetName = val
end)

addToggle(PetsTab, "Авто открытие петов", false, function(state)
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
end)

local auraList = {
    "Astral Electro", "Azure Tundra", "Blue Aura", "Dark Electro", "Dark Lightning",
    "Dark Storm", "Electro", "Enchanted Mirage", "Entropic Blast", "Eternal Megastrike",
    "Grand Supernova", "Green Aura", "Inferno", "Lightning", "Muscle King",
    "Power Lightning", "Purple Aura", "Purple Nova", "Red Aura", "Supernova",
    "Ultra Inferno", "Ultra Mirage", "Unstable Mirage", "Yellow Aura"
}
local selectedAuraName = auraList[1]

addDropdown(PetsTab, "Выбери ауру", auraList, function(val)
    selectedAuraName = val
end)

addToggle(PetsTab, "Авто открытие аур", false, function(state)
    _G.autoHatchAura = state
    if state then
        task.spawn(function()
            while _G.autoHatchAura do
                pcall(function()
                    local auraObj = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAuraName)
                    if auraObj then
                        ReplicatedStorage.cPetShopRemote:InvokeServer(auraObj)
                    end
                end)
                task.wait(1)
            end
        end)
    end
end)

-- =======================================================
-- ВКЛАДКА: ТЕЛЕПОРТ
-- =======================================================

local function tpTo(cf, msg)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = cf
        notify("Телепорт", msg or "Успешно!", 2)
    end
end

addButton(TeleportTab, "Спавн", function() tpTo(CFrame.new(2, 8, 115), "Прямиком на спавн") end)
addButton(TeleportTab, "Секретная арена", function() tpTo(CFrame.new(1947, 2, 6191), "Секретная арена") end)
addButton(TeleportTab, "Маленький остров (0-1к)", function() tpTo(CFrame.new(-34, 7, 1903), "Маленький остров") end)
addButton(TeleportTab, "Ледяной зал", function() tpTo(CFrame.new(-2600, 4, -404), "Ледяной зал") end)
addButton(TeleportTab, "Мифический портал", function() tpTo(CFrame.new(2255, 7, 1071), "Мифический портал") end)
addButton(TeleportTab, "Адский портал", function() tpTo(CFrame.new(-6768, 7, -1287), "Адский портал") end)
addButton(TeleportTab, "Легендарный остров", function() tpTo(CFrame.new(4604, 991, -3887), "Легендарный остров") end)
addButton(TeleportTab, "Портал Мускульного Короля", function() tpTo(CFrame.new(-8646, 17, -5738), "Мускульный Король") end)
addButton(TeleportTab, "Джунгли", function() tpTo(CFrame.new(-8659, 6, 2384), "Джунгли") end)
addButton(TeleportTab, "Бой в лаве", function() tpTo(CFrame.new(4471, 119, -8836), "Арена Лавы") end)
addButton(TeleportTab, "Бой в пустыне", function() tpTo(CFrame.new(960, 17, -7398), "Арена Пустыни") end)
addButton(TeleportTab, "Бой на ринге", function() tpTo(CFrame.new(-1849, 20, -6335), "Боксерский ринг") end)

-- =======================================================
-- ВКЛАДКА: ДРУГОЕ
-- =======================================================

addToggle(MiscTab, "Авто-рулетка колеса", false, function(state)
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
end)

addToggle(MiscTab, "Авто-сбор подарков", false, function(state)
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
end)
