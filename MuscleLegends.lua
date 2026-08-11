-- Muscle Legends GUI [vanegood]
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/test2.lua"))()
end)

if not success or not Library then
    warn("Ошибка загрузки UI библиотеки! Подробности: " .. tostring(Library))
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
local RocksTab = addTab(Window, "Камни")
local RebirthsTab = addTab(Window, "Перерождения")
local GlitchListTab = addTab(Window, "Баг-рерождения")
local BrawlTab = addTab(Window, "Драка")
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

addToggle(MainTab, "Скрывать рамки (GUI)", false, function(bool)
    for _, obj in pairs(ReplicatedStorage:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

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

addToggle(BrawlTab, "Авто выигрыш в бою", false, function(state)
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

addToggle(BrawlTab, "Автоматически вступать в бой", false, function(state)
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

-- =======================================================
-- ВКЛАДКА: БАГ-ПЕРЕРОЖДЕНИЯ
-- =======================================================

local fullGlitchRebirthListInfo = {
    "--- УСЛОВИЕ ---",
    "Необходимые условия (легендарный пет): Unique pet",
    "--- КОРОЛЕВСКИЙ КАМЕНЬ (KING ROCK) ---",
    "80 (+ 5)", "280 (+ 10)", "580 (+ 15)", "980 (+ 20)", "1480 (+ 25)",
    "2080 (+ 30)", "2780 (+ 35)", "3580 (+ 40)", "4480 (+ 45)", "5480 (+ 50)",
    "6580 (+ 55)", "7780 (+ 60)", "9080 (+ 65)", "10480 (+ 70)", "11980 (+ 75)",
    "13580 (+ 80)", "15280 (+ 85)", "17080 (+ 90)", "18980 (+ 95)",
    "--- КАМЕНЬ ДЖУНГЛЕЙ (JUNGLE ROCK) ---",
    "56 (+ 5) [add 15 exp]", "60 (+ 5) [add 1200 exp lvl 2]", "208 (+ 10) [add 45 exp]",
    "440 (+ 15) [add 25 exp]", "748 (+ 20) [add 20 exp]", "1132 (+ 25) [add 30 exp]",
    "1592 (+ 30) [add 55 exp]", "2132 (+ 35) [add 30 exp]", "2748 (+ 40) [add 20 exp]",
    "3440 (+ 45) [add 25 exp]", "4208 (+ 50) [add 45 exp]", "5056 (+ 55) [add 15 exp]",
    "5980 (+ 60)", "6980 (+ 65)", "8056 (+ 70) [add 15 exp]", "9208 (+ 75) [add 45 exp]",
    "10440 (+ 80) [add 25 exp]", "11748 (+ 85) [add 20 exp]", "13132 (+ 90) [add 30 exp]",
    "14580 (+ 95) [add 250 exp]", "14592 (+ 95) [add 55 exp]",
    "--- ЛЕГЕНДАРНЫЙ КАМЕНЬ (LEGENDS ROCK) ---",
    "480 (+ 5)", "1480 (+ 10)", "2980 (+ 15)", "4980 (+ 20)", "7480 (+ 25)",
    "10480 (+ 30)", "13980 (+ 35)", "17980 (+ 40)", "22480 (+ 45)", "27480 (+ 50)",
    "32980 (+ 55)", "38980 (+ 60)", "45480 (+ 65)", "52480 (+ 70)", "59980 (+ 75)",
    "67980 (+ 80)", "76480 (+ 85)", "85480 (+ 90)", "94980 (+ 95)",
    "--- АДСКИЙ КАМЕНЬ (INFERNO ROCK) ---",
    "1084 (+ 5) [add 8 exp]", "3308 (+ 10) [add 6 exp]", "6644 (+ 15) [add 3 exp]",
    "11084 (+ 20) [add 8 exp]", "16644 (+ 25) [add 3 exp]", "23308 (+ 30) [add 6 exp]",
    "31084 (+ 35) [add 8 exp]", "39980 (+ 40)", "49980 (+ 45)", "61084 (+ 50) [add 8 exp]",
    "73308 (+ 55) [add 6 exp]", "86644 (+ 60) [add 3 exp]", "101084 (+ 65) [add 8 exp]",
    "116644 (+ 70) [add 3 exp]", "133308 (+ 75) [add 6 exp]", "151084 (+ 80) [add 8 exp]",
    "169980 (+ 85)", "189980 (+ 90)", "210980 (+ 95) [add 125 exp]", "211084 (+ 95) [add 8 exp]",
    "--- МИСТИЧЕСКИЙ КАМЕНЬ (MYTHICAL ROCK) ---",
    "1644 (+ 5) [add 2 exp]", "4980 (+ 10)", "9980 (+ 15)", "16644 (+ 20) [add 2 exp]",
    "24980 (+ 25)", "34980 (+ 30)", "46644 (+ 35) [add 2 exp]", "59980 (+ 40)",
    "74980 (+ 45)", "91644 (+ 50) [add 2 exp]", "109980 (+ 55)", "129980 (+ 60)",
    "151644 (+ 65) [add 2 exp]", "174980 (+ 70)", "199980 (+ 75)", "226644 (+ 80) [add 2 exp]",
    "254980 (+ 85)", "284980 (+ 90)", "316480 (+ 95) [add 125 exp]", "316644 (+ 95) [add 2 exp]",
    "--- ЛЕДЯНОЙ КАМЕНЬ (FROZEN ROCK) ---",
    "3308 (+ 5) [add 2 exp]", "9980 (+ 10)", "19980 (+ 15)", "33308 (+ 20) [add 2 exp]",
    "49980 (+ 25)", "69980 (+ 30)", "93308 (+ 35) [add 2 exp]", "119980 (+ 40)",
    "149980 (+ 45)", "183308 (+ 50) [add 2 exp]", "219980 (+ 55)", "259980 (+ 60)",
    "303308 (+ 65) [add 2 exp]", "349980 (+ 70)", "399980 (+ 75)", "453308 (+ 80) [add 2 exp]",
    "509980 (+ 85)", "569980 (+ 90)", "632980 (+ 95) [add 125 exp]", "633308 (+ 95) [add 2 exp]",
    "--- ЗОЛОТОЙ КАМЕНЬ (GOLDEN ROCK) ---",
    "6230 (+ 5)", "18730 (+ 10)", "37480 (+ 15)", "62480 (+ 20)", "93730 (+ 25)",
    "131230 (+ 30)", "174980 (+ 35)", "224980 (+ 40)", "281230 (+ 45)", "343730 (+ 50)",
    "412480 (+ 55)", "487480 (+ 60)", "568730 (+ 65)", "656230 (+ 70)", "749980 (+ 75)",
    "849980 (+ 80)", "956230 (+ 85)", "1068730 (+ 90) (миллионные баги)", "1187480 (+ 95)",
    "--- БОЛЬШОЙ КАМЕНЬ (LARGE ROCK) ---",
    "16620 (+ 5) [add 2 exp]", "49980 (+ 10)", "99980 (+ 15)", "166620 (+ 20) [add 2 exp]",
    "249980 (+ 25)", "349980 (+ 30)", "466620 (+ 35) [add 2 exp]", "599980 (+ 40)",
    "749980 (+ 45)", "916620 (+ 50) [add 2 exp]", "1099980 (+ 55)", "1299980 (+ 60)",
    "1516620 (+ 65) [add 2 exp]", "1749980 (+ 70)", "1999980 (+ 75)", "2266620 (+ 80) [add 2 exp]",
    "2549980 (+ 85)", "2849980 (+ 90)", "3164980 (+ 95) [add 125 exp]", "3166620 (+ 95) [add 2 exp]",
    "--- PUNCHING ROCK ---",
    "24980 (+ 5)", "74980 (+ 10)", "149980 (+ 15)", "249980 (+ 20)", "374980 (+ 25)",
    "524980 (+ 30)", "699980 (+ 35)", "899980 (+ 40)", "1124980 (+ 45)", "1374980 (+ 50)",
    "1649980 (+ 55)", "1949980 (+ 60)", "2274980 (+ 65)", "2624980 (+ 70)", "2999980 (+ 75)",
    "3399980 (+ 80)", "3824980 (+ 85)", "4274980 (+ 90)", "4749980 (+ 95)",
    "--- МАЛЕНЬКИЙ / КРОШЕЧНЫЙ КАМЕНЬ (TINY ROCK) ---",
    "49980 (+ 5)", "149980 (+ 10)", "299980 (+ 15)", "499980 (+ 20)", "749980 (+ 25)",
    "1049980 (+ 30)", "1399980 (+ 35)", "1799980 (+ 40)", "2249980 (+ 45)", "2749980 (+ 50)",
    "3299980 (+ 55)", "3899980 (+ 60)", "4549980 (+ 65)", "5249980 (+ 70)", "5999980 (+ 75)",
    "6799980 (+ 80)", "7649980 (+ 85)", "8549980 (+ 90)", "9499980 (+ 95) (Макс для Unique pets)"
}

addDropdown(GlitchListTab, "Полный справочник чисел и багов", fullGlitchRebirthListInfo, function(val)
    notify("Баг-рерождения", "Выбрано: " .. val, 4)
end)

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
    addToggle(RocksTab, name .. " [" .. durReq .. "]", false, function(state)
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

-- =======================================================
-- ВКЛАДКА: ПЕРЕРОЖДЕНИЯ
-- =======================================================

local targetRebirthValue = 0

addInput(RebirthsTab, "Сколько нужно перерождений?", "Введите число...", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        notify("Перерождения", "Остановлю, когда будет " .. targetRebirthValue .. " перерождений", 3)
    else
        notify("Перерождения", "Введено неверное число", 3)
    end
end)

addToggle(RebirthsTab, "Начать перерождаться по твоему количеству", false, function(bool)
    _G.targetRebirthActive = bool
    if bool then
        task.spawn(function()
            while _G.targetRebirthActive and task.wait(0.1) do
                local currentRebirths = player.leaderstats and player.leaderstats:FindFirstChild("Rebirths") and player.leaderstats.Rebirths.Value or 0
                if currentRebirths >= targetRebirthValue then
                    _G.targetRebirthActive = false
                    notify("Оуу", "Пошло дело, пошло! Цель достигнута.", 5)
                    break
                end
                pcall(function()
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end)
            end
        end)
    end
end)

addToggle(RebirthsTab, "Авто-перерождения (до лимита/бесконечно)", false, function(state)
    _G.targetRebirth = state
    if state then
        task.spawn(function()
            while _G.targetRebirth do
                local curRebirths = player.leaderstats and player.leaderstats:FindFirstChild("Rebirths") and player.leaderstats.Rebirths.Value or 0
                if targetRebirthValue > 0 and curRebirths >= targetRebirthValue then
                    notify("Перерождения", "Целевое количество достигнуто!", 4)
                    _G.targetRebirth = false
                    break
                end
                pcall(function()
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end)
                task.wait(0.2)
            end
        end)
    end
end)

-- =======================================================
-- ВКЛАДКА: ФАРМ
-- =======================================================

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

addToggle(KillerTab, "Авто-убийство цели (по лимиту)", false, function(state)
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

addToggle(KillerTab, "Убивать всех (Kill All по лимиту)", false, function(state)
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

addButton(TeleportTab, "--- ОБЫЧНЫЕ ЛОКАЦИИ ---", function() end)
addButton(TeleportTab, "Спавн", function() tpTo(CFrame.new(2, 8, 115), "Прямиком на спавн") end)
addButton(TeleportTab, "Секретная арена", function() tpTo(CFrame.new(1947, 2, 6191), "Секретная арена") end)
addButton(TeleportTab, "Маленький остров (0-1к)", function() tpTo(CFrame.new(-34, 7, 1903), "Маленький остров") end)
addButton(TeleportTab, "Ледяной зал", function() tpTo(CFrame.new(-2600, 4, -404), "Ледяной зал") end)
addButton(TeleportTab, "Мифический портал", function() tpTo(CFrame.new(2255, 7, 1071), "Мифический портал") end)
addButton(TeleportTab, "Адский портал", function() tpTo(CFrame.new(-6768, 7, -1287), "Адский портал") end)
addButton(TeleportTab, "Легендарный остров", function() tpTo(CFrame.new(4604, 991, -3887), "Легендарный остров") end)
addButton(TeleportTab, "Портал Мускульного Короля", function() tpTo(CFrame.new(-8646, 17, -5738), "Мускульный Король") end)
addButton(TeleportTab, "Джунгли", function() tpTo(CFrame.new(-8659, 6, 2384), "Джунгли") end)

addButton(TeleportTab, "--- БОЕВЫЕ АРЕНЫ И БОИ ---", function() end)
addButton(TeleportTab, "Бой в лаве", function() tpTo(CFrame.new(4471, 119, -8836), "Арена Лавы") end)
addButton(TeleportTab, "Бой в пустыне", function() tpTo(CFrame.new(960, 17, -7398), "Арена Пустыни") end)
addButton(TeleportTab, "Бой на ринге", function() tpTo(CFrame.new(-1849, 20, -6335), "Боксерский ринг") end)

-- =======================================================
-- ВКЛАДКА: ДРУГОЕ
-- =======================================================

local posLockConn = nil
addToggle(MiscTab, "Стоять на месте (Freeze)", false, function(state)
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

addButton(MiscTab, "Включить Анти-лаг (Boost FPS)", function()
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
