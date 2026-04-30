local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Subtitles = require(ReplicatedStorage.UI.Modules.Subtitles)

local player = Players.LocalPlayer

local AUDIO_IDS = {
    red_eyes_01 = 118285668249883,
    system_01 = 101196436867574,
    red_eyes_02 = 79795517272309,
    red_eyes_03 = 77138874517096,
    red_eyes_04 = 113442545987763,
    red_eyes_death_01 = 100522332445068,
    red_eyes_revive_01 = 100522332445068,
}

local function playSound(audioId)
    if not audioId then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(audioId)
    sound.Volume = 0.7
    sound.Parent = workspace
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function sayWithVoice(speaker, text, duration, audioKey)
    Subtitles.say(speaker, text, duration)
    
    if audioKey and AUDIO_IDS[audioKey] then
        task.spawn(function()
            playSound(AUDIO_IDS[audioKey])
        end)
    end
    
    task.wait(duration)
end
if not player.Character then
    player.CharacterAdded:Wait()
end


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

local speeds = 1
local nowe = false
local tis
local dis
local tpwalking = false
local SPEED_LIMIT = 10
local isAntiSelfDamage = false
local isAntiKnockback = false
local isAntiRagdoll = false
local namecallHook1 = nil
local namecallHook2 = nil
local renderConnection = nil

local repo = 'https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local LP = game.Players.LocalPlayer
local MS = game:GetService("MarketplaceService")
local Window = Library:CreateWindow({
	Title = "XIAOXI HUB丨GB",
    Footer = "作者：by小西 l 服务器：内脏与黑火药",
	Icon = 100601171677910,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
    Home = Window:AddTab("开始", "house"),
    w = Window:AddTab("主要功能", "shield-check"),
    e = Window:AddTab("透视", "eye"),
    r = Window:AddTab("杀戮光环", "sword"),
    y = Window:AddTab("玩家", "users"),
    u = Window:AddTab("职业", "heart"),
    p = Window:AddTab("其他", "settings"),
    ["界面设置"] = Window:AddTab("界面设置", "settings"),
}

-- ↓↓↓ 开始选项卡 ↓↓↓
local HomeGroup = Tabs.Home:AddLeftGroupbox('欢迎')
local player = game.Players.LocalPlayer
local avatarImage = HomeGroup:AddImage('AvatarThumbnail', {
    Image = 'rbxassetid://0',
    Callback = function(image)
        print('Image changed!', image)
    end,
})

task.spawn(function()
    repeat task.wait() until player
    task.wait(1)
    local success, thumbnail = pcall(function()
        return game:GetService('Players'):GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    if success and thumbnail then
        avatarImage:SetImage(thumbnail)
    end
end)

local IntroductionGroup = Tabs.Home:AddRightGroupbox("介绍")
IntroductionGroup:AddLabel('<font color="rgb(255,255,255)">D</font><font color="rgb(220,220,220)">e</font><font color="rgb(190,190,190)">v</font><font color="rgb(160,160,160)">:</font> <font color="rgb(130,130,130)">b</font><font color="rgb(100,100,100)">y</font><font color="rgb(70,70,70)">小</font><font color="rgb(40,40,40)">西</font>')

local ChangelogsGroup = Tabs.Home:AddRightGroupbox("公告")
ChangelogsGroup:AddLabel('<font color="rgb(0,255,0)"> 加入QQ705378396</font>')

local gm = Tabs.w:AddRightGroupbox("获取")

local gm = Tabs.w:AddRightGroupbox("获取")

gm:AddButton({
    Text = "Voivode",
    Func = function()
local h = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Customize"):WaitForChild("PurchaseEvent")
h:FireServer("Voivode")
end
}) 

gm:AddButton({
    Text = "Iron Stake",
    Func = function()
local h = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Customize"):WaitForChild("PurchaseEvent")
h:FireServer("Iron Stake")
end
}) 

local sj = Tabs.w:AddRightGroupbox("视角")
local noRecoilEnabled = false
local recoilConnection = nil

local function toggleAntiSelfDamage(state)
    noRecoilEnabled = state
    
    if state then
        if not recoilConnection then
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local recoilEvent = ReplicatedStorage:FindFirstChild("RecoilEvent")
            
            if not recoilEvent then
                warn("RecoilEvent not found")
                return
            end
            for _, v in pairs(getconnections(recoilEvent.Event)) do
                v:Disable()
            end
           
            recoilConnection = recoilEvent.Event:Connect(function()
                recoilEvent:Fire(CFrame.identity)
            end)
        end
    else
        if recoilConnection then
            recoilConnection:Disconnect()
            recoilConnection = nil
        end
    end
end
sj:AddToggle('AntiSelfDamageToggle', {
    Text = '无后坐',
    Default = false,
    Tooltip = '禁用视角后坐力',
    Callback = toggleAntiSelfDamage
})

local FlightGroup = Tabs.w:AddLeftGroupbox("飞行")
local function updateSpeedDisplay()
    if speeds >= SPEED_LIMIT then
        Library:Notify("速度已达到上限: " .. SPEED_LIMIT, 2)
    end
   
    if nowe then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = RunService.Heartbeat
                while tpwalking and hb:Wait() do
                    local chr = LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    if chr and hum and hum.Parent then
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end
            end)
        end
    end
end

local function toggleFly(Value)
    nowe = Value
    local chr = LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    local humRootPart = chr and chr:FindFirstChild("HumanoidRootPart")
    
    if not hum or not humRootPart then 
        Library:Notify("无法找到角色或Humanoid", 3)
        return 
    end
    
    if nowe then
        humRootPart.CanCollide = false
        tpwalking = true
        
        for i = 1, speeds do
            spawn(function()
                local hb = RunService.Heartbeat
                while tpwalking and hb:Wait() do
                    local chr = LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    if chr and hum and hum.Parent then
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end
            end)
        end
        
        
        hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
        hum:ChangeState(Enum.HumanoidStateType.Swimming)
        
        if chr:FindFirstChild("Animate") then
            chr.Animate.Disabled = true
        end
        
        for i, v in next, hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end
        
        local rootPart = hum.RigType == Enum.HumanoidRigType.R6 and chr.Torso or chr.UpperTorso
        local bg = Instance.new("BodyGyro", rootPart)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = rootPart.CFrame
        
        local bv = Instance.new("BodyVelocity", rootPart)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        hum.PlatformStand = true
        
        local ctrl = { f = 0, b = 0, l = 0, r = 0 }
        local maxspeed = 50
        local flySpeed = 0
        
        spawn(function()
            while nowe and hum.Health > 0 do
                RunService.RenderStepped:Wait()
                ctrl.f = UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0
                ctrl.b = UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0
                ctrl.l = UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0
                ctrl.r = UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0
                
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    flySpeed = flySpeed + 0.5 + (flySpeed / maxspeed)
                    flySpeed = math.clamp(flySpeed, 0, maxspeed)
                else
                    flySpeed = math.clamp(flySpeed - 1, 0, maxspeed)
                end
                
                if flySpeed > 0 then
                    local dir = (workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
                        ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) -
                            workspace.CurrentCamera.CoordinateFrame.p)
                    bv.velocity = dir * flySpeed
                    bg.cframe = workspace.CurrentCamera.CoordinateFrame *
                        CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * flySpeed / maxspeed), 0, 0)
                else
                    bv.velocity = Vector3.new(0, 0.1, 0)
                end
            end
            
            bg:Destroy()
            bv:Destroy()
            
            if hum and hum.Parent then
                hum.PlatformStand = false
            end
            
            if chr and chr:FindFirstChild("Animate") then
                chr.Animate.Disabled = false
            end
        end)
    else
       
        humRootPart.CanCollide = true
        tpwalking = false
        
        hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
        hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        
        if chr:FindFirstChild("Animate") then
            chr.Animate.Disabled = false
        end
    end
end
local function toggleAntiSelfDamage(Value)
    isAntiSelfDamage = Value
    
    if isAntiSelfDamage then
       
        namecallHook1 = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod():lower()
            if self.Name == "ForceSelfDamage" and method == "fireserver" then
                return nil
            end
            return namecallHook1(self, ...)
        end))
    else
       
        if namecallHook1 then
            hookmetamethod(game, "__namecall", namecallHook1)
            namecallHook1 = nil
        end
    end
end

local function toggleAntiKnockback(Value)
    isAntiKnockback = Value
    
    if isAntiKnockback then
       
        renderConnection = RunService.RenderStepped:Connect(function(deltaTime)
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if not hum then return end
            
            local antiFlingObj = char:FindFirstChild("Anti-fling/LocalPlat")
            if antiFlingObj then
                antiFlingObj:Destroy()
            end
            
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        end)
    else
       
        if renderConnection then
            renderConnection:Disconnect()
            renderConnection = nil
        end
        
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            end
        end
    end
end

local function toggleAntiRagdoll(Value)
    isAntiRagdoll = Value
    
    if isAntiRagdoll then
       
        namecallHook2 = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = { ... }
            if method == "SetStateEnabled" and typeof(self) == "Instance" and self:IsA("Humanoid") then
                local state = args[1]
                if state == Enum.HumanoidStateType.Ragdoll then
                    return namecallHook2(self, state, false)
                end
            end
            return namecallHook2(self, ...)
        end))
    else
        if namecallHook2 then
            hookmetamethod(game, "__namecall", namecallHook2)
            namecallHook2 = nil
        end
        
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            end
        end
    end
end

FlightGroup:AddToggle('FlightToggle', {
    Text = '飞行开关',
    Default = false,
    Tooltip = '开启/关闭飞行功能',
    Callback = function(Value)
        toggleFly(Value)
    end
}):AddKeyPicker('NoclipKeybind', {
    Default = 'N',
    Mode = 'Toggle',
    Text = '飞行',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})

FlightGroup:AddSlider('SpeedSlider', {
    Text = '飞行速度',
    Default = 1,
    Min = 1,
    Max = SPEED_LIMIT,
    Rounding = 0,
    Suffix = " 级",
    Compact = false,
    Callback = function(Value)
        speeds = Value
        Library:Notify("速度已设置为: " .. Value .. " 级", 1)
        updateSpeedDisplay()
    end
})
FlightGroup:AddToggle('AntiSelfDamageToggle', {
    Text = '防自伤',
    Default = false,
    Tooltip = '',
    Callback = toggleAntiSelfDamage
})
FlightGroup:AddToggle('AntiKnockbackToggle', {
    Text = '防击飞',
    Default = false,
    Tooltip = '防止被其他玩家或机制击飞',
    Callback = toggleAntiKnockback
})

FlightGroup:AddToggle('AntiRagdollToggle', {
    Text = '防布娃娃',
    Default = false,
    Tooltip = '防止进入布娃娃状态',
    Callback = toggleAntiRagdoll
})

local CombatLeftGroup = Tabs.r:AddLeftGroupbox("杀戮光环·枪械")
local CombatRightGroup = Tabs.r:AddRightGroupbox("劳大肘击", "rbxassetid://16521157411")

CombatLeftGroup:AddToggle('BayonetKillAura', {
    Text = '刺刀杀戮光环',
    Default = false,
    Tooltip = '自动用刺刀攻击附近的僵尸',
}):AddKeyPicker('NoclipKeybind', {
    Default = 'Q',
    Mode = 'Toggle',
    Text = '刺刀杀戮光环',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})

CombatLeftGroup:AddToggle('BayonetAttackBarrels', {
    Text = '攻击炸药桶',
    Default = false,
    Tooltip = '是否攻击炸药桶类型的僵尸',
})

CombatLeftGroup:AddToggle('BayonetAutoRotate', {
    Text = '自动转向',
    Default = false,
    Tooltip = '攻击时自动面向目标',
})

CombatRightGroup:AddToggle('ElbowStrike', {
    Text = '肘击',
    Default = false,
    Tooltip = '使用斧头眩晕僵尸',
}):AddKeyPicker('NoclipKeybind', {
    Default = 'J',
    Mode = 'Toggle',
    Text = '肘击',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})

CombatRightGroup:AddToggle('CarbineStun', {
    Text = '卡宾枪肘击',
    Default = false,
    Tooltip = '多目标眩晕',
}):AddKeyPicker('NoclipKeybind', {
    Default = 'K',
    Mode = 'Toggle',
    Text = '卡宾枪肘击',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})

CombatRightGroup:AddSlider('StunTargets', {
    Text = '目标数量',
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Tooltip = '每次攻击最多眩晕的目标数',
})

local AutoLeftGroup = Tabs.u: AddRightGroupbox("自动")

local AutoBellActive = false
AutoLeftGroup:AddToggle('AutoBell', {
    Text = '自动敲钟',
    Default = false,
    Tooltip = '自动敲击钟楼（莱比锡地图）',
    Callback = function(Value)
        AutoBellActive = Value
        if Value then
            
            _G.AutoBellLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if not AutoBellActive then return end
                
                
                local leipzig = workspace:FindFirstChild("Leipzig")
                if leipzig and leipzig:FindFirstChild("Modes") then
                    local modes = leipzig.Modes
                    if modes:FindFirstChild("Objective") then
                        local objective = modes.Objective
                        if objective:FindFirstChild("BellInteract") then
                            local bell = objective.BellInteract
                            if bell:FindFirstChild("Interact") then
                                pcall(function()
                                    bell.Interact:FireServer()
                                end)
                            end
                        end
                    end
                end
            end)
            
           
        else
            
            if _G.AutoBellLoop then
                _G.AutoBellLoop:Disconnect()
                _G.AutoBellLoop = nil
            end
           
        end
    end
})

local AutoBucketActive = false
AutoLeftGroup:AddToggle('AutoBucket', {
    Text = '自动水桶灭火',
    Default = false,
    Tooltip = '自动使用水桶扑灭火焰',
    Callback = function(Value)
        AutoBucketActive = Value
        if Value then
            
            _G.AutoBucketLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if not AutoBucketActive then return end
                
                local player = game.Players.LocalPlayer
                local char = player.Character
                if not char then return end
                
                
                local bucket = char:FindFirstChild("Water Bucket") or 
                              player.Backpack:FindFirstChild("Water Bucket")
                
                if bucket then
                    
                    if bucket.Parent ~= char then
                        bucket.Parent = char
                        task.wait(0.1)
                    end
                    
                    
                    if bucket:FindFirstChild("RemoteEvent") then
                        pcall(function()
                            bucket.RemoteEvent:FireServer("Throw")
                        end)
                        
                        
                        task.spawn(function()
                            task.wait(0.2)
                            if bucket and bucket.Parent == char then
                                bucket.Parent = player.Backpack
                            end
                        end)
                    end
                end
            end)
            
           
        else
            
            if _G.AutoBucketLoop then
                _G.AutoBucketLoop:Disconnect()
                _G.AutoBucketLoop = nil
            end
           
        end
    end
})

AutoLeftGroup:AddDivider("jb")

AutoLeftGroup:AddToggle('AutoRepairBridge', {
    Text = '自动修桥',
    Default = false,
    Tooltip = '自动修复Berezina的桥',
})

AutoLeftGroup:AddToggle('AutoGetLogs', {
    Text = '自动拿木头',
    Default = false,
    Tooltip = '自动收集木头',
})

AutoLeftGroup:AddToggle('AutoPlaceLogs', {
    Text = '自动放木头',
    Default = false,
    Tooltip = '自动放置木头',
})

AutoLeftGroup:AddSlider('AutoSpeed', {
    Text = '自动化速度',
    Default = 100,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Suffix = " ms",
    Tooltip = '自动化操作的间隔时间',
})

local connections = {}
local activeFunctions = {}


local function getCharacter()
    return player.Character
end

local function distance(a, b)
    if not a or not b or not a:FindFirstChild("HumanoidRootPart") or not b:FindFirstChild("HumanoidRootPart") then
        return math.huge
    end
    return (a.HumanoidRootPart.Position - b.HumanoidRootPart.Position).magnitude
end

local function rotateToTarget(character, target)
    if not character or not target or not target:FindFirstChild("HumanoidRootPart") then 
        return false 
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then 
        return false 
    end
    
    local originalAutoRotate = humanoid.AutoRotate
    humanoid.AutoRotate = false
    
    local targetPos = target.HumanoidRootPart.Position
    local lookAtPos = Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z)
    
    
    rootPart.CFrame = CFrame.new(rootPart.Position, lookAtPos)
    
    
    humanoid.AutoRotate = originalAutoRotate
    
    return true
end


local function bayonetKillAuraLoop()
    while Toggles.BayonetKillAura.Value do
        local character = getCharacter()
        if not character or character:FindFirstChildOfClass("Humanoid").Health <= 0 then 
            task.wait(0.1)
            continue 
        end
        
        local zombies = workspace:FindFirstChild("Zombies")
        if not zombies then 
            task.wait(0.1)
            continue 
        end
        
        
        local weapon = character:FindFirstChild("Musket") or player.Backpack:FindFirstChild("Musket")
        if not weapon then 
            task.wait(0.1)
            continue 
        end
        
        
        if weapon.Parent ~= character then
            weapon.Parent = character
            task.wait(0.2)
        end
        
        local remoteEvent = weapon:FindFirstChild("RemoteEvent")
        if not remoteEvent then 
            task.wait(0.1)
            continue 
        end
        
        
        for _, zombie in pairs(zombies:GetChildren()) do
            if not Toggles.BayonetKillAura.Value then break end
            
            if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                
                if zombie:GetAttribute("Type") == "Barrel" and not Toggles.BayonetAttackBarrels.Value then
                    continue
                end
                
                
                if zombie:FindFirstChild("Barrel") then
                    continue
                end
                
                if distance(character, zombie) <= 15 then
                    local state = zombie:FindFirstChild("State")
                    if not state or state.Value ~= "Spawn" then
                        
                        if Toggles.BayonetAutoRotate.Value then
                            rotateToTarget(character, zombie)
                            task.wait(0.05) 
                        end
                        
                        
                        remoteEvent:FireServer("ThrustBayonet")
                        task.wait(0.1) 
                        
                        local hitPart = zombie:FindFirstChild("Head") or zombie:FindFirstChild("HumanoidRootPart")
                        if hitPart then
                            remoteEvent:FireServer("Bayonet_HitZombie", zombie, hitPart.Position, true)
                        end
                    end
                end
            end
        end
        
        task.wait(0.1)
    end
end


local function elbowStrikeLoop()
    while Toggles.ElbowStrike.Value do
        local character = getCharacter()
        if not character or character:FindFirstChildOfClass("Humanoid").Health <= 0 then 
            task.wait(0.1)
            continue 
        end
        
        local zombies = workspace:FindFirstChild("Zombies")
        if not zombies then 
            task.wait(0.1)
            continue 
        end
        
        
        local weapon = character:FindFirstChild("Axe") or player.Backpack:FindFirstChild("Axe")
        if not weapon then 
            task.wait(0.1)
            continue 
        end
        
        
        if weapon.Parent ~= character then
            weapon.Parent = character
            task.wait(0.2)
        end
        
        local remoteEvent = weapon:FindFirstChild("RemoteEvent")
        if not remoteEvent then 
            task.wait(0.1)
            continue 
        end
        
        for _, zombie in pairs(zombies:GetChildren()) do
            if not Toggles.ElbowStrike.Value then break end
            
            if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                if distance(character, zombie) <= 15 then
                    local state = zombie:FindFirstChild("State")
                    if state and state.Value == "Stunned" then
                        continue
                    end
                    
                    remoteEvent:FireServer("BraceBlock")
                    task.wait(0.05)
                    remoteEvent:FireServer("StopBraceBlock")
                    task.wait(0.05)
                    remoteEvent:FireServer("FeedbackStun", zombie, zombie.HumanoidRootPart.CFrame.Position)
                    
                    task.wait(0.1)
                end
            end
        end
        
        task.wait(0.2)
    end
end


local function carbineStunLoop()
    while Toggles.CarbineStun.Value do
        local character = getCharacter()
        if not character or character:FindFirstChildOfClass("Humanoid").Health <= 0 then 
            task.wait(0.5)
            continue 
        end
        
        local zombies = workspace:FindFirstChild("Zombies")
        if not zombies then 
            task.wait(1)
            continue 
        end
        
        local carbine = character:FindFirstChild("Carbine") or player.Backpack:FindFirstChild("Carbine")
        if not carbine then 
            task.wait(1)
            continue 
        end
        
        local remoteEvent = carbine:FindFirstChild("RemoteEvent")
        if not remoteEvent then 
            task.wait(1)
            continue 
        end
        
        
        local zombiesInRange = {}
        local characterRoot = character:FindFirstChild("HumanoidRootPart")
        if not characterRoot then 
            task.wait(0.1)
            continue 
        end
        
        for _, zombie in pairs(zombies:GetChildren()) do
            if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                local dist = (zombie.HumanoidRootPart.Position - characterRoot.Position).Magnitude
                if dist <= 15 then
                    table.insert(zombiesInRange, zombie)
                end
            end
        end
        
        
        table.sort(zombiesInRange, function(a, b)
            return (a.HumanoidRootPart.Position - characterRoot.Position).Magnitude < 
                   (b.HumanoidRootPart.Position - characterRoot.Position).Magnitude
        end)
        
        
        local maxTargets = math.min(Options.StunTargets.Value, #zombiesInRange)
        if maxTargets > 0 then
            
            if maxTargets > 0 and zombiesInRange[1] then
                rotateToTarget(character, zombiesInRange[1])
                task.wait(0.1)
            end
            
            remoteEvent:FireServer("Shove")
            task.wait(0.2)
            
            for i = 1, maxTargets do
                local zombie = zombiesInRange[i]
                remoteEvent:FireServer("FeedbackStun", zombie, zombie.HumanoidRootPart.CFrame.Position)
                
                if i < maxTargets then
                    task.wait(0.1)
                end
            end
        end
        
        task.wait(0.5)
    end
end


local function autoRepairBridgeLoop()
    while Toggles.AutoRepairBridge.Value do
        local character = getCharacter()
        if not character or not character:FindFirstChild("HumanoidRootPart") then 
            task.wait(0.5)
            continue 
        end
        
        local root = character.HumanoidRootPart
        local bridge = workspace:FindFirstChild("Berezina")
        
        if not bridge then 
            task.wait(1)
            continue 
        end
        
        bridge = bridge:FindFirstChild("Modes")
        if not bridge then 
            task.wait(1)
            continue 
        end
        
        bridge = bridge:FindFirstChild("Holdout")
        if not bridge then 
            task.wait(1)
            continue 
        end
        
        bridge = bridge:FindFirstChild("Bridge")
        if not bridge then 
            task.wait(1)
            continue 
        end

        local nearest, nearestDist = nil, math.huge

        
        for _, section in ipairs(bridge:GetChildren()) do
            local posts = section:FindFirstChild("Posts")
            if posts then
                for _, part in ipairs(posts:GetChildren()) do
                    if part:IsA("BasePart") and part:FindFirstChild("ConstructHealth") then
                        local d = (part.Position - root.Position).Magnitude
                        if d < nearestDist then
                            nearestDist = d
                            nearest = part.ConstructHealth
                        end
                    end
                end
            end

            local beam = section:FindFirstChild("Beam")
            if beam and beam:FindFirstChild("ConstructHealth") then
                local d = (beam.Position - root.Position).Magnitude
                if d < nearestDist then
                    nearestDist = d
                    nearest = beam.ConstructHealth
                end
            end

            for _, joists in ipairs(section:GetChildren()) do
                if joists.Name == "Joists" and joists:FindFirstChild("ConstructHealth") then
                    local d = (joists.Position - root.Position).Magnitude
                    if d < nearestDist then
                        nearestDist = d
                        nearest = joists.ConstructHealth
                    end
                end
            end
        end

        if nearest and nearestDist < 20 then 
            local hammer = player.Backpack:FindFirstChild("Hammer") or player.Backpack:FindFirstChild("Claw Hammer")
            if hammer and hammer:FindFirstChild("RemoteEvent") then
                if hammer.Parent ~= character then
                    hammer.Parent = character
                    task.wait(0.2)
                end
                
                hammer.RemoteEvent:FireServer("Repair", nearest)
            end
        end
        
        task.wait(0.2)
    end
end


local function autoGetLogsLoop()
    local waitTime = math.max(50, 1010 - Options.AutoSpeed.Value) / 1000
    
    while Toggles.AutoGetLogs.Value do
        local remoteEvent = workspace:FindFirstChild("Berezina")
        if remoteEvent then
            remoteEvent = remoteEvent:FindFirstChild("Modes")
            if remoteEvent then
                remoteEvent = remoteEvent:FindFirstChild("Holdout")
                if remoteEvent then
                    remoteEvent = remoteEvent:FindFirstChild("Log")
                    if remoteEvent then
                        remoteEvent = remoteEvent:FindFirstChild("Log")
                        if remoteEvent then
                            remoteEvent = remoteEvent:FindFirstChild("Interact")
                            if remoteEvent and remoteEvent:IsA("RemoteEvent") then
                                pcall(function()
                                    remoteEvent:FireServer()
                                end)
                            end
                        end
                    end
                end
            end
        end
        
        task.wait(waitTime)
    end
end


local function autoPlaceLogsLoop()
    local waitTime = math.max(50, 1010 - Options.AutoSpeed.Value) / 1000
    
    while Toggles.AutoPlaceLogs.Value do
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Name == "PlaceLogProximityPrompt" then
                pcall(function()
                    fireproximityprompt(prompt)
                end)
                task.wait(0.05) 
            end
        end
        
        task.wait(waitTime)
    end
end


local function startFunction(funcName, loopFunc)
    if activeFunctions[funcName] then
        task.cancel(activeFunctions[funcName])
    end
    activeFunctions[funcName] = task.spawn(loopFunc)
end


local function stopFunction(funcName)
    if activeFunctions[funcName] then
        task.cancel(activeFunctions[funcName])
        activeFunctions[funcName] = nil
    end
end


Toggles.BayonetKillAura:OnChanged(function()
    if Toggles.BayonetKillAura.Value then
        startFunction("BayonetKillAura", bayonetKillAuraLoop)
       
    else
        stopFunction("BayonetKillAura")
       
    end
end)

Toggles.ElbowStrike:OnChanged(function()
    if Toggles.ElbowStrike.Value then
        startFunction("ElbowStrike", elbowStrikeLoop)
       
    else
        stopFunction("ElbowStrike")
       
    end
end)

Toggles.CarbineStun:OnChanged(function()
    if Toggles.CarbineStun.Value then
        startFunction("CarbineStun", carbineStunLoop)
       
    else
        stopFunction("CarbineStun")
       
    end
end)

Toggles.AutoRepairBridge:OnChanged(function()
    if Toggles.AutoRepairBridge.Value then
        startFunction("AutoRepairBridge", autoRepairBridgeLoop)
       
    else
        stopFunction("AutoRepairBridge")
       
    end
end)

Toggles.AutoGetLogs:OnChanged(function()
    if Toggles.AutoGetLogs.Value then
        startFunction("AutoGetLogs", autoGetLogsLoop)
       
    else
        stopFunction("AutoGetLogs")
       
    end
end)

Toggles.AutoPlaceLogs:OnChanged(function()
    if Toggles.AutoPlaceLogs.Value then
        startFunction("AutoPlaceLogs", autoPlaceLogsLoop)
       
    else
        stopFunction("AutoPlaceLogs")
    end
end)


player.CharacterAdded:Connect(function(character)
    task.wait(1) 
    
    
    for funcName, _ in pairs(activeFunctions) do
        stopFunction(funcName)
    end
    
    
    Toggles.BayonetKillAura:SetValue(false)
    Toggles.ElbowStrike:SetValue(false)
    Toggles.CarbineStun:SetValue(false)
    Toggles.AutoRepairBridge:SetValue(false)
    Toggles.AutoGetLogs:SetValue(false)
    Toggles.AutoPlaceLogs:SetValue(false)
    end)

do
    local MedicSection = Tabs.u:AddLeftGroupbox("医疗兵", "heart")
    
    local AutoRequestHealEnabled = false
    local HealRange = 10
    local HealCooldown = 3
    local HealThreshold = 25
    local HealData = {}
    local HealNotify = {}
    
    local function RequestHeal(player, humanoid)
        if not player or not humanoid then return end
        if humanoid.Health > humanoid.MaxHealth * (HealThreshold / 100) then return end
        local lastReq = HealData[player] or 0
        if tick() - lastReq < HealCooldown then return end
        HealData[player] = tick()
        local localChar = LocalPlayer.Character
        if not localChar then return end
        local localHRP = localChar:FindFirstChild("HumanoidRootPart")
        if not localHRP then return end
        local targetHRP = humanoid.Parent:FindFirstChild("HumanoidRootPart") or humanoid.Parent:FindFirstChild("Torso")
        if not targetHRP then return end
        if (localHRP.Position - targetHRP.Position).Magnitude > HealRange then return end
        local medSupplies = localChar:FindFirstChild("Medical Supplies")
        if not medSupplies then return end
        local remote = medSupplies:FindFirstChild("RemoteEvent")
        if not remote then return end
        pcall(function()
            remote:FireServer("SendRequest", humanoid)
            local lastNotify = HealNotify[player] or 0
            if tick() - lastNotify >= HealCooldown then
                HealNotify[player] = tick()
                Library:Notify({ Title = "自动治疗", Description = "已为 " .. player.Name .. " 请求治疗", Time = 2 })
            end
        end)
    end
    
    task.spawn(function()
        while task.wait(0.25) do
            if not AutoRequestHealEnabled then continue end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid and humanoid.Health <= humanoid.MaxHealth * (HealThreshold / 100) then
                        pcall(function() RequestHeal(player, humanoid) end)
                    end
                end
            end
        end
    end)
    
    MedicSection:AddToggle("AutoRequestHeal", {
        Text = "自动请求治疗濒死玩家",
        Default = false,
        Tooltip = "当附近玩家生命值低时自动请求治疗",
        Callback = function(state)
            AutoRequestHealEnabled = state
           
        end,
    })
    
    MedicSection:AddSlider("HealThreshold", {
        Text = "治疗阈值 (%)",
        Default = 25,
        Min = 1,
        Max = 100,
        Rounding = 0,
        Tooltip = "自动治疗的生命值百分比阈值",
        Callback = function(val) HealThreshold = val end,
    })
    
    local SapperSection = Tabs.u:AddRightGroupbox("工兵", "hammer")
    
    local AutoRepairEnabled = false
    local AutoRepairCooldown = 0.1
    
    local function FireRepair(buildHealth)
        local char = LocalPlayer.Character
        if not (char and buildHealth) then return end
        local hammer = char:FindFirstChild("Hammer")
        if not hammer or not hammer:FindFirstChild("RemoteEvent") then return end
        local args = {"Repair", buildHealth}
        pcall(function() hammer.RemoteEvent:FireServer(unpack(args)) end)
    end
    
    local function GetLookedStructure()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local origin = Workspace.CurrentCamera.CFrame.Position
        local direction = Workspace.CurrentCamera.CFrame.LookVector * 50
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local rayResult = Workspace:Raycast(origin, direction, params)
        if not rayResult or not rayResult.Instance then return nil end
        local hit = rayResult.Instance
        local model = hit:FindFirstAncestorOfClass("Model")
        if not model then return nil end
        local buildHealth = model:FindFirstChild("BuildingHealth") or (model.Parent and model.Parent:FindFirstChild("BuildingHealth"))
        return buildHealth
    end
    
    task.spawn(function()
        while true do
            task.wait(AutoRepairCooldown)
            if not AutoRepairEnabled then continue end
            local buildHealth = GetLookedStructure()
            if buildHealth then
                local currentHealth = buildHealth.Value
                local maxHealth = buildHealth:GetAttribute("MaxHealth")
                if maxHealth and currentHealth < maxHealth then FireRepair(buildHealth) end
            end
        end
    end)
    
    SapperSection:AddToggle("AutoRepair", {
        Text = "自动修复",
        Default = false,
        Tooltip = "自动修复建筑",
        Callback = function(state)
            AutoRepairEnabled = state
            Library:Notify({ Title = "自动修复", Description = state and "自动修复已启用" or "自动修复已禁用", Time = 2 })
        end,
    })
    
    local ChaplainSection = Tabs.u:AddLeftGroupbox("牧师", "pray")
    
    local PlayersSvc = game:GetService("Players")
    local AutoBlessEnabled = false
    local BlessThreshold = 50
    local BlessCooldown = 2
    local BlessRange = 15
    local BlessData = {}
    
    local function GetEquippedBlessRemote()
        local localChar = LocalPlayer and LocalPlayer.Character
        if not localChar then return nil end
        local tool = localChar:FindFirstChild("Blessing")
        if tool and tool:FindFirstChild("RemoteEvent") then return tool:FindFirstChild("RemoteEvent") end
        for _, child in ipairs(localChar:GetChildren()) do
            if child:IsA("Tool") and child.Name:lower():find("bless") and child:FindFirstChild("RemoteEvent") then
                return child:FindFirstChild("RemoteEvent")
            end
        end
        return nil
    end
    
    local function InRangeOfLocal(player, maxRange)
        local localChar = LocalPlayer and LocalPlayer.Character
        if not (localChar and localChar:FindFirstChild("HumanoidRootPart")) then return false end
        if not (player and player.Character) then return false end
        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
        if not targetHRP then return false end
        return (localChar.HumanoidRootPart.Position - targetHRP.Position).Magnitude <= (maxRange or BlessRange)
    end
    
    local function FireBlessByPlayer_Silent(player)
        if not player then return false end
        local remote = GetEquippedBlessRemote()
        if not remote then return false end
        if not InRangeOfLocal(player, BlessRange) then return false end
        local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then return false end
        local ok, err = pcall(function() remote:FireServer("SendRequest", humanoid) end)
        if not ok then return false end
        return true
    end
    
    local function GetPlayerInfectedValue(player)
        local ok, val = pcall(function()
            local wsPlayers = Workspace:FindFirstChild("Players")
            if wsPlayers then
                local wsP = wsPlayers:FindFirstChild(player.Name)
                if wsP and wsP:FindFirstChild("UserStates") and wsP.UserStates:FindFirstChild("Infected") then
                    return wsP.UserStates.Infected.Value
                end
            end
            if player:FindFirstChild("UserStates") and player.UserStates:FindFirstChild("Infected") then
                return player.UserStates.Infected.Value
            end
            if player.Character and player.Character:FindFirstChild("UserStates") and player.Character.UserStates:FindFirstChild("Infected") then
                return player.Character.UserStates.Infected.Value
            end
            return nil
        end)
        if ok then return val end
        return nil
    end
    
    task.spawn(function()
        while task.wait(0.25) do
            if not AutoBlessEnabled then continue end
            for _, player in ipairs(PlayersSvc:GetPlayers()) do
                if not player or player == LocalPlayer then continue end
                local infectedVal = nil
                pcall(function() infectedVal = GetPlayerInfectedValue(player) end)
                if infectedVal ~= nil then
                    local numeric = nil
                    if type(infectedVal) == "number" then numeric = infectedVal
                    elseif type(infectedVal) == "string" then numeric = tonumber(infectedVal)
                    elseif type(infectedVal) == "boolean" then numeric = infectedVal and 1 or 0 end
                    local thresholdNum = tonumber(BlessThreshold) or 0
                    if numeric and numeric >= thresholdNum then
                        local uid = player.UserId or player.Name
                        local last = BlessData[uid] or 0
                        if tick() - last >= (tonumber(BlessCooldown) or 0) then
                            local success = false
                            pcall(function() success = FireBlessByPlayer_Silent(player) end)
                            if success then
                                BlessData[uid] = tick()
                                Library:Notify({ Title = "自动祝福", Description = "已向 " .. player.Name .. " 发送祝福", Time = 2 })
                            end
                        end
                    end
                end
            end
        end
    end)
    
    ChaplainSection:AddToggle("AutoBless", {
        Text = "自动祝福感染玩家",
        Default = false,
        Tooltip = "开启自动祝福",
        Callback = function(state)
            AutoBlessEnabled = state
            Library:Notify({ Title = "牧师", Description = state and "自动祝福已启用" or "自动祝福已禁用", Time = 2 })
        end,
    })
    
    ChaplainSection:AddSlider("BlessThreshold", {
        Text = "感染阈值",
        Default = 50,
        Min = 0,
        Max = 200,
        Rounding = 0,
        Tooltip = "自动祝福的阈值",
        Callback = function(val) BlessThreshold = tonumber(val) or 0 end,
    })
end


do
    local AimingGroup = Tabs.w:AddLeftGroupbox("瞄准", "crosshair")
    
    local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
    
    local FlintLockSuccess, FlintLock = pcall(require, Modules.Weapons:FindFirstChild("Flintlock"))
    local originBayonet, changeBayonet
    
    if FlintLockSuccess then
        originBayonet = FlintLock.BayonetHitCheck
        
        local v_u_1 = {}
        v_u_1.__index = v_u_1
        
        function v_u_1.BayonetHitCheck(p115, p116, p117, p118, p119)
            local v120 = workspace:Raycast(p116, p117, p118)
            if v120 then
                if v120.Instance.Parent.Name == "m_Zombie" then
                    local v121 = p118.FilterDescendantsInstances
                    local v122 = v120.Instance
                    table.insert(v121, v122)
                    p118.FilterDescendantsInstances = v121
                    local v123 = v120.Instance.Parent:FindFirstChild("Orig")
                    if v123 then
                        local Head = nil
                        for i, part in pairs(v120.Instance.Parent:GetChildren()) do
                            if part.Name == "Head" and (part.ClassName == "Part" or part.ClassName == "MeshPart") then
                                Head = part
                                break
                            end
                        end
                        if Head then
                            p115.remoteEvent:FireServer("Bayonet_HitZombie", v123.Value, Head.CFrame.Position, true, "Head")
                            local v_u_124 = v123.Value
                            local v_u_125 = tick()
                            v_u_124:SetAttribute("WepHitID", tick())
                            v_u_124:SetAttribute("WepHitDirection", p117 * 10)
                            v_u_124:SetAttribute("WepHitPos", v120.Position)
                            task.delay(0.2, function()
                                if v_u_124:GetAttribute("WepHitID") == v_u_125 then
                                    v_u_124:SetAttribute("WepHitDirection", nil)
                                    v_u_124:SetAttribute("WepHitPos", nil)
                                    v_u_124:SetAttribute("WepHitID", nil)
                                end
                            end)
                        end
                    end
                    return 1
                end
                local v126 = v120.Instance.Parent:FindFirstChild("DoorHit") or v120.Instance:FindFirstChild("BreakGlass")
                if v126 and not table.find(p119, v126) then
                    table.insert(p119, v126)
                    p115.remoteEvent:FireServer("Bayonet_HitCon", v120.Instance, v120.Position, v120.Normal, v120.Material)
                    return 2
                end
                local v127 = v120.Instance.Parent:FindFirstChild("Humanoid") or v120.Instance.Parent.Parent:FindFirstChild("Humanoid")
                if v127 and not table.find(p119, v127) then
                    table.insert(p119, v127)
                    p115.remoteEvent:FireServer("Bayonet_HitPlayer", v127, v120.Position)
                    return 2
                end
            end
            return 0
        end
        
        function changeBayonet(value)
            FlintLock.BayonetHitCheck = value and v_u_1.BayonetHitCheck or originBayonet
        end
    else
        warn("刺刀模块未找到!")
    end
    
    local MeleeBaseSuccess, MeleeBase = pcall(require, Modules.Weapons:FindFirstChild("MeleeBase"))
    local originMelee, changeMelee
    
    if MeleeBaseSuccess then
        originMelee = MeleeBase.MeleeHitCheck
        
        local u1 = {}
        u1.__index = u1
        
        local u8 = game:GetService("CollectionService")
        local u10 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RbxUtil"):WaitForChild("DebugVisualizer"))
        local v11 = game.Players.LocalPlayer:WaitForChild("Options")
        local u14 = v11:WaitForChild("Gore")
        local u15 = v11:WaitForChild("WeaponStains")
        local v5 = game.ReplicatedStorage:WaitForChild("GameStates"):WaitForChild("Gameplay")
        local u7 = v5:WaitForChild("PVP")
        
        function u1.MeleeHitCheck(p100, p101, p102, p103, p104, p105)
            local v106 = workspace:Raycast(p101, p102, p103)
            if v106 then
                if v106.Instance.Parent.Name == "m_Zombie" then
                    local v107 = p103.FilterDescendantsInstances
                    local v108 = v106.Instance
                    table.insert(v107, v108)
                    p103.FilterDescendantsInstances = v107
                    local v109 = v106.Instance.Parent:FindFirstChild("Orig")
                    if v109 then
                        if p100.sharp and shared.Gib ~= nil then
                            if v109.Value then
                                local v110 = v109.Value:FindFirstChild("Zombie")
                                local v111 = not p100.Stats.HeadshotMulti and 2.3 or p100.Stats.HeadshotMulti
                                if v110 and v110.Health - p100.Stats.Damage * v111 <= 0 then
                                    shared.Gib(v109.Value, v106.Instance.Name, v106.Position, v106.Normal, true)
                                end
                            else
                                shared.Gib(v109.Value, v106.Instance.Name, v106.Position, v106.Normal, true)
                            end
                        end
                        if not p104[v109] or p104[v109] < (p100.Stats.MaxHits or 3) then
                            if p105 then
                                p100.remoteEvent:FireServer("ThrustCharge", v109.Value, v106.Position, v106.Normal)
                            else
                                local Head = nil
                                for i, part in pairs(v106.Instance.Parent:GetChildren()) do
                                    if part.Name == "Head" and (part.ClassName == "Part" or part.ClassName == "MeshPart") then
                                        Head = part
                                        break
                                    end
                                end
                                if Head then
                                    local u112 = v109.Value
                                    local v113 = Head.CFrame.Position - p101
                                    if v113:Dot(v113) > 1 then
                                        v113 = v113.Unit
                                    end
                                    local v114 = v113 * 25
                                    p100.remoteEvent:FireServer("HitZombie", u112, Head.CFrame.Position, true, v114, "Head", v106.Normal)
                                    if not u112:GetAttribute("WepHitDirection") then
                                        local u115 = tick()
                                        u112:SetAttribute("WepHitID", tick())
                                        u112:SetAttribute("WepHitDirection", v114)
                                        u112:SetAttribute("WepHitPos", v106.Position)
                                        task.delay(0.2, function()
                                            if u112:GetAttribute("WepHitID") == u115 then
                                                u112:SetAttribute("WepHitDirection", nil)
                                                u112:SetAttribute("WepHitPos", nil)
                                                u112:SetAttribute("WepHitID", nil)
                                            end
                                        end)
                                    end
                                    u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                                    u10:CastSphere("PartPosition", CFrame.new(v106.Position), Color3.fromRGB(255, 85, 0))
                                    u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(0, 255, 0), p102.Magnitude / 1)
                                end
                            end
                            if p104[v109] then
                                p104[v109] = p104[v109] + 1
                            else
                                table.insert(p104, v109)
                                p104[v109] = 1
                                if u14.Value and (u15.Value and p100.player:GetAttribute("Platform") ~= "Console") then
                                    local v116 = p100.bloodSaturation + 0.1
                                    p100.bloodSaturation = math.min(v116, 1)
                                end
                            end
                        end
                    end
                    return 1
                end
                if not p105 then
                    local v117 = v106.Instance.Parent:FindFirstChild("DoorHit") or v106.Instance:FindFirstChild("BreakGlass")
                    if v117 and not table.find(p104, v117) then
                        table.insert(p104, v117)
                        p100.remoteEvent:FireServer("HitCon", v106.Instance)
                        u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                        u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                        return 2
                    end
                    local v118 = v106.Instance.Parent:FindFirstChild("Humanoid") or v106.Instance.Parent.Parent:FindFirstChild("Humanoid")
                    if v118 and not table.find(p104, v118) then
                        table.insert(p104, v118)
                        p100.remoteEvent:FireServer("HitPlayer", v118, v106.Position)
                        u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                        u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(0, 255, 0), p102.Magnitude / 1)
                        return 2
                    end
                    if u7:GetAttribute("Active") == true then
                        local v119 = v106.Instance.Parent:FindFirstChild("BuildingHealth") or v106.Instance.Parent.Parent:FindFirstChild("BuildingHealth")
                        if v119 ~= nil and not table.find(p104, v119) then
                            table.insert(p104, v119)
                            local v120 = v119.Parent:FindFirstChild("Creator")
                            if v120 then
                                v120 = v120.Value
                            end
                            if v120 ~= nil and (v120.Neutral == false and (p100.player.Team ~= nil and (v120.Team ~= nil and p100.player.Team.Name == v120.Team.Name))) then
                                return 2
                            end
                            p100.remoteEvent:FireServer("HitBuilding", v119.Parent)
                            u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                            u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                            return 2
                        end
                    end
                    if p100.Stats.BreaksDown and u8:HasTag(v106.Instance, "Breakable") then
                        local v121 = OverlapParams.new()
                        v121.FilterDescendantsInstances = p103.FilterDescendantsInstances
                        local v122 = workspace:GetPartBoundsInRadius(v106.Position, 0.1, v121)
                        local v123 = {}
                        for v124 = 1, #v122 do
                            if u8:HasTag(v122[v124], "Breakable") then
                                local v125 = v122[v124]
                                table.insert(v123, v125)
                            end
                        end
                        p100.remoteEvent:FireServer("HitBreakable", v123, (v106.Position - p101).Unit)
                        u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                        u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                        return 2
                    end
                    u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 0, 0), p102.Magnitude / 1)
                end
            else
                u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 0, 0), p102.Magnitude / 1)
            end
            return 0
        end
        
        function changeMelee(value)
            MeleeBase.MeleeHitCheck = value and u1.MeleeHitCheck or originMelee
        end
    else
        warn("近战基础模块未找到!")
    end
    
    AimingGroup:AddToggle("HeadHit", {
        Text = "头部命中",
        Default = false,
        Tooltip = "强制近战和刺刀攻击瞄准僵尸头部 (跳过点燃者僵尸)",
        Callback = function(Value)
            if FlintLockSuccess then changeBayonet(Value) end
            if MeleeBaseSuccess then changeMelee(Value) end
            Library:Notify({
                Title = "瞄准",
                Description = Value and "头部命中已启用" or "头部命中已禁用",
                Time = 2,
            })
        end,
    })
    
    local AimlockBomberEnabled = false
    local AimlockBomberRange = 150
    local AimlockBomberSmoothness = 0.2
    local AimlockBomberUseFOV = false
    local AimlockBomberFOVVisible = false
    local AimlockBomberFOV = 90
    local AimlockBomberCheckWalls = true
    local aimlockConnection = nil
    
    local function getCamera()
        return Workspace.CurrentCamera
    end
    
    local previousPositions = {}
    
    local function isMoving(model)
        if not model or not model:IsA("Model") then return false end
        local head = model:FindFirstChild("Head")
        if not head then return false end
        local prevPos = previousPositions[model]
        previousPositions[model] = head.Position
        if not prevPos then return false end
        return (head.Position - prevPos).Magnitude > 0.05
    end
    
    local function getTargetPart(model)
        if not model then return nil end
        if isMoving(model) then
            return model:FindFirstChild("Barrel") or model:FindFirstChild("Head")
        else
            return model:FindFirstChild("Head") or model:FindFirstChild("Barrel")
        end
    end
    
    local function inCameraFOV(camCFrame, pos, fovDegrees)
        local camPos = camCFrame.Position
        local camLook = camCFrame.LookVector
        local dir = (pos - camPos)
        local dist = dir.Magnitude
        if dist == 0 then return true end
        local unit = dir / dist
        local dot = unit:Dot(camLook)
        return dot >= math.cos(math.rad(fovDegrees / 2))
    end
    
    local function isObstructed(camPos, targetPos, targetModel)
        if not AimlockBomberCheckWalls then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local ignoreList = {}
        local camFolder = Workspace:FindFirstChild("Camera")
        if camFolder then table.insert(ignoreList, camFolder) end
        local zombiesFolder = Workspace:FindFirstChild("Zombies")
        if zombiesFolder then table.insert(ignoreList, zombiesFolder) end
        if targetModel and targetModel:IsA("Instance") then table.insert(ignoreList, targetModel) end
        if LocalPlayer and LocalPlayer.Character then table.insert(ignoreList, LocalPlayer.Character) end
        params.FilterDescendantsInstances = ignoreList
        local dir = (targetPos - camPos)
        local result = Workspace:Raycast(camPos, dir, params)
        return result ~= nil
    end
    
    local function getNearestBomber(range)
        local cam = getCamera()
        if not cam then return nil end
        local camFolder = Workspace:FindFirstChild("Camera")
        if not camFolder then return nil end
        local camPos = cam.CFrame.Position
        local camLook = cam.CFrame.LookVector
        local closestPart, closestDist = nil, range
        
        for _, model in ipairs(camFolder:GetChildren()) do
            if model:IsA("Model") and model.Name == "m_Zombie" and model:FindFirstChild("Barrel") then
                local targetPart = getTargetPart(model)
                if targetPart and targetPart:IsA("BasePart") then
                    local dir = (targetPart.Position - camPos)
                    local dist = dir.Magnitude
                    if dist <= range then
                        if AimlockBomberUseFOV and not inCameraFOV(cam.CFrame, targetPart.Position, AimlockBomberFOV) then
     
                        else
                            local dot = camLook:Dot(dir.Unit)
                            if dot > 0.01 then
                                if not isObstructed(camPos, targetPart.Position, model) then
                                    if dist < closestDist then
                                        closestDist = dist
                                        closestPart = targetPart
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return closestPart
    end
    
    local function startAimlockBomber()
        if aimlockConnection then return end
        aimlockConnection = RunService.RenderStepped:Connect(function(dt)
            if not AimlockBomberEnabled then return end
            local cam = getCamera()
            if not cam then return end
            local targetPart = getNearestBomber(AimlockBomberRange)
            if not targetPart then return end
            local camPos = cam.CFrame.Position
            local targetPos = targetPart.Position
            local desired = CFrame.new(camPos, targetPos)
            local responsiveness = math.clamp(1 - (AimlockBomberSmoothness or 0.2), 0, 1)
            local frameAlpha = responsiveness * math.clamp(dt * 60, 0, 1)
            frameAlpha = math.clamp(frameAlpha, 0.001, 0.999)
            local ok, newCFrame = pcall(function() return cam.CFrame:Lerp(desired, frameAlpha) end)
            if ok and newCFrame then
                pcall(function() cam.CFrame = newCFrame end)
            end
        end)
    end
    
    local function stopAimlockBomber()
        if aimlockConnection then
            aimlockConnection:Disconnect()
            aimlockConnection = nil
        end
        previousPositions = {}
    end
    
    AimingGroup:AddToggle("AimlockBomber", {
        Text = "炸弹僵尸锁定",
        Default = false,
        Tooltip = "将摄像头锁定到炸弹僵尸",
        Callback = function(Value)
            AimlockBomberEnabled = Value
            if Value then
                startAimlockBomber()
            else
                stopAimlockBomber()
            end
        end,
    })
    
    AimingGroup:AddSlider("BomberRange", {
        Text = "范围 (格)",
        Default = 150,
        Min = 1,
        Max = 300,
        Rounding = 0,
        Callback = function(Value)
            AimlockBomberRange = math.clamp(tonumber(Value) or AimlockBomberRange, 1, 300)
        end,
    })
    
    AimingGroup:AddSlider("BomberSmoothness", {
        Text = "平滑度 (越低越快)",
        Default = 0.2,
        Min = 0.01,
        Max = 1.0,
        Rounding = 2,
        Callback = function(Value)
            AimlockBomberSmoothness = math.clamp(tonumber(Value) or AimlockBomberSmoothness, 0.01, 1.0)
        end,
    })
    
    AimingGroup:AddToggle("BomberUseFOV", {
        Text = "使用视野",
        Default = false,
        Tooltip = "只在视野圆圈内锁定",
        Callback = function(Value)
            AimlockBomberUseFOV = Value
        end,
    })
    
    AimingGroup:AddSlider("BomberFOV", {
        Text = "视野角度",
        Default = 90,
        Min = 10,
        Max = 180,
        Rounding = 0,
        Callback = function(Value)
            AimlockBomberFOV = math.clamp(tonumber(Value) or AimlockBomberFOV, 10, 180)
        end,
    })
    
    AimingGroup:AddToggle("BomberFOVVisible", {
        Text = "显示视野",
        Default = false,
        Tooltip = "显示视野圆圈",
        Callback = function(Value)
            AimlockBomberFOVVisible = Value
        end,
    })
    
    AimingGroup:AddToggle("BomberCheckWalls", {
        Text = "检查墙壁",
        Default = true,
        Tooltip = "不会瞄准墙后的炸弹僵尸",
        Callback = function(Value)
            AimlockBomberCheckWalls = Value
        end,
    })
    
    local LegitGroup = Tabs.w:AddRightGroupbox("其他功能", "shield-check")
    
    local TARGET_ANIM_IDS = {
        "rbxassetid://17406577733",
        "rbxassetid://15669224658",
        "rbxassetid://12591948314",
        "rbxassetid://12333491302",
    }
    
    local TARGETS = {}
    for _, v in ipairs(TARGET_ANIM_IDS) do
        local id = tostring(v)
        if id:match("^%d+$") then id = "rbxassetid://" .. id end
        TARGETS[id] = true
    end
    
    local humanoid, animator
    local playedTracks = {}
    local monitoring = false
    
    local function normalizeAnimId(id)
        if not id then return nil end
        local s = tostring(id)
        if s:match("^%d+$") then return "rbxassetid://" .. s end
        return s
    end
    
    local function trackIsTarget(track)
        if not track or not track.IsPlaying then return false end
        local anim = track.Animation
        if not anim or not anim.AnimationId then return false end
        local aId = normalizeAnimId(anim.AnimationId)
        return aId and TARGETS[aId]
    end
    
    local function doJump()
        if not humanoid or not humanoid.Parent then return end
        task.spawn(function()
            pcall(function()
                local timeout = 1
                local startTime = os.clock()
                while os.clock() - startTime < timeout do
                    local state = humanoid:GetState()
                    if state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.RunningNoPhysics or state == Enum.HumanoidStateType.Climbing then
                        break
                    end
                    task.wait(0.05)
                end
                local root = humanoid.RootPart or humanoid.Parent:FindFirstChild("HumanoidRootPart")
                if root then
                    local gravity = workspace.Gravity
                    local JumpPower = 30
                    local JumpHeight = 7.199999809265137
                    local jumpVelocity
                    if humanoid.UseJumpPower then
                        jumpVelocity = JumpPower
                    else
                        jumpVelocity = math.sqrt(2 * gravity * JumpHeight)
                    end
                    root.Velocity = Vector3.new(root.Velocity.X, jumpVelocity, root.Velocity.Z)
                end
            end)
        end)
    end
    
    local function startMonitoring()
        if monitoring then return end
        monitoring = true
        task.spawn(function()
            while monitoring do
                if animator then
                    local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
                    if ok and tracks then
                        for _, track in ipairs(tracks) do
                            if trackIsTarget(track) and not playedTracks[track] then
                                playedTracks[track] = true
                                pcall(doJump)
                                track.Stopped:Connect(function() playedTracks[track] = nil end)
                            end
                        end
                    end
                end
                task.wait(0.08)
            end
        end)
    end
    
    local function stopMonitoring()
        monitoring = false
        playedTracks = {}
    end
    
    local function refreshCharacter(char)
        humanoid = char and char:FindFirstChildOfClass("Humanoid") or nil
        animator = nil
        if humanoid then
            animator = humanoid:FindFirstChildOfClass("Animator")
            if not animator then
                animator = Instance.new("Animator")
                animator.Name = "AutoAnimator"
                animator.Parent = humanoid
            end
        end
        playedTracks = {}
    end
    
    refreshCharacter(LocalPlayer.Character)
    LocalPlayer.CharacterAdded:Connect(function(ch)
        ch:WaitForChild("Humanoid", 5)
        ch:WaitForChild("HumanoidRootPart", 5)
        refreshCharacter(ch)
    end)
    
   LegitGroup:AddToggle("AutoJump", {
    Text = "自动跳跃",
    Default = false,
    Tooltip = "当你刺击武器时自动跳跃",
    Callback = function(Value)
        if Value then
            startMonitoring()
        else
            stopMonitoring()
        end
    end,
})

local KeepBackpackActive = false
LegitGroup:AddToggle('KeepBackpack', {
    Text = '保持物品栏开启',
    Default = false,
    Tooltip = '始终显示背包界面',
    Callback = function(Value)
        KeepBackpackActive = Value
        if Value then
            
            local player = game.Players.LocalPlayer
            local backpackGui = player.PlayerGui:FindFirstChild("BackpackGui")
            
            if backpackGui then
                
                backpackGui.Enabled = true
                
                
                if not _G.BackpackConnection then
                    _G.BackpackConnection = backpackGui:GetPropertyChangedSignal("Enabled"):Connect(function()
                        if KeepBackpackActive and backpackGui.Enabled == false then
                            backpackGui.Enabled = true
                        end
                    end)
                end
                
                
                if not _G.CharacterAddedConnection then
                    _G.CharacterAddedConnection = player.CharacterAdded:Connect(function()
                        task.wait(1) 
                        local newBackpackGui = player.PlayerGui:FindFirstChild("BackpackGui")
                        if newBackpackGui then
                            newBackpackGui.Enabled = true
                        end
                    end)
                end
            end
            Library:Notify("已开启物品栏保持", 3)
        else
            
            if _G.BackpackConnection then
                _G.BackpackConnection:Disconnect()
                _G.BackpackConnection = nil
            end
            if _G.CharacterAddedConnection then
                _G.CharacterAddedConnection:Disconnect()
                _G.CharacterAddedConnection = nil
            end
            Library:Notify("已关闭物品栏保持", 3)
        end
    end
})




local NoSlowActive = false
LegitGroup:AddToggle('NoSlow', {
    Text = '无减速效果',
    Default = false,
    Tooltip = '免疫所有减速效果',
    Callback = function(Value)
        NoSlowActive = Value
        if Value then
            
            local player = game.Players.LocalPlayer
            
            local function EnforceSpeed()
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        
                        hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                            if hum.WalkSpeed < 16 then
                                hum.WalkSpeed = 16
                            end
                        end)
                        
                        
                        if hum.WalkSpeed < 16 then
                            hum.WalkSpeed = 16
                        end
                    end
                end
            end
            
            
            EnforceSpeed()
            
            
            if not _G.NoSlowConnection then
                _G.NoSlowConnection = player.CharacterAdded:Connect(function()
                    task.wait(1) 
                    EnforceSpeed()
                end)
            end
            
            Library:Notify("已开启无减速效果", 3)
        else
            
            if _G.NoSlowConnection then
                _G.NoSlowConnection:Disconnect()
                _G.NoSlowConnection = nil
            end
            Library:Notify("已关闭无减速效果", 3)
        end
    end
})

local SelfRescueActive = false
LegitGroup:AddToggle('SelfRescue', {
    Text = '自救',
    Default = false,
    Tooltip = '被僵尸抓住时自动攻击解脱',
    Callback = function(Value)
        SelfRescueActive = Value
        if Value then
      
            local function GetMeleeWeapon()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, child in pairs(char:GetChildren()) do
                        if child:GetAttribute("Melee") then
                            return child
                        end
                    end
                end
                local backpack = game.Players.LocalPlayer.Backpack
                for _, child in pairs(backpack:GetChildren()) do
                    if child:GetAttribute("Melee") then
                        return child
                    end
                end
                return nil
            end
            
         
            local function AttackTarget(weapon, target)
                if not weapon or not target then return end
                local char = game.Players.LocalPlayer.Character
                if not char then return end
                
                local targetRoot = target:FindFirstChild("HumanoidRootPart")
                if not targetRoot then return end
                
              
                local distance = (char.HumanoidRootPart.Position - targetRoot.Position).Magnitude
                if distance <= 5 then
                    local oldParent = weapon.Parent
                    local didEquip = false
                    
         
                    if weapon.Parent ~= char then
                        weapon.Parent = char
                        didEquip = true
                        task.wait(0.1)
                    end
                    
            
                    char.HumanoidRootPart.CFrame = CFrame.lookAt(
                        char.HumanoidRootPart.Position,
                        Vector3.new(targetRoot.Position.X, char.HumanoidRootPart.Position.Y, targetRoot.Position.Z)
                    )
                    
               
                    local remote = char:FindFirstChild(weapon.Name)
                    if remote and remote:FindFirstChild("RemoteEvent") then
                        local remoteEvent = remote.RemoteEvent
                        remoteEvent:FireServer("Swing", "Side")
                        remoteEvent:FireServer("HitZombie", target, target.Head.CFrame.Position, true)
                    end
                    
              
                    if didEquip then
                        task.wait(0.1)
                        weapon.Parent = oldParent
                    end
                end
            end
            
  
            _G.SelfRescueLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if not SelfRescueActive then return end
                
                local weapon = GetMeleeWeapon()
                if weapon then
       
                    local zombies = workspace:FindFirstChild("Zombies")
                    if zombies then
                        for _, zombie in pairs(zombies:GetChildren()) do
                            pcall(function()
               
                                if zombie:GetAttribute("Type") ~= "Barrel" and 
                                   zombie:FindFirstChild("HumanoidRootPart") then
                                    AttackTarget(weapon, zombie)
                                    task.wait(0.1) 
                                end
                            end)
                        end
                    end
                end
            end)
            
           
        else
     
            if _G.SelfRescueLoop then
                _G.SelfRescueLoop:Disconnect()
                _G.SelfRescueLoop = nil
            end
           
        end
    end
})

LegitGroup:AddToggle('NoFallDamage', {
    Text = '防断腿',
    Default = false,
    Tooltip = '防止断腿',
    Callback = function(state)
        _G.NoFallDamageEnabled = state
        if state then
            if not _G.BrokenLegsHook then
                local rs = game:GetService("ReplicatedStorage")
                local BrokenLegs = require(rs.Modules.Gameplay.CharacterStates.BrokenLegs)
                _G.OriginalEntered = _G.OriginalEntered or BrokenLegs.Entered
                _G.BrokenLegsHook = hookfunction(BrokenLegs.Entered, function(self, ...)
                    if _G.NoFallDamageEnabled then
                        self.RestrictsBackpack = false
                        self.RestrictsAutoRotate = false
                        self.KillsVelocity = false
                        return
                    end
                    return _G.OriginalEntered(self, ...)
                end)   
            end
        else
            if _G.BrokenLegsHook and _G.OriginalEntered then
                local rs = game:GetService("ReplicatedStorage")
                local BrokenLegs = require(rs.Modules.Gameplay.CharacterStates.BrokenLegs)
                BrokenLegs.Entered = _G.OriginalEntered
                _G.BrokenLegsHook = nil
            end
        end
    end
})

local AMOUNT = 40
local BASE_DISTANCE = 7
local HEIGHT = 1
local SIZE = Vector3.new(0.3, 0.3, 0.3)

local BEAT_FORCE = 0.012
local SMOOTHING = 0.35

local COLOR_SPEED = 0.15
local PASTEL_SATURATION = 0.35
local PASTEL_BRIGHTNESS = 1

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local character
local root

local diamonds = {}
local currentDistance = BASE_DISTANCE
local colorTime = 0
local Enabled = false
local Connection = nil

-- 创建钻石
local function CreateDiamonds()
  for i = 1, AMOUNT do
      if diamonds[i] and diamonds[i].part then continue end
      
      local part = Instance.new("Part")
      part.Size = SIZE
      part.Anchored = true
      part.CanCollide = false
      part.Material = Enum.Material.Neon
      part.Parent = workspace

      diamonds[i] = {
          part = part,
          angle = (math.pi * 2 / AMOUNT) * i,
          colorOffset = i / AMOUNT
      }
  end
end

-- 销毁钻石
local function DestroyDiamonds()
  for _, data in ipairs(diamonds) do
      if data.part then
          data.part:Destroy()
      end
  end
  table.clear(diamonds)
end

local function setCharacter(char)
  character = char
  root = character:WaitForChild("HumanoidRootPart")
end

if player.Character then
  setCharacter(player.Character)
end

player.CharacterAdded:Connect(setCharacter)

local function getLoudness()
  local loudness = 0

  for _, obj in ipairs(workspace:GetDescendants()) do
      if obj:IsA("Sound") and obj.IsPlaying and obj.Volume > 0 then
          loudness = math.max(loudness, obj.PlaybackLoudness)
      end
  end

  for _, obj in ipairs(SoundService:GetDescendants()) do
      if obj:IsA("Sound") and obj.IsPlaying and obj.Volume > 0 then
          loudness = math.max(loudness, obj.PlaybackLoudness)
      end
  end

  return loudness
end

local function Start()
  if Connection then return end
  
  CreateDiamonds()
  
  Connection = RunService.RenderStepped:Connect(function(dt)
      if not root then return end

      local loudness = getLoudness()
      colorTime += dt * COLOR_SPEED

      local target = BASE_DISTANCE - (loudness * BEAT_FORCE)
      target = math.clamp(target, BASE_DISTANCE - 2, BASE_DISTANCE)

      currentDistance += (target - currentDistance) * SMOOTHING

      for _, data in ipairs(diamonds) do
          local x = math.cos(data.angle) * currentDistance
          local z = math.sin(data.angle) * currentDistance

          local hue = (colorTime + data.colorOffset) % 1
          data.part.Color = Color3.fromHSV(hue, PASTEL_SATURATION, PASTEL_BRIGHTNESS)

          data.part.CFrame =
              CFrame.new(root.Position + Vector3.new(x, HEIGHT, z))
              * CFrame.Angles(math.rad(45), math.rad(45), 0)
      end
  end)
end

local function Stop()
  if Connection then
      Connection:Disconnect()
      Connection = nil
  end
  DestroyDiamonds()
  colorTime = 0
  currentDistance = BASE_DISTANCE
end

LegitGroup:AddToggle("MusicDiamonds", {
  Text = "音乐环绕",
  Default = false,
  Tooltip = "根据音乐节奏显示环绕",
  Callback = function(v)
      Enabled = v
      if v then
          Start()
      else
          Stop()
      end
  end,
})

LegitGroup:AddButton({
    Text = "防坠落",
    Func = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")

        local CONFIG = {
            Debug = false,
            PreventStrings = {
                States = {"LightLandStun", "LandHardStun", "Stumble"},
                Modifiers = {"FallenStumble", "LightStumble"},
                Instances = {"LightStumble"}
            }
        }

        local function SafeString(value)
            if typeof(value) == "string" then
                return value
            elseif typeof(value) == "EnumItem" then
                return tostring(value)
            elseif typeof(value) == "number" then
                return tostring(value)
            else
                return nil 
            end
        end

        local function ContainsAny(str, keywords)
            local safeStr = SafeString(str)
            if not safeStr then return false end
            
            for _, keyword in ipairs(keywords) do
                if safeStr:find(keyword, 1, true) then
                    return true
                end
            end
            return false
        end

        local OldNamecall
        OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local Method = getnamecallmethod()
            local Args = {...}
            
            if Method == "FireServer" and typeof(self) == "Instance" and self.Name == "ForceSelfDamage" then
                return nil
            end
            
            if Method == "AddState" and typeof(self) == "Instance" then
                local stateArg = Args[1]
                if typeof(stateArg) == "string" then
                    if ContainsAny(stateArg, CONFIG.PreventStrings.States) then
                        return nil
                    end
                end
            end
            
            if Method == "AddModifier" then
                local modArg = Args[1]
                if typeof(modArg) == "string" then
                    if ContainsAny(modArg, CONFIG.PreventStrings.Modifiers) then
                        return nil
                    end
                end
            end

            if Method == "SetStateEnabled" and typeof(self) == "Instance" and self:IsA("Humanoid") then
                local stateArg = Args[1]
                local enabledArg = Args[2]
        
                if typeof(stateArg) == "EnumItem" then
                    if stateArg == Enum.HumanoidStateType.FallingDown or 
                       stateArg == Enum.HumanoidStateType.Ragdoll or
                       stateArg == Enum.HumanoidStateType.Freefall then
                        return OldNamecall(self, stateArg, false)
                    end
                end
            end
            
            return OldNamecall(self, ...)
        end))

        local OldInstanceNew = hookfunction(Instance.new, function(className, parent, ...)
            local obj = OldInstanceNew(className, parent, ...)
            
            if className == "NumberValue" and typeof(parent) == "Instance" then
                task.defer(function()
                    if obj and obj.Parent and typeof(obj.Name) == "string" then
                        if obj.Name == "LightStumble" then
                            obj:Destroy()
                        end
                    end
                end)
            end
            
            return obj
        end)

        RunService.PreRender:Connect(function()
            local success, err = pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                
                local currentState = hum:GetState()
                if currentState == Enum.HumanoidStateType.Freefall then
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
                
                local userStates = char:FindFirstChild("UserStates")
                if userStates then
                    local speedFolder = userStates:FindFirstChild("SpeedModifiers")
                    if speedFolder then
                        for _, child in ipairs(speedFolder:GetChildren()) do
                            if typeof(child.Name) == "string" then
                                if child.Name == "LightStumble" or 
                                   child.Name:find("Stumble") or 
                                   child.Name:find("Fall") then
                                    child:Destroy()
                                end
                            end
                        end
                    end
                end
                
                local plat = char:FindFirstChild("Anti-fling/LocalPlat")
                if plat then
                    plat.Disabled = true
                    plat:Destroy()
                end
            end)
        end)
    end
})

local HitboxGroup = Tabs.w:AddRightGroupbox("命中框", "box")

local hitboxEnabled = false
local hitboxSize = 10
local MaxRange = 30
local zombieFolder = Workspace:WaitForChild("Zombies")

local function inRange(zombie)
    local hrp = zombie:FindFirstChild("HumanoidRootPart")
    local myHrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not (hrp and myHrp) then return false end
    return (hrp.Position - myHrp.Position).Magnitude <= MaxRange
end

local function createHitbox(zombie, partName, attachPart, size)
    if zombie:FindFirstChild(partName) then return end
    local part = Instance.new("Part")
    part.Name = partName
    part.Size = size
    part.Transparency = 1
    part.CanCollide = false
    part.Massless = true
    part.Parent = zombie

    part.CFrame = attachPart.CFrame

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = attachPart
    weld.Part1 = part
    weld.Parent = part
end

local function updateZombie(zombie)
    if not zombie or not zombie.Parent then return end
    local hrp = zombie:FindFirstChild("HumanoidRootPart")
    local head = zombie:FindFirstChild("Head")
    if not (hrp and head) then return end

    if hitboxEnabled and inRange(zombie) then
        createHitbox(zombie, "OuterHitbox", hrp, Vector3.new(hitboxSize, hitboxSize, hitboxSize))
        createHitbox(zombie, "HeadHitbox", head, Vector3.new(hitboxSize/2, hitboxSize/2, hitboxSize/2))
    else
        local o = zombie:FindFirstChild("OuterHitbox")
        local h = zombie:FindFirstChild("HeadHitbox")
        if o then o:Destroy() end
        if h then h:Destroy() end
    end
end

RunService.Heartbeat:Connect(function()
    if not hitboxEnabled then return end
    for _, zombie in ipairs(zombieFolder:GetChildren()) do
        updateZombie(zombie)
    end
end)

zombieFolder.ChildAdded:Connect(function(zombie)
    task.wait(0.2)
    updateZombie(zombie)
end)

HitboxGroup:AddToggle("HitboxExpander", {
    Text = "命中框扩展",
    Default = false,
    Callback = function(v)
        hitboxEnabled = v
    end
})

HitboxGroup:AddSlider("HitboxSize", {
    Text = "命中框大小",
    Default = 10,
    Min = 1,
    Max = 30,
    Callback = function(v)
        hitboxSize = v
    end
})

HitboxGroup:AddSlider("HitboxRange", {
    Text = "命中框范围",
    Default = 30,
    Min = 5,
    Max = 100,
    Callback = function(v)
        MaxRange = v
    end
})

do
    local LOOK_DURATION = 0.28
    local MAX_TARGET_RANGE = 200
    local FIRE_DELAY_AFTER_LOOK = 0.03
    local BOMBER_CHECK_INTERVAL = 0.1
    local BOMBER_APPEAR_DELAY = 0.5
    local EPS = 1e-4
    local CHECK_WALLS = true
    local AUTO_RELOAD_ENABLED = false
    local USER_AUTO_SHOOT_TOGGLE = false  
    local USER_AUTO_SHOOT_CAVALRY_TOGGLE = false  
    local USER_AUTO_SHOOT_RUNNER_TOGGLE = false  
    local USER_AUTO_SHOOT_ELECTROCUTIONER_TOGGLE = false  
    local USER_AUTO_SHOOT_IGNITER_TOGGLE = false  

    local lastReloadNotify = 0
    local NOTIFY_COOLDOWN = 4

    local function notifyReload()
        local now = tick()
        if now - lastReloadNotify < NOTIFY_COOLDOWN then return end
        lastReloadNotify = now
        Library:Notify({
            Title = "自动装填",
            Description = "已装填一发子弹。",
            Time = 3,
        })
    end

    local function isGun(tool)
        if not tool or not tool:IsA("Tool") then return false end
        local animFolder = tool:FindFirstChild("Animations")
        if not animFolder then return false end
        if animFolder:FindFirstChild("Aim") then return true end
        if animFolder:FindFirstChild("Aiming") then return true end
        return false
    end

    local function getTargetPartForModel(model)
        if not model or not model:IsA("Model") then return nil end
        local head = model:FindFirstChild("Head")
        if head and head:IsA("BasePart") then return head end
        local barrel = model:FindFirstChild("Barrel")
        if barrel and barrel:IsA("BasePart") then return barrel end
        local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("HumanoidRootPart")
        if torso and torso:IsA("BasePart") then return torso end
        return nil
    end

    local function isObstructedBetween(origin, targetPos, targetModel)
        if not CHECK_WALLS then return false end
        if not origin or not targetPos then return false end
        local dir = targetPos - origin
        local dist = dir.Magnitude
        if dist <= 0 then return false end
        
        local function buildBaseIgnoreList()
            local ignoreList = {}
            local camFolder = Workspace:FindFirstChild("Camera")
            if camFolder then
                for _, desc in ipairs(camFolder:GetDescendants()) do
                    if desc and desc:IsA("Model") and desc.Name == "m_Zombie" then
                        table.insert(ignoreList, desc)
                    end
                end
            end
            local zombiesFolder = Workspace:FindFirstChild("Zombies")
            if zombiesFolder then table.insert(ignoreList, zombiesFolder) end
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl and pl.Character and pl.Character:IsA("Model") then
                    table.insert(ignoreList, pl.Character)
                end
            end
            if targetModel then table.insert(ignoreList, targetModel) end
            return ignoreList
        end
        
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = buildBaseIgnoreList()
        
        local maxIterations = 12
        local remainingDistance = dist
        local originPos = origin
        local dirUnit = dir.Unit
        local epsilon = 0.2
        
        for i = 1, maxIterations do
            local ok, result = pcall(function()
                return Workspace:Raycast(originPos, dirUnit * remainingDistance, params)
            end)
            if not ok or not result then return false end
            local hitInst = result.Instance
            if not hitInst then return false end
            if targetModel and hitInst:IsDescendantOf(targetModel) then return false end
            local isBasePart = hitInst:IsA("BasePart")
            local canCollide = isBasePart and hitInst.CanCollide
            local transparency = isBasePart and hitInst.Transparency or 0
            local isEffectivelyInvisible = (isBasePart and transparency >= 0.95)
            
            if (not canCollide) or isEffectivelyInvisible then
                local advancePos = result.Position + dirUnit * epsilon
                local passed = (advancePos - origin).Magnitude
                if passed >= dist - EPS then return false end
                originPos = advancePos
                remainingDistance = (targetPos - originPos).Magnitude
                local newFilter = params.FilterDescendantsInstances
                table.insert(newFilter, hitInst)
                params.FilterDescendantsInstances = newFilter
            else
                return true
            end
        end
        return true
    end

    local ZombieTypeMatchers = {
        Bomber = function(model) 
            return model:FindFirstChild("Barrel") ~= nil 
        end,
        Cuirassier = function(model) 
            return model:FindFirstChild("Sword") ~= nil 
        end,
        Runner = function(model) 
            return model:FindFirstChild("Eye") and not model:FindFirstChild("Axe") and model:FindFirstChild("Head")
        end,
        Electrocutioner = function(model) 
            return model:FindFirstChild("Axe") and model:FindFirstChild("Head")
        end,
        Igniter = function(model) 
            return model:FindFirstChild("Whale Oil Lantern") ~= nil
        end,
    }

    local function getNearestTargetHeadByMatcher(range, matcherFunc)
        local camFolder = Workspace:FindFirstChild("Camera")
        local cam = Workspace.CurrentCamera
        local originPos = nil
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character.Parent then
            local head = LocalPlayer.Character:FindFirstChild("Head")
            if head and head:IsA("BasePart") then originPos = head.Position end
        end
        if not originPos and cam then originPos = cam.CFrame.Position end
        if not originPos then return nil, nil end
        
        local bestPart, bestDist, bestModel = nil, range + EPS, nil
        if not camFolder then return nil, nil end
        
        for _, model in ipairs(camFolder:GetChildren()) do
            if model:IsA("Model") and model.Name == "m_Zombie" then
       
                if not matcherFunc(model) then continue end
                
                local head = model:FindFirstChild("Head")
                local barrel = model:FindFirstChild("Barrel")
                local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("HumanoidRootPart")
                local measurePart = barrel or head or torso
                
                if measurePart and measurePart:IsA("BasePart") then
                    local okDist, d = pcall(function() return (measurePart.Position - originPos).Magnitude end)
                    if okDist and d and d <= range + EPS and d < bestDist then
                        local barrelVisible, headVisible, torsoVisible = false, false, false
                        
                        if barrel and barrel:IsA("BasePart") then
                            local okVis, res = pcall(function() return not isObstructedBetween(originPos, barrel.Position, model) end)
                            if okVis and res then barrelVisible = true end
                        end
                        if head and head:IsA("BasePart") then
                            local okVis, res = pcall(function() return not isObstructedBetween(originPos, head.Position, model) end)
                            if okVis and res then headVisible = true end
                        end
                        if torso and torso:IsA("BasePart") then
                            local okVis, res = pcall(function() return not isObstructedBetween(originPos, torso.Position, model) end)
                            if okVis and res then torsoVisible = true end
                        end
                        
                        local chosenPart = nil
                        if barrelVisible then chosenPart = barrel
                        elseif headVisible then chosenPart = head
                        elseif torsoVisible then chosenPart = torso end
                        
                        if chosenPart and chosenPart:IsA("BasePart") then
                            bestPart, bestDist, bestModel = chosenPart, d, model
                        end
                    end
                end
            end
        end
        return bestPart, bestModel
    end

    local function getShotsLoadedForTool(tool)
        if not tool then return 0 end
        local s = tool:FindFirstChild("ShotsLoaded")
        if s and (s:IsA("IntValue") or s:IsA("NumberValue")) then return s.Value end
        local wsPlayersFolder = Workspace:FindFirstChild("Players")
        if not wsPlayersFolder then return 0 end
        local playerFolder = wsPlayersFolder:FindFirstChild(LocalPlayer.Name)
        if not playerFolder then return 0 end
        local toolFolder = playerFolder:FindFirstChild(tool.Name)
        if not toolFolder then return 0 end
        local shots = toolFolder:FindFirstChild("ShotsLoaded")
        if shots and (shots:IsA("IntValue") or shots:IsA("NumberValue")) then return shots.Value end
        return 0
    end

    local function findRemoteForTool(tool)
        if not tool then return nil end
        local remote = tool:FindFirstChild("RemoteEvent")
        if remote then return remote end
        local wsPlayersFolder = Workspace:FindFirstChild("Players")
        if not wsPlayersFolder then return nil end
        local playerFolder = wsPlayersFolder:FindFirstChild(LocalPlayer.Name)
        if not playerFolder then return nil end
        local toolFolder = playerFolder:FindFirstChild(tool.Name)
        if not toolFolder then return nil end
        return toolFolder:FindFirstChild("RemoteEvent")
    end

    
    local function tryReloadTool(tool)
        if not tool then return end
        if not AUTO_RELOAD_ENABLED then return end
        if not isGun(tool) then return end
        local shots = getShotsLoadedForTool(tool)
        if shots and shots == 0 then
            local remote = findRemoteForTool(tool)
            if remote then
                pcall(function() remote:FireServer("Reload") end)
            end
        end
    end

    local function watchShotsForTool(tool)
        if not tool then return end
        if not isGun(tool) then return end
        
        local function attach(shotsObj, reloadRemote)
            if not shotsObj then return end
            local prevVal = shotsObj.Value or 0
            if AUTO_RELOAD_ENABLED and prevVal == 0 and reloadRemote then
                pcall(function() reloadRemote:FireServer("Reload") end)
            end
            
            local reloadDebounce = false
            local conn = shotsObj.Changed:Connect(function()
                local v = shotsObj.Value
                if AUTO_RELOAD_ENABLED and type(v) == "number" and type(prevVal) == "number" and v > prevVal then
                    for i = prevVal + 1, v do task.spawn(function() notifyReload() end) end
                end
                if AUTO_RELOAD_ENABLED and v == 0 and reloadRemote and not reloadDebounce then
                    reloadDebounce = true
                    pcall(function() reloadRemote:FireServer("Reload") end)
                    task.delay(1.2, function() reloadDebounce = false end)
                end
                prevVal = v
            end)
            
            tool.AncestryChanged:Connect(function(_, parent)
                if not parent and conn then conn:Disconnect() end
            end)
        end
        
        local shotsInst = tool:FindFirstChild("ShotsLoaded")
        local remoteInst = tool:FindFirstChild("RemoteEvent")
        if shotsInst and (shotsInst:IsA("IntValue") or shotsInst:IsA("NumberValue")) then
            attach(shotsInst, remoteInst)
            return
        end
        
        local wsPlayersFolder = Workspace:FindFirstChild("Players")
        if not wsPlayersFolder then return end
        local playerFolder = wsPlayersFolder:FindFirstChild(LocalPlayer.Name)
        if not playerFolder then return end
        local toolFolder = playerFolder:FindFirstChild(tool.Name)
        if not toolFolder then return end
        local shots = toolFolder:FindFirstChild("ShotsLoaded")
        local serverRemote = toolFolder:FindFirstChild("RemoteEvent") or remoteInst
        if shots and (shots:IsA("IntValue") or shots:IsA("NumberValue")) then
            attach(shots, serverRemote)
        end
    end

    local function smoothLookAtDynamic(rootPart, getPosFunc, duration)
        if not rootPart or not getPosFunc then return end
        local start = tick()
        local startCFrame = rootPart.CFrame
        local ok, initTarget = pcall(getPosFunc)
        if not ok or not initTarget then return end
        
        while tick() - start < duration do
            if not rootPart.Parent then return end
            local curPos = nil
            pcall(function() curPos = getPosFunc() end)
            if not curPos then curPos = initTarget end
            local desired = CFrame.new(rootPart.Position, Vector3.new(curPos.X, rootPart.Position.Y, curPos.Z))
            local t = math.clamp((tick() - start) / duration, 0, 1)
            local smoothT = t * t * (3 - 2 * t)
            local lerped = startCFrame:Lerp(desired, smoothT)
            local safeCFrame = CFrame.new(rootPart.Position, rootPart.Position + lerped.LookVector)
            pcall(function() rootPart.CFrame = safeCFrame end)
            RunService.RenderStepped:Wait()
        end
        
        local finalPos = nil
        pcall(function() finalPos = getPosFunc() end)
        if finalPos then
            pcall(function() rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + CFrame.new(rootPart.Position, Vector3.new(finalPos.X, rootPart.Position.Y, finalPos.Z)).LookVector) end)
        end
    end

    local function playAnimation(animId, animator)
        if not animId or not animator then return nil end
        local ok, track = pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            return animator:LoadAnimation(anim)
        end)
        if not ok or not track then return nil end
        track.Priority = Enum.AnimationPriority.Action
        track:Play(0.05, 1, 1)
        return track
    end

    local function aimThenShootGun(targetModel, initialPart, tool)
        if not targetModel or not targetModel.Parent then return end
        if not initialPart or not initialPart.Parent or not initialPart:IsA("BasePart") then return end
        if not tool or not tool.Parent or not tool:IsDescendantOf(LocalPlayer.Character) then return end
        if not isGun(tool) then return end
        
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        
        pcall(function() watchShotsForTool(tool) end)
        local remote = tool:FindFirstChild("RemoteEvent") or nil
        
        local animFolder = tool:FindFirstChild("Animations")
        local animAId, animBId
        if animFolder then
            local aim = animFolder:FindFirstChild("Aim")
            local aiming = animFolder:FindFirstChild("Aiming")
            if aim and aim:IsA("Animation") then animAId = aim.AnimationId end
            if aiming and aiming:IsA("Animation") then animBId = aiming.AnimationId end
        end
        animAId = animAId or "rbxassetid://83511222574103"
        animBId = animBId or "rbxassetid://136849639865723"
        
        local fireAnimId = nil
        if animFolder then
            local fire = animFolder:FindFirstChild("Fire")
            if fire and fire:IsA("Animation") then fireAnimId = fire.AnimationId end
        end
        
        local trackA = playAnimation(animAId, animator)
        if trackA then
            task.wait(math.min(trackA.Length or 0.6, 0.6))
            pcall(function() trackA:Stop(0.05) end)
        end
        
        local trackB = playAnimation(animBId, animator)
        task.wait(0.02)
        
        local function getAimOrigin()
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character.Parent then
                local head = LocalPlayer.Character:FindFirstChild("Head")
                if head and head:IsA("BasePart") then return head.Position end
            end
            local cam = Workspace.CurrentCamera
            if cam then return cam.CFrame.Position end
            return nil
        end
        
        local currentTargetPart = initialPart
        
        local function isPartVisible(part)
            if not part or not part.Parent or not part:IsA("BasePart") then return false end
            local origin = getAimOrigin()
            if not origin then return false end
            local ok, res = pcall(function() return not isObstructedBetween(origin, part.Position, targetModel) end)
            return ok and res
        end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and targetModel and targetModel.Parent then
            local function getPosFunc()
                if not currentTargetPart or not currentTargetPart.Parent then
                    local barrel = targetModel:FindFirstChild("Barrel")
                    local head = targetModel:FindFirstChild("Head")
                    local torso = targetModel:FindFirstChild("Torso") or targetModel:FindFirstChild("UpperTorso") or targetModel:FindFirstChild("HumanoidRootPart")
                    if barrel and isPartVisible(barrel) then currentTargetPart = barrel return barrel.Position end
                    if head and isPartVisible(head) then currentTargetPart = head return head.Position end
                    if torso and isPartVisible(torso) then currentTargetPart = torso return torso.Position end
                    return nil
                end
                if currentTargetPart and currentTargetPart.Parent then return currentTargetPart.Position end
                return nil
            end
            pcall(function() smoothLookAtDynamic(root, getPosFunc, LOOK_DURATION) end)
        else
            if trackB then pcall(function() trackB:Stop(0.1) end) end
            return
        end
        
        local WAIT_TIMEOUT = 3.0
        local waited = 0
        local POLL_INTERVAL = 0.05
        local shotsNow = getShotsLoadedForTool(tool)
        
        while (not shotsNow or shotsNow < 1) and waited < WAIT_TIMEOUT do
            if not tool or not tool.Parent or not tool:IsDescendantOf(LocalPlayer.Character) then
                if trackB then pcall(function() trackB:Stop(0.1) end) end
                return
            end
            if not (USER_AUTO_SHOOT_TOGGLE or USER_AUTO_SHOOT_CAVALRY_TOGGLE or USER_AUTO_SHOOT_RUNNER_TOGGLE or USER_AUTO_SHOOT_ELECTROCUTIONER_TOGGLE or USER_AUTO_SHOOT_IGNITER_TOGGLE) then
                if trackB then pcall(function() trackB:Stop(0.1) end) end
                return
            end
            
            if currentTargetPart and (not isPartVisible(currentTargetPart)) then
                local barrel = targetModel:FindFirstChild("Barrel")
                local head = targetModel:FindFirstChild("Head")
                local torso = targetModel:FindFirstChild("Torso") or targetModel:FindFirstChild("UpperTorso") or targetModel:FindFirstChild("HumanoidRootPart")
                local switched = false
                if barrel and barrel ~= currentTargetPart and isPartVisible(barrel) then currentTargetPart = barrel switched = true
                elseif head and head ~= currentTargetPart and isPartVisible(head) then currentTargetPart = head switched = true
                elseif torso and torso ~= currentTargetPart and isPartVisible(torso) then currentTargetPart = torso switched = true end
                if not switched then
                    if trackB then pcall(function() trackB:Stop(0.1) end) end
                    return
                end
            end
            task.wait(POLL_INTERVAL)
            waited = waited + POLL_INTERVAL
            shotsNow = getShotsLoadedForTool(tool)
        end
        
        if not shotsNow or shotsNow < 1 then
            if trackB then pcall(function() trackB:Stop(0.1) end) end
            return
        end
        
        task.wait(FIRE_DELAY_AFTER_LOOK)
        
        if not currentTargetPart or not currentTargetPart.Parent or (not isPartVisible(currentTargetPart)) then
            local barrel = targetModel:FindFirstChild("Barrel")
            local head = targetModel:FindFirstChild("Head")
            local torso = targetModel:FindFirstChild("Torso") or targetModel:FindFirstChild("UpperTorso") or targetModel:FindFirstChild("HumanoidRootPart")
            if barrel and isPartVisible(barrel) then currentTargetPart = barrel
            elseif head and isPartVisible(head) then currentTargetPart = head
            elseif torso and isPartVisible(torso) then currentTargetPart = torso
            else
                if trackB then pcall(function() trackB:Stop(0.1) end) end
                return
            end
        end
        
        local fireTrack = nil
        if fireAnimId then
            pcall(function() fireTrack = playAnimation(fireAnimId, animator) end)
        end
        
        pcall(function()
            local modelRef = char:FindFirstChild("Model") or char
            local t = Workspace:GetServerTimeNow()
            remote = remote or tool:FindFirstChild("RemoteEvent")
            if remote and currentTargetPart and currentTargetPart.Parent then
                remote:FireServer("Fire", modelRef, currentTargetPart.Position, t)
            end
        end)
        
        if fireTrack then
            task.delay(0.35, function() pcall(function() fireTrack:Stop(0.07) end) end)
        end
        
        if trackB then
            task.wait(0.05)
            pcall(function() trackB:Stop(0.1) end)
        end
    end

    local function processAutoShootForType(isEnabled, matcherFunc, checkInterval)
        if not isEnabled then return end
        
        local equippedTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        local equippedIsGun = equippedTool and isGun(equippedTool)
        local shotsForEquipped = (equippedTool and equippedIsGun) and getShotsLoadedForTool(equippedTool) or 0
        local effectiveAutoShoot = isEnabled and (equippedTool ~= nil) and equippedIsGun and (shotsForEquipped >= 1)
        
        if effectiveAutoShoot then
            local part, model = getNearestTargetHeadByMatcher(MAX_TARGET_RANGE, matcherFunc)
            if part and model then
                task.wait(BOMBER_APPEAR_DELAY)
                if equippedTool and equippedTool.Parent and model and model.Parent and isGun(equippedTool) then
                    local currentTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if currentTool and currentTool == equippedTool then
                        aimThenShootGun(model, part, currentTool)
                    end
                end
            end
        end
    end
    local isAiming = false
    task.spawn(function()
        while true do
            if not isAiming then
                isAiming = true
                
                if USER_AUTO_SHOOT_TOGGLE then
                    processAutoShootForType(USER_AUTO_SHOOT_TOGGLE, ZombieTypeMatchers.Bomber, "Barrel", BOMBER_CHECK_INTERVAL)
                end
                
                if USER_AUTO_SHOOT_CAVALRY_TOGGLE then
                    processAutoShootForType(USER_AUTO_SHOOT_CAVALRY_TOGGLE, ZombieTypeMatchers.Cuirassier, "Head", BOMBER_CHECK_INTERVAL)
                end
                
                
                if USER_AUTO_SHOOT_RUNNER_TOGGLE then
                    processAutoShootForType(USER_AUTO_SHOOT_RUNNER_TOGGLE, ZombieTypeMatchers.Runner, "Head", BOMBER_CHECK_INTERVAL)
                end
                
               
                if USER_AUTO_SHOOT_ELECTROCUTIONER_TOGGLE then
                    processAutoShootForType(USER_AUTO_SHOOT_ELECTROCUTIONER_TOGGLE, ZombieTypeMatchers.Electrocutioner, "Head", BOMBER_CHECK_INTERVAL)
                end

                if USER_AUTO_SHOOT_IGNITER_TOGGLE then
                    processAutoShootForType(USER_AUTO_SHOOT_IGNITER_TOGGLE, ZombieTypeMatchers.Igniter, "Head", BOMBER_CHECK_INTERVAL)
                end
                
                task.wait(0.05)
                isAiming = false
            end
            task.wait(BOMBER_CHECK_INTERVAL)
        end
    end)

    local function monitorCharacterTools(char)
        if not char then return end
        for _, c in ipairs(char:GetChildren()) do
            if c:IsA("Tool") and isGun(c) then
                pcall(function() watchShotsForTool(c) end)
                pcall(function() tryReloadTool(c) end)
            end
        end
        char.ChildAdded:Connect(function(child)
            if child and child:IsA("Tool") and isGun(child) then
                pcall(function() watchShotsForTool(child) end)
                pcall(function() tryReloadTool(child) end)
            end
        end)
    end
    LocalPlayer.CharacterAdded:Connect(monitorCharacterTools)
    if LocalPlayer.Character then monitorCharacterTools(LocalPlayer.Character) end

    local GunModSection = Tabs.w:AddLeftGroupbox("枪械模组", "zap")
    local ShootingSection = Tabs.w:AddRightGroupbox("射击", "target")

    ShootingSection:AddToggle("AutoShoot", {
        Text = "自动射击炸弹僵尸",
        Default = false,
        Tooltip = "射击炸弹僵尸 ",
        Callback = function(state)
            USER_AUTO_SHOOT_TOGGLE = state
        end,
    })

    ShootingSection:AddToggle("AutoShootCavalry", {
        Text = "自动射击胸甲骑兵",
        Default = false,
        Tooltip = "自动瞄准并射击胸甲骑兵",
        Callback = function(state)
            USER_AUTO_SHOOT_CAVALRY_TOGGLE = state
        end,
    })

    ShootingSection:AddToggle("AutoShootRunner", {
        Text = "自动射击奔跑者",
        Default = false,
        Tooltip = "自动瞄准并射击奔跑者",
        Callback = function(state)
            USER_AUTO_SHOOT_RUNNER_TOGGLE = state
        end,
    })

    ShootingSection:AddToggle("AutoShootElectrocutioner", {
        Text = "自动射击斧头者",
        Default = false,
        Tooltip = "自动瞄准并射击斧头者",
        Callback = function(state)
            USER_AUTO_SHOOT_ELECTROCUTIONER_TOGGLE = state
        end,
    })

    ShootingSection:AddToggle("AutoShootIgniter", {
        Text = "自动射击点燃者",
        Default = false,
        Tooltip = "自动瞄准并射击点燃者",
        Callback = function(state)
            USER_AUTO_SHOOT_IGNITER_TOGGLE = state
        end,
    })

    ShootingSection:AddSlider("MaxTargetRange", {
        Text = "最大目标范围",
        Desc = "最大检测范围。",
        Default = 200,
        Min = 50,
        Max = 600,
        Rounding = 0,
        Callback = function(val) MAX_TARGET_RANGE = val end,
    })

    ShootingSection:AddToggle("WallCheck", {
        Text = "墙壁检查 (射线检测)",
        Desc = "墙后的目标将被忽略。",
        Default = true,
        Callback = function(state) CHECK_WALLS = state end,
    })

    GunModSection:AddToggle("AutoReload", {
        Text = "自动装填",
        Desc = "自动装填, 与自动射击配合良好。",
        Default = false,
        Callback = function(state)
            AUTO_RELOAD_ENABLED = state
            Library:Notify({
                Title = "自动装填",
                Description = state and "自动装填已启用",
                Time = 2,
            })
        end,
    })
end
end
do
    local ESPSection = Tabs.e:AddLeftGroupbox("透视与僵尸警报", "eye")
    
    local RunService = RunService or game:GetService("RunService")
    local CameraFolder = workspace:FindFirstChild("Camera")
    local IdentifiedIgniters = {}
    
    local ESPConfigs = {
        Bomber = {
            color = Color3.fromRGB(255, 180, 60),
            label = "自爆僵尸",
            match = function(model)
                if not model or not model:IsA("Model") then return false end
                return model:FindFirstChild("Barrel", true) ~= nil
            end,
        },
        Cuirassier = {
            color = Color3.fromRGB(0, 200, 255),
            label = "胸甲骑兵",
            match = function(model)
                return model:FindFirstChild("Sword", true) ~= nil
            end,
        },
        Runner = {
            color = Color3.fromRGB(255, 0, 0),
            label = "红眼",
            match = function(model)
                return model:FindFirstChild("Eye") and not model:FindFirstChild("Axe") and model:FindFirstChild("Head")
            end,
        },
        Zapper = {
            color = Color3.fromRGB(0, 255, 0),
            label = "斧头",
            match = function(model)
                return model:FindFirstChild("Axe") and model:FindFirstChild("Head")
            end,
        },
        Igniter = {
            color = Color3.fromRGB(255, 255, 0),
            label = "提灯人",
            match = function(model)
                if not model or not model:IsA("Model") then return false end
                if model:FindFirstChild("Whale Oil Lantern") then
                    IdentifiedIgniters[model] = true
                    return true
                end
                return IdentifiedIgniters[model] or false
            end,
        },
    }
    
    local ESPData = { Bomber = {}, Cuirassier = {}, Runner = {}, Zapper = {}, Igniter = {} }
    local EnabledESPs = { Bomber = false, Cuirassier = false, Runner = false, Zapper = false, Igniter = false }
    local ShowBillboards = false
    local ChamsTransparency = 0.6
    local PerformanceMode = false
    
    local activeCount = 0
    local scanLoop, renderConn
    
    local function GetAdorneePart(model)
        if not model or not model:IsA("Model") then return nil end
        local head = model:FindFirstChild("Head", true)
        if head and head:IsA("BasePart") then return head end
        local hrp = model:FindFirstChild("HumanoidRootPart", true)
        if hrp and hrp:IsA("BasePart") then return hrp end
        if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then return model.PrimaryPart end
        local children = model:GetChildren()
        local possible = children[12]
        if possible and possible:IsA("BasePart") then return possible end
        for _, p in ipairs(model:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "Whale Oil Lantern" then return p end
        end
        return nil
    end
    
    local function CreateVisual(espType, zombie)
        if not zombie or not zombie:IsA("Model") or ESPData[espType][zombie] then return end
        local config = ESPConfigs[espType]
        local headPart = GetAdorneePart(zombie)
        if not headPart then return end
        
        local data = {}
        ESPData[espType][zombie] = data
        local offset = Vector3.new(0, 3, 0)
        
        if not PerformanceMode then
            local hl = Instance.new("Highlight")
            hl.Name = espType .. "Highlight"
            hl.Adornee = zombie
            hl.FillColor = config.color
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = ChamsTransparency
            hl.OutlineTransparency = 0
            hl.Parent = zombie
            data.highlight = hl
            
            local bb = Instance.new("BillboardGui")
            bb.Name = espType .. "Billboard"
            bb.Adornee = headPart
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.StudsOffset = offset
            bb.MaxDistance = 1000
            bb.Enabled = ShowBillboards
            bb.Parent = zombie
            data.billboard = bb
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BackgroundTransparency = 0.7
            frame.BorderSizePixel = 1
            frame.BorderColor3 = config.color
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            frame.Parent = bb
            data.frame = frame
            
            local lbl = Instance.new("TextLabel")
            lbl.AnchorPoint = Vector2.new(0.5, 0)
            lbl.Position = UDim2.new(0.5, 0, 0.1, 0)
            lbl.Size = UDim2.new(0.9, 0, 0.5, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = config.label
            lbl.TextColor3 = config.color
            lbl.TextStrokeTransparency = 0.8
            lbl.TextScaled = true
            lbl.Font = Enum.Font.GothamBold
            lbl.Parent = frame
            data.label = lbl
            
            local distLbl = Instance.new("TextLabel")
            distLbl.AnchorPoint = Vector2.new(0.5, 1)
            distLbl.Position = UDim2.new(0.5, 0, 0.9, 0)
            distLbl.Size = UDim2.new(0.9, 0, 0.3, 0)
            distLbl.BackgroundTransparency = 1
            distLbl.Text = "0 格"
            distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
            distLbl.TextScaled = true
            distLbl.Font = Enum.Font.Gotham
            distLbl.Parent = frame
            data.distLabel = distLbl
        else
            local dotBb = Instance.new("BillboardGui")
            dotBb.Name = espType .. "Dot"
            dotBb.Adornee = headPart
            dotBb.AlwaysOnTop = true
            dotBb.Size = UDim2.new(0, 8, 0, 8)
            dotBb.StudsOffset = Vector3.new(0, 0, 0)
            dotBb.MaxDistance = 2000
            dotBb.Parent = zombie
            data.dot = dotBb
            
            local dotFrame = Instance.new("Frame")
            dotFrame.Size = UDim2.new(1, 0, 1, 0)
            dotFrame.BackgroundColor3 = config.color
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0.5, 0)
            corner.Parent = dotFrame
            dotFrame.Parent = dotBb
            
            local bb = Instance.new("BillboardGui")
            bb.Name = espType .. "SimpleBillboard"
            bb.Adornee = headPart
            bb.AlwaysOnTop = true
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.StudsOffset = offset
            bb.MaxDistance = 1000
            bb.Enabled = ShowBillboards
            bb.Parent = zombie
            data.billboard = bb
            
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0.6, 0)
            lbl.Position = UDim2.new(0, 0, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = config.label
            lbl.TextColor3 = config.color
            lbl.TextScaled = true
            lbl.Font = Enum.Font.GothamBold
            lbl.Parent = bb
            data.label = lbl
            
            local distLbl = Instance.new("TextLabel")
            distLbl.Size = UDim2.new(1, 0, 0.4, 0)
            distLbl.Position = UDim2.new(0, 0, 0.6, 0)
            distLbl.BackgroundTransparency = 1
            distLbl.Text = "0 格"
            distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
            distLbl.TextScaled = true
            distLbl.Font = Enum.Font.Gotham
            distLbl.Parent = bb
            data.distLabel = distLbl
        end
    end
    
    local function RemoveVisual(espType, zombie)
        local data = ESPData[espType][zombie]
        if not data then return end
        pcall(function()
            if data.highlight then data.highlight:Destroy() end
            if data.billboard then data.billboard:Destroy() end
            if data.dot then data.dot:Destroy() end
        end)
        ESPData[espType][zombie] = nil
    end
    
    local function ScanAll()
        if not CameraFolder then return end
        local children = CameraFolder:GetChildren()
        for espType, enabled in pairs(EnabledESPs) do
            if enabled then
                local currentWithData = {}
                for z, _ in pairs(ESPData[espType]) do currentWithData[z] = true end
                for _, z in ipairs(children) do
                    if z:IsA("Model") and z.Name == "m_Zombie" then
                        if ESPConfigs[espType].match(z) then
                            if not ESPData[espType][z] then CreateVisual(espType, z) end
                            currentWithData[z] = nil
                        end
                    end
                end
                for z in pairs(currentWithData) do RemoveVisual(espType, z) end
            end
        end
    end
    
    local function UpdateAllTransparencies()
        for espType, dataTable in pairs(ESPData) do
            for _, data in pairs(dataTable) do
                if data.highlight then data.highlight.FillTransparency = ChamsTransparency end
            end
        end
    end
    
    local function UpdateAllBillboards()
        local Camera = workspace.CurrentCamera
        if not Camera then return end
        for espType, dataTable in pairs(ESPData) do
            for zombie, data in pairs(dataTable) do
                if not zombie or not zombie.Parent then RemoveVisual(espType, zombie) continue end
                local adornee = nil
                if data.billboard and data.billboard.Adornee then adornee = data.billboard.Adornee end
                if not adornee and data.dot and data.dot.Adornee then adornee = data.dot.Adornee end
                if (not adornee) or (not adornee.Parent) then
                    local newPart = GetAdorneePart(zombie)
                    if newPart then
                        if data.billboard then data.billboard.Adornee = newPart end
                        if data.dot then data.dot.Adornee = newPart end
                        adornee = newPart
                    else
                        RemoveVisual(espType, zombie)
                        continue
                    end
                end
                local ok, pos = pcall(function() return adornee.Position end)
                if not ok or not pos then RemoveVisual(espType, zombie) continue end
                local dist = (Camera.CFrame.Position - pos).Magnitude
                if data.highlight then data.highlight.Enabled = dist < 100 end
                if data.dot then data.dot.Enabled = dist < 500 end
                if data.billboard then
                    if not ShowBillboards then
                        data.billboard.Enabled = false
                    else
                        local baseW, baseH = 100, 40
                        local scale
                        if not PerformanceMode then
                            if dist < 300 then
                                scale = math.clamp(30 / math.max(dist, 1), 0.5, 1.5)
                                data.billboard.Enabled = true
                            else
                                data.billboard.Enabled = false
                            end
                        else
                            if dist < 500 then
                                scale = math.clamp(30 / math.max(dist, 1), 0.5, 1.0)
                                data.billboard.Enabled = true
                            else
                                data.billboard.Enabled = false
                            end
                        end
                        if scale then data.billboard.Size = UDim2.new(0, math.floor(baseW * scale), 0, math.floor(baseH * scale)) end
                        if data.distLabel then data.distLabel.Text = math.floor(dist) .. " 格" end
                    end
                end
            end
        end
    end
    
    local function StartShared()
        activeCount = activeCount + 1
        if activeCount == 1 then
            ScanAll()
            scanLoop = task.spawn(function()
                while activeCount > 0 do
                    ScanAll()
                    task.wait(0.25)
                end
            end)
            renderConn = RunService.RenderStepped:Connect(UpdateAllBillboards)
        end
    end
    
    local function StopShared()
        activeCount = activeCount - 1
        if activeCount == 0 then
            if scanLoop then task.cancel(scanLoop) scanLoop = nil end
            if renderConn then renderConn:Disconnect() renderConn = nil end
        end
    end
    
    local function TogglePerformanceMode(state)
        PerformanceMode = state
        for espType in pairs(ESPConfigs) do
            for zombie in pairs(ESPData[espType]) do RemoveVisual(espType, zombie) end
            ESPData[espType] = {}
        end
        ScanAll()
    end
    
    local LastChargeState = false
    local NotifyCuirassierCharge = false
    local CuirassierStateLoop
    
    local function IsCharging(state)
        state = tostring(state or ""):lower()
        return (state == "begincharge" or state == "charge")
    end
    
    local function UpdateCuirassierState()
        local zFolder = workspace:FindFirstChild("Zombies")
        if not zFolder then return end
        local slim = zFolder:FindFirstChild("Slim")
        if not slim then return end
        local stateVal = slim:FindFirstChild("State")
        if not stateVal or not stateVal:IsA("StringValue") then return end
        local charging = IsCharging(stateVal.Value)
        for _, data in pairs(ESPData.Cuirassier) do
            if data.label and (data.frame or true) then
                if charging then
                    data.label.Text = "冲锋中"
                    data.label.TextColor3 = Color3.fromRGB(255, 80, 80)
                    if data.frame then data.frame.BorderColor3 = Color3.fromRGB(255, 80, 80) end
                else
                    data.label.Text = "胸甲骑兵"
                    data.label.TextColor3 = ESPConfigs.Cuirassier.color
                    if data.frame then data.frame.BorderColor3 = ESPConfigs.Cuirassier.color end
                end
            end
        end
        if charging and NotifyCuirassierCharge and not LastChargeState then
            Library:Notify({ Title = "胸甲骑兵冲锋", Description = "胸甲骑兵正在冲锋!", Time = 2 })
        end
        LastChargeState = charging
    end
    
    local function StartCuirassierSpecific()
        LastChargeState = false
        UpdateCuirassierState()
        CuirassierStateLoop = task.spawn(function()
            while EnabledESPs.Cuirassier do
                UpdateCuirassierState()
                task.wait(0.5)
            end
        end)
    end
    
    local function StopCuirassierSpecific()
        if CuirassierStateLoop then task.cancel(CuirassierStateLoop) CuirassierStateLoop = nil end
        LastChargeState = false
    end
    
    ESPSection:AddToggle("ESPBomber", {
        Text = "自爆透视",
        Default = false,
        Tooltip = "显示所有自爆!",
        Callback = function(state)
            EnabledESPs.Bomber = state
            if state then
                StartShared()
               
            else
                for z in pairs(ESPData.Bomber) do RemoveVisual("Bomber", z) end
                ESPData.Bomber = {}
                StopShared()
               
            end
        end,
    })
    
    ESPSection:AddToggle("ESPCuirassier", {
        Text = "胸甲骑兵透视",
        Default = false,
        Tooltip = "显示胸甲骑兵僵尸",
        Callback = function(state)
            EnabledESPs.Cuirassier = state
            if state then
                StartShared()
                StartCuirassierSpecific()
               
            else
                for z in pairs(ESPData.Cuirassier) do RemoveVisual("Cuirassier", z) end
                ESPData.Cuirassier = {}
                StopCuirassierSpecific()
                StopShared()
               
            end
        end,
    })
    
    ESPSection:AddToggle("NotifyCuirassierCharge", {
        Text = "胸甲骑兵冲锋警报",
        Default = false,
        Tooltip = "当胸甲骑兵僵尸冲锋时发出警告",
        Callback = function(state)
            NotifyCuirassierCharge = state
            Library:Notify({ Title = "胸甲骑兵冲锋", Description = state and "冲锋警报开启" or "冲锋警报关闭", Time = 2 })
        end,
    })
    
    ESPSection:AddToggle("ESPRunner", {
        Text = "红眼透视",
        Default = false,
        Tooltip = "显示所有红眼僵尸",
        Callback = function(state)
            EnabledESPs.Runner = state
            if state then StartShared() else for z in pairs(ESPData.Runner) do RemoveVisual("Runner", z) end ESPData.Runner = {} StopShared() end
        end,
    })
    
    ESPSection:AddToggle("ESPZapper", {
        Text = "斧头透视",
        Default = false,
        Tooltip = "显示所有斧头者僵尸",
        Callback = function(state)
            EnabledESPs.Zapper = state
            if state then StartShared() else for z in pairs(ESPData.Zapper) do RemoveVisual("Zapper", z) end ESPData.Zapper = {} StopShared() end
        end,
    })
    
    ESPSection:AddToggle("ESPIgniter", {
        Text = "提灯人透视",
        Default = false,
        Tooltip = "显示所有提灯人",
        Callback = function(state)
            EnabledESPs.Igniter = state
            if state then StartShared() else for z in pairs(ESPData.Igniter) do RemoveVisual("Igniter", z) end ESPData.Igniter = {} IdentifiedIgniters = {} StopShared() end
        end,
    })
    
    local SettingsSection = Tabs.e:AddRightGroupbox("设置", "settings")
    
    SettingsSection:AddToggle("ShowBillboards", {
        Text = "显示标签",
        Default = false,
        Tooltip = "切换僵尸上方的标签",
        Callback = function(state) ShowBillboards = state end,
    })
    
    SettingsSection:AddSlider("ChamsTransparency", {
        Text = "透视透明度",
        Default = 0.6,
        Min = 0,
        Max = 1,
        Rounding = 2,
        Callback = function(value)
            ChamsTransparency = math.clamp(tonumber(value) or 0.6, 0, 1)
            UpdateAllTransparencies()
        end,
    })
    
    SettingsSection:AddToggle("PerformanceMode", {
        Text = "性能模式",
        Default = false,
        Tooltip = "将透视变为点并简化标签",
        Callback = function(state) TogglePerformanceMode(state) end,
    })
end
do
    local PlayersSvc = Players or game:GetService("Players")
    local WorkspaceSvc = Workspace or game:GetService("Workspace")
    local LocalPlayer = PlayersSvc.LocalPlayer
    
    local DEBUG = false
    KillAuraEnabled = KillAuraEnabled or false
    KillAuraRange = KillAuraRange or 19
    LoopInterval = LoopInterval or 0.01
    KillAuraSpamCount = KillAuraSpamCount or 1
    MultiTarget = MultiTarget or 1
    TargetESP = TargetESP or false
    FOVEnabled = FOVEnabled or false
    FOVVisible = FOVVisible or false
    FOVSize = FOVSize or 90
    AutoLook = AutoLook or false
    
    local remotes = {}
    local HeadCache = {}
    local lastRemoteScan = 0
    local zombiesFolder = WorkspaceSvc:FindFirstChild("Zombies")
    local dots = {}
    local fovCircle = Drawing and Drawing.new and Drawing.new("Circle") or nil
    if fovCircle then
        fovCircle.Color = Color3.fromRGB(255, 255, 255)
        fovCircle.Thickness = 2
        fovCircle.NumSides = 100
        fovCircle.Filled = false
        fovCircle.Visible = false
    end
    
    local renderConn = nil
    local autoLookConn = nil
    
    local function distSqVec3(a,b)
        local dx, dy, dz = a.X - b.X, a.Y - b.Y, a.Z - b.Z
        return dx*dx + dy*dy + dz*dz
    end
    
    local function findHead(zombie)
        if not (zombie and zombie:IsA("Model")) then return nil end
        local head = zombie:FindFirstChild("Head") or zombie:FindFirstChild("head")
        if head and head:IsA("BasePart") then return head end
        local hrp = zombie:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:IsA("BasePart") then return hrp end
        if zombie.PrimaryPart and zombie.PrimaryPart:IsA("BasePart") then return zombie.PrimaryPart end
        local children = zombie:GetChildren()
        local possible = children[12]
        if possible and possible:IsA("BasePart") then return possible end
        for _, p in ipairs(zombie:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "Whale Oil Lantern" then return p end
        end
        return nil
    end
    
    local function addHeadToCache(model)
        if not (model and model:IsA("Model")) then return end
        local isZombie = false
        if zombiesFolder then
            isZombie = model:IsDescendantOf(zombiesFolder) or model.Parent == zombiesFolder
        else
            local nm = tostring(model.Name or ""):lower()
            isZombie = nm == "m_zombie" or nm:find("zombie")
        end
        if not isZombie then return end
        local ok, head = pcall(findHead, model)
        if ok and head then HeadCache[model] = head end
    end
    
    local function removeFromCaches(model) HeadCache[model] = nil end
    
    if zombiesFolder then
        for _, z in ipairs(zombiesFolder:GetChildren()) do if z:IsA("Model") then addHeadToCache(z) end end
        zombiesFolder.ChildAdded:Connect(function(c) if c and c:IsA("Model") then task.delay(0.03, function() addHeadToCache(c) end) end end)
        zombiesFolder.ChildRemoved:Connect(function(c) if c then removeFromCaches(c) end end)
    else
        for _, obj in ipairs(WorkspaceSvc:GetDescendants()) do
            if obj:IsA("Model") and (tostring(obj.Name) == "m_Zombie" or tostring(obj.Name):lower():find("zombie")) then addHeadToCache(obj) end
        end
    end
    
    local function ScanRemotesNow()
        table.clear(remotes)
        local char = LocalPlayer and LocalPlayer.Character
        if not char then return end
        for _, tool in ipairs(char:GetChildren()) do
            if tool and tool:IsA("Tool") then
                for _, ch in ipairs(tool:GetChildren()) do
                    if ch and ch:IsA("RemoteEvent") then remotes[ch] = true end
                end
            end
        end
        lastRemoteScan = tick()
    end
    
    if LocalPlayer then
        LocalPlayer.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            ScanRemotesNow()
            char.ChildAdded:Connect(function(c) if c and c:IsA("Tool") then task.delay(0.05, ScanRemotesNow) end end)
            char.ChildRemoved:Connect(function(c) if c and c:IsA("Tool") then task.delay(0.05, ScanRemotesNow) end end)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.AutoRotate = true end
        end)
        if LocalPlayer.Character then task.defer(ScanRemotesNow) end
    end
    
    local function fireSwing(remote)
        if remote and remote:IsA("RemoteEvent") then
            pcall(function() remote:FireServer("Swing", "Thrust") end)
        end
    end
    
    local function fireHit(remote, model, headPos)
        if not (remote and remote:IsA("RemoteEvent") and model and headPos) then return end
        pcall(function()
            remote:FireServer("HitZombie", model, headPos, true, Vector3.new(0,15,0), "Head", Vector3.new(0,1,0))
        end)
    end
    
    local function isInFOV(pos)
        local cam = WorkspaceSvc.CurrentCamera
        if not cam then return false end
        local camPos = cam.CFrame.Position
        local camLook = cam.CFrame.LookVector
        local dir = (pos - camPos)
        local dist = dir.Magnitude
        if dist == 0 then return true end
        local unit = dir / dist
        local dot = unit:Dot(camLook)
        return dot >= math.cos(math.rad(FOVSize / 2))
    end
    
    local function getTargetsInRange(range, hrpPos, useFOV)
        local rangeSq = range * range
        local targets = {}
        if not hrpPos then return targets end
        for model, head in pairs(HeadCache) do
            if not (model and model.Parent and head and head.Parent) then HeadCache[model] = nil continue end
            local hum = model:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local ok, pos = pcall(function() return head.Position end)
            if not ok or not pos then continue end
            local d2 = distSqVec3(pos, hrpPos)
            if d2 <= rangeSq then
                if not useFOV or isInFOV(pos) then
                    targets[#targets+1] = { model = model, head = head, d2 = d2, headPos = pos }
                end
            end
        end
        table.sort(targets, function(a,b) return a.d2 < b.d2 end)
        return targets
    end
    
    local currentAuraLoopId = 0
    task.spawn(function()
        while true do
            task.wait(LoopInterval or 0.1)
            if not KillAuraEnabled then continue end
            currentAuraLoopId = currentAuraLoopId + 1
            local loopId = currentAuraLoopId
            local char = LocalPlayer and LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            if tick() - lastRemoteScan > 1 then ScanRemotesNow() end
            local trueRange = KillAuraRange or 19
            local targets = getTargetsInRange(trueRange, hrp.Position, FOVEnabled)
            if #targets == 0 then continue end
            local maxTargets = math.max(1, math.floor(MultiTarget or 1))
            for i = 1, math.min(#targets, maxTargets) do
                if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
                local entry = targets[i]
                if not entry then break end
                for remote in pairs(remotes) do
                    if remote then
                        task.spawn(function()
                            if not KillAuraEnabled or loopId ~= currentAuraLoopId then return end
                            local spamCount = math.max(1, math.floor(KillAuraSpamCount or 1))
                            for s = 1, spamCount do
                                if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
                                fireSwing(remote)
                                task.wait(0.01)
                                if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
                                local headPos = entry.headPos or (entry.head and entry.head.Position)
                                if headPos then fireHit(remote, entry.model, headPos) end
                            end
                        end)
                    end
                end
            end
        end
    end)
    
    local function updateVisuals()
        local char = LocalPlayer and LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cam = WorkspaceSvc.CurrentCamera
        if not (char and hrp and cam) then
            for _, d in pairs(dots) do if d then d.Visible = false end end
            if fovCircle then fovCircle.Visible = false end
            return
        end
        if TargetESP then
            local tool = char:FindFirstChildWhichIsA("Tool")
            local restPos = hrp.Position
            if tool then
                local handle = tool:FindFirstChild("Handle")
                if handle then restPos = handle.Position end
            end
            local trueRange = KillAuraRange or 19
            local targets = getTargetsInRange(trueRange, hrp.Position, FOVEnabled)
            local maxDots = math.max(1, math.floor(MultiTarget or 1))
            for i = 1, maxDots do
                local dot = dots[i]
                if not dot and Drawing and Drawing.new then
                    dot = Drawing.new("Circle")
                    dot.Color = Color3.fromRGB(255, 0, 0)
                    dot.Thickness = 1
                    dot.NumSides = 12
                    dot.Radius = 5
                    dot.Filled = true
                    dot.Transparency = 1
                    dot.Visible = false
                    dots[i] = dot
                end
                local targetPos
                if i <= #targets then targetPos = targets[i].headPos or targets[i].head.Position
                else targetPos = restPos end
                local screenPos, onScreen = cam:WorldToViewportPoint(targetPos)
                if dot then
                    if onScreen then
                        dot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        dot.Visible = true
                    else dot.Visible = false end
                end
            end
            for i = (math.max(1, math.floor(MultiTarget or 1)) + 1), #dots do if dots[i] then dots[i].Visible = false end end
        else
            for _, d in pairs(dots) do if d then d.Visible = false end end
        end
        if FOVVisible and fovCircle then
            local size = cam.ViewportSize
            local center = size / 2
            fovCircle.Position = center
            local fovRad = math.rad(FOVSize)
            local camFovRad = math.rad(cam.FieldOfView)
            local radius = (math.tan(fovRad / 2) / math.tan(camFovRad / 2)) * (size.Y / 2)
            fovCircle.Radius = radius
            fovCircle.Visible = true
        elseif fovCircle then fovCircle.Visible = false end
    end
    
    local function manageRenderLoop()
        if (TargetESP or FOVVisible) and not renderConn then
            renderConn = RunService.RenderStepped:Connect(updateVisuals)
        elseif not (TargetESP or FOVVisible) and renderConn then
            renderConn:Disconnect()
            renderConn = nil
            for _, d in pairs(dots) do if d then d.Visible = false end end
            if fovCircle then fovCircle.Visible = false end
        end
    end
    
    local function updateAutoLook()
        local char = LocalPlayer and LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not (hrp and hum) then return end
        local autoLookRange = 30
        local targets = getTargetsInRange(autoLookRange, hrp.Position, false)
        if #targets == 0 then
            if not hum.AutoRotate then hum.AutoRotate = true end
            return
        end
        if hum.AutoRotate then hum.AutoRotate = false end
        local closest = targets[1]
        if not closest or not closest.head or not closest.head.Parent then return end
        local headPos = closest.headPos or closest.head.Position
        if not headPos then return end
        local direction = (headPos - hrp.Position)
        local flatDir = Vector3.new(direction.X, 0, direction.Z)
        if flatDir.Magnitude <= 0.01 then return end
        local targetCFrame = CFrame.lookAt(hrp.Position, hrp.Position + flatDir)
        hrp.CFrame = hrp.CFrame:Lerp(targetCFrame, 0.25)
    end
    
    local function manageAutoLook()
        local char = LocalPlayer and LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if AutoLook and not autoLookConn then
            autoLookConn = RunService.Heartbeat:Connect(updateAutoLook)
            if hum then hum.AutoRotate = true end
        elseif not AutoLook and autoLookConn then
            autoLookConn:Disconnect()
            autoLookConn = nil
            if hum then hum.AutoRotate = true end
        end
    end
    
    local MainSection = Tabs.r:AddLeftGroupbox("杀戮光环", "sword")

local AnimationIds = {
    Start = "rbxassetid://12591948314", 
    Stop = "rbxassetid://12591945044" 
}
local LoadedAnims = {}
local Animator = nil

local function LoadAnimations()
    local char = LocalPlayer and LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    Animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator")
    
    LoadedAnims = {}
    for name, id in pairs(AnimationIds) do
        local anim = Instance.new("Animation")
        anim.AnimationId = id
        LoadedAnims[name] = Animator:LoadAnimation(anim)
    end
end

local function PlayAnim(name)
    if not LoadedAnims[name] then
        LoadAnimations()
    end
    if LoadedAnims[name] then
        LoadedAnims[name]:Play()
    end
end

local currentAuraLoopId = 0
task.spawn(function()
    while true do
        task.wait(LoopInterval or 0.1)
        if not KillAuraEnabled then continue end
        currentAuraLoopId = currentAuraLoopId + 1
        local loopId = currentAuraLoopId
        local char = LocalPlayer and LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        if tick() - lastRemoteScan > 1 then ScanRemotesNow() end
        
        local trueRange = KillAuraRange or 19
        local targets = getTargetsInRange(trueRange, hrp.Position, FOVEnabled)
        if #targets == 0 then continue end
        
        PlayAnim("Start")
        
        local maxTargets = math.max(1, math.floor(MultiTarget or 1))
        for i = 1, math.min(#targets, maxTargets) do
            if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
            local entry = targets[i]
            if not entry then break end
            
            for remote in pairs(remotes) do
                if remote then
                    task.spawn(function()
                        if not KillAuraEnabled or loopId ~= currentAuraLoopId then return end
                        local spamCount = math.max(1, math.floor(KillAuraSpamCount or 1))
                        for s = 1, spamCount do
                            if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
                            fireSwing(remote)
                            task.wait(0.01)
                            if not KillAuraEnabled or loopId ~= currentAuraLoopId then break end
                            local headPos = entry.headPos or (entry.head and entry.head.Position)
                            if headPos then fireHit(remote, entry.model, headPos) end
                        end
                    end)
                end
            end
        end
        
        task.delay(0.3, function()
            if loopId == currentAuraLoopId then
                PlayAnim("Stop")
            end
        end)
    end
end)

MainSection:AddToggle("KillAura", {
    Text = "杀戮光环（先开启这个才有效果）",
    Default = false,
    Tooltip = "合法击杀范围内的僵尸",
    Callback = function(v)
        KillAuraEnabled = v
        if v then
            ScanRemotesNow()
            LoadAnimations()
        else
            currentAuraLoopId = currentAuraLoopId + 1
            PlayAnim("Stop")
        end
    end,
})
    MainSection:AddToggle("KillAura", {
        Text = "杀戮光环",
        Default = false,
        Tooltip = "自动击杀范围内的僵尸",
        Callback = function(v)
            KillAuraEnabled = v
            if v then
                ScanRemotesNow()
               
            else
                currentAuraLoopId = currentAuraLoopId + 1
               
            end
        end,
    }):AddKeyPicker('NoclipKeybind', {
    Default = 'B',
    Mode = 'Toggle',
    Text = '杀戮光环',
    NoUI = false,
    Callback = function(Value) end,
    SyncToggleState = true,
    ChangedCallback = function(New) end
})
    
    MainSection:AddSlider("KillAuraRange", {
        Text = "杀戮光环范围",
        Default = 19,
        Min = 5,
        Max = 30,
        Rounding = 1,
        Callback = function(v) KillAuraRange = v end,
    })
    
    MainSection:AddSlider("AttackSpeed", {
        Text = "攻击速度",
        Default = 1,
        Min = 1,
        Max = 5,
        Rounding = 0,
        Callback = function(v) KillAuraSpamCount = math.max(1, math.floor(v)) end,
    })
    
    local SettingsSection = Tabs.r:AddRightGroupbox("设置", "settings")
    
    SettingsSection:AddSlider("MultiTarget", {
        Text = "多目标",
        Default = 1,
        Min = 1,
        Max = 10,
        Rounding = 0,
        Tooltip = "控制杀戮光环每次攻击会击杀多少僵尸",
        Callback = function(v) MultiTarget = math.max(1, math.floor(v)) end,
    })
    
    SettingsSection:AddToggle("TargetESP", {
        Text = "目标透视",
        Default = false,
        Tooltip = "显示杀戮光环当前瞄准的僵尸",
        Callback = function(v)
            TargetESP = v
            if not v then for _, d in pairs(dots) do if d then d.Visible = false end end dots = {} end
            manageRenderLoop()
        end,
    })
    
    SettingsSection:AddSlider("FOVSize", {
        Text = "视野大小",
        Default = 90,
        Min = 10,
        Max = 180,
        Rounding = 0,
        Tooltip = "视野圆圈的大小",
        Callback = function(v) FOVSize = v end,
    })
    
    SettingsSection:AddToggle("FOVEnabled", {
        Text = "启用视野",
        Default = false,
        Tooltip = "只瞄准视野内的僵尸",
        Callback = function(v) FOVEnabled = v end,
    })
    
    SettingsSection:AddToggle("FOVVisible", {
        Text = "显示视野",
        Default = false,
        Tooltip = "显示视野圆圈",
        Callback = function(v)
            FOVVisible = v
            if not v and fovCircle then fovCircle.Visible = false end
            manageRenderLoop()
        end,
    })
    
    SettingsSection:AddToggle("AutoLook", {
        Text = "自动注视",
        Default = false,
        Tooltip = "自动看向最近的僵尸",
        Callback = function(v)
            AutoLook = v
            manageAutoLook()
        end,
    })
    
    manageRenderLoop()
    manageAutoLook()
end

do
    local PlayerESPSection = Tabs.y:AddLeftGroupbox("玩家透视", "user-check")
    
    local ChamsESPEnabled = false
    local BillboardESPEnabled = false
    local NotifyLowHealthEnabled = false
    local ShowInfectedEnabled = false
    local PlayerESPData = {}
    
    local BILLBOARD_MAX_DISTANCE = 150
    local BILLBOARD_MIN_SIZE = Vector2.new(120, 55)
    local BILLBOARD_MAX_SIZE = Vector2.new(280, 120)
    local STUDS_OFFSET_BASE = Vector3.new(0, 3.5, 0)
    local STUDS_SMOOTH_ALPHA = 0.22
    local TracersEnabled = false
    
    local function RemovePlayerESP(player)
        local data = PlayerESPData[player]
        if not data then return end
        pcall(function()
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
        end)
        PlayerESPData[player] = nil
    end
    
    local function CreatePlayerESP(player)
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if not hum then return end
        local head = char:FindFirstChild("Head")
        if not head then return end
        RemovePlayerESP(player)
        
        local highlight = nil
        if ChamsESPEnabled then
            highlight = Instance.new("Highlight")
            highlight.Name = "Ziaan_Cham_Highlight"
            highlight.Adornee = char
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.45
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineTransparency = 0
            highlight.Parent = char
        end
        
        local billboard = nil
        local nameLabel, healthLabel, infectionLabel, distanceLabel
        if BillboardESPEnabled then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "Ziaan_ESP_Billboard"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0, BILLBOARD_MAX_SIZE.X, 0, BILLBOARD_MAX_SIZE.Y)
            billboard.StudsOffset = STUDS_OFFSET_BASE
            billboard.AlwaysOnTop = true
            billboard.LightInfluence = 0
            billboard.MaxDistance = BILLBOARD_MAX_DISTANCE
            billboard.Parent = char
            
            local espFrame = Instance.new("Frame")
            espFrame.Name = "ESPFrame"
            espFrame.Size = UDim2.new(1, 0, 1, 0)
            espFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            espFrame.BackgroundTransparency = 0.6
            espFrame.BorderSizePixel = 0
            espFrame.Parent = billboard
            
            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 8)
            uiCorner.Parent = espFrame
            
            nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "Name"
            nameLabel.Text = player.Name
            nameLabel.Size = UDim2.new(1, 0, 0.22, 0)
            nameLabel.Position = UDim2.new(0, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.TextSize = 18
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.TextWrapped = true
            nameLabel.TextXAlignment = Enum.TextXAlignment.Center
            nameLabel.Parent = espFrame
            
            healthLabel = Instance.new("TextLabel")
            healthLabel.Name = "Health"
            healthLabel.Text = "生命值: 100/100"
            healthLabel.Size = UDim2.new(1, 0, 0.22, 0)
            healthLabel.Position = UDim2.new(0, 0, 0.25, 0)
            healthLabel.BackgroundTransparency = 1
            healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            healthLabel.TextStrokeTransparency = 0.5
            healthLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            healthLabel.TextSize = 15
            healthLabel.Font = Enum.Font.SourceSansBold
            healthLabel.TextWrapped = true
            healthLabel.TextXAlignment = Enum.TextXAlignment.Center
            healthLabel.Parent = espFrame
            
            infectionLabel = Instance.new("TextLabel")
            infectionLabel.Name = "Infection"
            infectionLabel.Text = "感染: 0/100"
            infectionLabel.Size = UDim2.new(1, 0, 0.22, 0)
            infectionLabel.Position = UDim2.new(0, 0, 0.48, 0)
            infectionLabel.BackgroundTransparency = 1
            infectionLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            infectionLabel.TextStrokeTransparency = 0.5
            infectionLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            infectionLabel.TextSize = 15
            infectionLabel.Font = Enum.Font.SourceSansBold
            infectionLabel.TextWrapped = true
            infectionLabel.TextXAlignment = Enum.TextXAlignment.Center
            infectionLabel.Visible = false
            infectionLabel.Parent = espFrame
            
            distanceLabel = Instance.new("TextLabel")
            distanceLabel.Name = "Distance"
            distanceLabel.Text = "0 格"
            distanceLabel.Size = UDim2.new(1, 0, 0.22, 0)
            distanceLabel.Position = UDim2.new(0, 0, 0.71, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            distanceLabel.TextStrokeTransparency = 0.5
            distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distanceLabel.TextSize = 15
            distanceLabel.Font = Enum.Font.SourceSans
            distanceLabel.TextWrapped = true
            distanceLabel.TextXAlignment = Enum.TextXAlignment.Center
            distanceLabel.Parent = espFrame
        end
        
        PlayerESPData[player] = {
            Char = char, Humanoid = hum, Head = head,
            Highlight = highlight, Billboard = billboard, ESPFrame = espFrame,
            NameLabel = nameLabel, HealthLabel = healthLabel,
            InfectionLabel = infectionLabel, DistanceLabel = distanceLabel,
            NotifState = nil, LastNotify = 0,
            CurrentStudsOffset = STUDS_OFFSET_BASE, DesiredStudsOffset = STUDS_OFFSET_BASE
        }
    end
    
    local function UpdateESPLoop()
        if not (ChamsESPEnabled or BillboardESPEnabled) then return end
        local localChar = LocalPlayer.Character
        local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        if not camera then return end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local data = PlayerESPData[player]
                local char = player.Character
                if not char or not char.Parent then if data then RemovePlayerESP(player) end continue end
                if not data or data.Char ~= char then CreatePlayerESP(player) data = PlayerESPData[player] if not data then continue end end
                if ChamsESPEnabled and (not data.Highlight or not data.Highlight.Parent) then CreatePlayerESP(player) data = PlayerESPData[player] if not data then continue end end
                if BillboardESPEnabled and (not data.Billboard or not data.Billboard.Parent) then CreatePlayerESP(player) data = PlayerESPData[player] if not data then continue end end
                local hum = data.Humanoid
                if not hum then continue end
                local health = hum.Health
                local max = hum.MaxHealth > 0 and hum.MaxHealth or 1
                local percent = math.clamp(health / max, 0, 1)
                
                local grabbed, pinned, infectionLevel = false, false, 0
                local wPlayers = workspace:FindFirstChild("Players")
                if wPlayers then
                    local playerFolder = wPlayers:FindFirstChild(player.Name)
                    if playerFolder then
                        local userStates = playerFolder:FindFirstChild("UserStates")
                        if userStates then
                            local grabbedVal = userStates:FindFirstChild("Grabbed")
                            grabbed = (grabbedVal and tonumber(grabbedVal.Value) or 0) ~= 0
                            local pinVal = userStates:FindFirstChild("Pin")
                            pinned = tostring(pinVal and pinVal.Value or "None") ~= "None"
                            local infectedVal = userStates:FindFirstChild("Infected")
                            infectionLevel = infectedVal and tonumber(infectedVal.Value) or 0
                        end
                    end
                end
                
                local shouldBeRed = grabbed or pinned or infectionLevel >= 70
                if data.ESPFrame then
                    if shouldBeRed then
                        data.ESPFrame.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
                        data.ESPFrame.BackgroundTransparency = 0.4
                    else
                        data.ESPFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        data.ESPFrame.BackgroundTransparency = 0.6
                    end
                end
                
                if ChamsESPEnabled and data.Highlight then
                    local r = math.floor(255 * (1 - percent))
                    local g = math.floor(255 * percent)
                    local baseColor = Color3.fromRGB(r, g, 0)
                    if TracersEnabled and (grabbed or pinned) then
                        local pulse = math.sin(tick() * 8)
                        local flashColor = pulse > 0 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                        data.Highlight.FillColor = flashColor
                        data.Highlight.FillTransparency = 0.25 + 0.2 * math.abs(math.sin(tick() * 5))
                    else
                        data.Highlight.FillColor = baseColor
                        data.Highlight.FillTransparency = 0.45
                    end
                end
                
                local playerRoot = char:FindFirstChild("HumanoidRootPart")
                local dist = nil
                if localRoot and playerRoot then dist = (localRoot.Position - playerRoot.Position).Magnitude end
                
                if BillboardESPEnabled and data.Billboard then
                    if dist and dist > BILLBOARD_MAX_DISTANCE then data.Billboard.Enabled = false
                    else
                        local t = 0
                        if dist and BILLBOARD_MAX_DISTANCE > 0 then t = math.clamp(dist / BILLBOARD_MAX_DISTANCE, 0, 1) end
                        local sizeX = math.floor((1 - t) * BILLBOARD_MAX_SIZE.X + t * BILLBOARD_MIN_SIZE.X)
                        local sizeY = math.floor((1 - t) * BILLBOARD_MAX_SIZE.Y + t * BILLBOARD_MIN_SIZE.Y)
                        data.Billboard.Size = UDim2.new(0, sizeX, 0, sizeY)
                        local baseTextSize = math.clamp(math.floor(sizeY * 0.22), 14, 20)
                        if data.NameLabel then data.NameLabel.TextSize = math.clamp(math.floor(sizeY * 0.25), 16, 22) end
                        if data.HealthLabel then data.HealthLabel.TextSize = baseTextSize end
                        if data.InfectionLabel then data.InfectionLabel.TextSize = baseTextSize data.InfectionLabel.Visible = ShowInfectedEnabled end
                        if data.DistanceLabel then data.DistanceLabel.TextSize = baseTextSize end
                        if data.HealthLabel then
                            data.HealthLabel.Text = "生命值: " .. math.floor(health) .. "/" .. math.floor(max)
                            local healthR = math.floor(255 * (1 - percent))
                            local healthG = math.floor(255 * percent)
                            data.HealthLabel.TextColor3 = Color3.fromRGB(healthR, healthG, 0)
                        end
                        if data.InfectionLabel then
                            data.InfectionLabel.Text = "感染: " .. math.floor(infectionLevel) .. "/100"
                            local infectPercent = infectionLevel / 100
                            local infectR = math.floor(255 * infectPercent)
                            local infectG = math.floor(255 * (1 - infectPercent))
                            data.InfectionLabel.TextColor3 = Color3.fromRGB(infectR, infectG, 0)
                        end
                        if data.DistanceLabel then data.DistanceLabel.Text = math.floor(dist or 0) .. " 格" end
                        data.DesiredStudsOffset = grabbed and Vector3.new(0, 4.5, 0) or STUDS_OFFSET_BASE
                        data.CurrentStudsOffset = data.CurrentStudsOffset:Lerp(data.DesiredStudsOffset, STUDS_SMOOTH_ALPHA)
                        data.Billboard.StudsOffset = data.CurrentStudsOffset
                        data.Billboard.Enabled = true
                    end
                end
                
                if NotifyLowHealthEnabled then
                    if health <= 0 then
                        if data.NotifState ~= "dead" then
                            data.NotifState = "dead"
                            Library:Notify({ Title = "玩家死亡", Description = player.Name .. " 已死亡!", Time = 3 })
                        end
                    elseif percent < 0.25 then
                        if data.NotifState ~= "dying" and tick() - data.LastNotify > 3 then
                            data.NotifState = "dying"
                            data.LastNotify = tick()
                            Library:Notify({ Title = "玩家濒死", Description = player.Name .. " 正在濒死!", Time = 3 })
                        end
                    elseif percent < 0.45 then
                        if data.NotifState ~= "low" and tick() - data.LastNotify > 3 then
                            data.NotifState = "low"
                            data.LastNotify = tick()
                            Library:Notify({ Title = "玩家低生命值", Description = player.Name .. " 生命值低!", Time = 3 })
                        end
                    else data.NotifState = nil end
                end
            end
        end
    end
    
    RunService.Heartbeat:Connect(UpdateESPLoop)
    Players.PlayerRemoving:Connect(RemovePlayerESP)
    Players.PlayerAdded:Connect(function(p) task.wait(0.4) if ChamsESPEnabled or BillboardESPEnabled then CreatePlayerESP(p) end end)
    
    PlayerESPSection:AddToggle("PlayerChams", {
        Text = "玩家透视 (Chams)",
        Default = false,
        Tooltip = "在玩家上显示Chams透视",
        Callback = function(state)
            ChamsESPEnabled = state
            if state then
                for _, pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer then CreatePlayerESP(pl) end end
                Library:Notify({ Title = "玩家透视", Description = "玩家Chams透视已启用", Time = 2 })
            else
                for p in pairs(PlayerESPData) do
                    local data = PlayerESPData[p]
                    if data and data.Highlight then data.Highlight:Destroy() data.Highlight = nil end
                end
                Library:Notify({ Title = "玩家透视", Description = "玩家Chams透视已禁用", Time = 2 })
            end
        end,
    })
    
    PlayerESPSection:AddToggle("PlayerBillboard", {
        Text = "玩家标签透视",
        Default = false,
        Tooltip = "在玩家上显示标签文字",
        Callback = function(state)
            BillboardESPEnabled = state
            if state then
                for _, pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer then CreatePlayerESP(pl) end end
                Library:Notify({ Title = "玩家透视", Description = "玩家标签透视已启用", Time = 2 })
            else
                for p in pairs(PlayerESPData) do
                    local data = PlayerESPData[p]
                    if data and data.Billboard then
                        data.Billboard:Destroy()
                        data.Billboard = nil
                        data.NameLabel = nil
                        data.HealthLabel = nil
                        data.InfectionLabel = nil
                        data.DistanceLabel = nil
                        data.ESPFrame = nil
                    end
                end
                Library:Notify({ Title = "玩家透视", Description = "玩家标签已禁用", Time = 2 })
            end
        end,
    })
    
    PlayerESPSection:AddToggle("NotifyLowHealth", {
        Text = "低生命值玩家通知",
        Default = false,
        Tooltip = "当玩家达到低/濒死生命值时通知",
        Callback = function(state)
            NotifyLowHealthEnabled = state
            Library:Notify({ Title = "低生命值通知", Description = state and "低生命值通知开启" or "低生命值通知关闭", Time = 2 })
        end,
    })
    
    local GrabbedSection = Tabs.y:AddRightGroupbox("被抓与压制", "alert-triangle")
    
    local NotifyGrabbedPinnedEnabled = false
    local PlayerStateData = {}
    local GrabbedMonitorTask = nil
    
    local function UpdatePlayerStates(player)
        if not player or not player.Character then return end
        local wPlayers = workspace:FindFirstChild("Players")
        if not wPlayers then return end
        local playerFolder = wPlayers:FindFirstChild(player.Name)
        if not playerFolder then return end
        local userStates = playerFolder:FindFirstChild("UserStates")
        if not userStates then return end
        local grabbedVal = userStates:FindFirstChild("Grabbed")
        local pinVal = userStates:FindFirstChild("Pin")
        local data = PlayerStateData[player]
        if not data then data = { NotifiedGrabbed = false, NotifiedPin = false } PlayerStateData[player] = data end
        local grabbed = (grabbedVal and tonumber(grabbedVal.Value) or 0) ~= 0
        if grabbed then
            if not data.NotifiedGrabbed then
                data.NotifiedGrabbed = true
                Library:Notify({ Title = "玩家被抓", Description = player.Name .. " 正被抓住!", Time = 3 })
            end
        else data.NotifiedGrabbed = false end
        local pinValue = tostring(pinVal and pinVal.Value or "None")
        local isPinned = (pinValue ~= "None" and pinValue ~= "")
        if isPinned then
            if not data.NotifiedPin then
                data.NotifiedPin = true
                Library:Notify({ Title = "玩家被压制", Description = player.Name .. " 正被压制!", Time = 3 })
            end
        else data.NotifiedPin = false end
    end
    
    local function ClearAllPlayerStates() PlayerStateData = {} end
    
    local function StartGrabbedPinnedMonitor()
        if GrabbedMonitorTask then return end
        GrabbedMonitorTask = task.spawn(function()
            while NotifyGrabbedPinnedEnabled do
                for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then pcall(UpdatePlayerStates, p) end end
                task.wait(0.25)
            end
            GrabbedMonitorTask = nil
        end)
    end
    
    local function StopGrabbedPinnedMonitor()
        NotifyGrabbedPinnedEnabled = false
        ClearAllPlayerStates()
    end
    
    GrabbedSection:AddToggle("NotifyGrabbedPinned", {
        Text = "被抓与被压制玩家通知",
        Default = false,
        Tooltip = "当玩家被抓或被压制时通知",
        Callback = function(state)
            NotifyGrabbedPinnedEnabled = state
            if state then
                StartGrabbedPinnedMonitor()
                Library:Notify({ Title = "被抓/压制监视器", Description = "被抓/压制监视器开启", Time = 2 })
            else
                StopGrabbedPinnedMonitor()
                Library:Notify({ Title = "被抓/压制监视器", Description = "被抓/压制监视器关闭", Time = 2 })
            end
        end,
    })
    
    GrabbedSection:AddToggle("ShowInfected", {
        Text = "显示感染玩家",
        Default = false,
        Tooltip = "在玩家上显示感染等级 (需要标签透视)",
        Callback = function(state)
            ShowInfectedEnabled = state
            Library:Notify({ Title = "感染玩家", Description = state and "感染玩家显示已启用" or "感染玩家显示已禁用", Time = 2 })
        end,
    })
end
do
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local UserInputService = game:GetService("UserInputService")
    local MovementSection = Tabs.p:AddLeftGroupbox("移动", "user")
    local VisualSection = Tabs.p:AddRightGroupbox("视觉", "eye")
    local ServerSection = Tabs.p:AddLeftGroupbox("服务器工具", "server")
    
    local desiredWalkSpeed = 16
    local walkLoopEnabled = false
    local heartbeatConn = nil
    local humPropConns = {}
    
    local function safeSetWalk(hum, speed)
        if not (hum and hum.Parent) then return end
        pcall(function() hum.WalkSpeed = speed end)
    end
    
    local function onHumanoidPropChanged(hum)
        return hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if walkLoopEnabled then safeSetWalk(hum, desiredWalkSpeed) end
        end)
    end
    
    local function attachToCharacter(character)
        if not character then return end
        local hum = character:FindFirstChildOfClass("Humanoid")
        if not hum then hum = character:WaitForChild("Humanoid", 2) end
        if hum then
            if humPropConns[hum] then pcall(function() humPropConns[hum]:Disconnect() end) humPropConns[hum] = nil end
            humPropConns[hum] = onHumanoidPropChanged(hum)
            safeSetWalk(hum, desiredWalkSpeed)
        end
    end
    
    local function detachAllHumanoidConns()
        for hum, conn in pairs(humPropConns) do pcall(function() conn:Disconnect() end) end
        humPropConns = {}
    end
    
    local function startWalkForceLoop()
        if heartbeatConn then heartbeatConn:Disconnect() end
        heartbeatConn = RunService.Heartbeat:Connect(function()
            if not walkLoopEnabled then return end
            local char = LocalPlayer and LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    safeSetWalk(hum, desiredWalkSpeed)
                    if not humPropConns[hum] then humPropConns[hum] = onHumanoidPropChanged(hum) end
                end
            end
        end)
    end
    
    local function stopWalkForceLoop()
        if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end
        detachAllHumanoidConns()
        pcall(function()
            local char = LocalPlayer and LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end
        end)
    end
    
    if LocalPlayer then
        LocalPlayer.CharacterAdded:Connect(function(char)
            task.wait(0.15)
            if walkLoopEnabled then attachToCharacter(char) startWalkForceLoop() end
        end)
    end
    
    MovementSection:AddSlider("WalkSpeed", {
        Text = "移动速度",
        Default = 16,
        Min = 16,
        Max = 45,
        Rounding = 0,
        Tooltip = "循环移动速度",
        Callback = function(v)
            desiredWalkSpeed = math.clamp(tonumber(v) or desiredWalkSpeed, 16, 45)
            Library:Notify({ Title = "移动", Description = "移动速度设置为 " .. tostring(desiredWalkSpeed), Time = 2 })
            local char = LocalPlayer and LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then safeSetWalk(hum, desiredWalkSpeed) end
            end
        end,
    })
    
    MovementSection:AddToggle("ApplyWalkSpeed", {
        Text = "应用移动速度",
        Default = false,
        Tooltip = "强制移动速度",
        Callback = function(state)
            walkLoopEnabled = state
            if state then
                if LocalPlayer and LocalPlayer.Character then attachToCharacter(LocalPlayer.Character) end
                startWalkForceLoop()
               
            else
                stopWalkForceLoop()
               
            end
        end,
    })
    
    
    local fullbrightEnabled = false
    local fullbrightConn = nil
    local noFogEnabled = false
    local noFogConn = nil
    
    local originalLighting = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart or 0,
        GlobalShadows = Lighting.GlobalShadows,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        Ambient = Lighting.Ambient
    }
    
    local function startFullbright()
        if fullbrightConn then fullbrightConn:Disconnect() end
        fullbrightConn = RunService.Heartbeat:Connect(function()
            pcall(function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 1e6
                if Lighting.FogStart ~= nil then Lighting.FogStart = 0 end
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
                Lighting.Ambient = Color3.fromRGB(128,128,128)
                for _, inst in ipairs(workspace:GetDescendants()) do
                    if inst:IsA("Atmosphere") then pcall(function() inst.Density = 0 inst.Haze = 0 inst.Offset = 0 end) end
                end
                for _, inst in ipairs(Lighting:GetDescendants()) do
                    if inst:IsA("ColorCorrection") or inst:IsA("BloomEffect") or inst:IsA("SunRaysEffect") or inst:IsA("BlurEffect") then
                        pcall(function()
                            if inst:IsA("ColorCorrection") then inst.Enabled = false end
                            if inst:IsA("BloomEffect") then inst.Enabled = false end
                            if inst:IsA("SunRaysEffect") then inst.Enabled = false end
                            if inst:IsA("BlurEffect") then inst.Enabled = false end
                        end)
                    end
                end
            end)
        end)
    end
    
    local function stopFullbright()
        if fullbrightConn then fullbrightConn:Disconnect() fullbrightConn = nil end
        pcall(function()
            Lighting.Brightness = originalLighting.Brightness
            Lighting.ClockTime = originalLighting.ClockTime
            Lighting.FogEnd = originalLighting.FogEnd
            if Lighting.FogStart ~= nil then Lighting.FogStart = originalLighting.FogStart end
            Lighting.GlobalShadows = originalLighting.GlobalShadows
            Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
            Lighting.Ambient = originalLighting.Ambient
        end)
    end
    
    VisualSection:AddToggle("Fullbright", {
        Text = "全亮",
        Default = false,
        Tooltip = "循环全亮",
        Callback = function(state)
            fullbrightEnabled = state
            if state then
                startFullbright()
            else
                stopFullbright()
            end
        end,
    })
    
    local function startNoFog()
        if noFogConn then noFogConn:Disconnect() end
        noFogConn = RunService.Heartbeat:Connect(function()
            pcall(function()
                Lighting.FogEnd = 1e6
                if Lighting.FogStart ~= nil then Lighting.FogStart = 0 end
                for _, inst in ipairs(workspace:GetDescendants()) do
                    if inst:IsA("Atmosphere") then pcall(function() inst.Density = 0 inst.Haze = 0 inst.Offset = 0 end) end
                end
            end)
        end)
    end
    
    local function stopNoFog()
        if noFogConn then noFogConn:Disconnect() noFogConn = nil end
        pcall(function()
            Lighting.FogEnd = originalLighting.FogEnd
            if Lighting.FogStart ~= nil then Lighting.FogStart = originalLighting.FogStart end
        end)
    end
    
    VisualSection:AddToggle("NoFog", {
        Text = "无雾",
        Default = false,
        Tooltip = "开启无雾",
        Callback = function(state)
            noFogEnabled = state
            if state then
                startNoFog()
            else
                stopNoFog()
            end
        end,
    })
    
    ServerSection:AddButton({
        Text = "重新加入服务器",
        Func = function()
            Library:Notify({ Title = "服务器", Description = "正在重新加入服务器...", Time = 3 })
            pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
        end,
        DoubleClick = false,
    })
    
    ServerSection:AddButton({
        Text = "切换服务器",
        Func = function()
            Library:Notify({ Title = "服务器", Description = "正在寻找新服务器...", Time = 3 })
            local servers = {}
            local success, result = pcall(function()
                return game:HttpGet(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", game.PlaceId))
            end)
            if success and result and type(result) == "string" then
                local ok, data = pcall(function() return HttpService:JSONDecode(result) end)
                if ok and data and data.data then
                    for _, v in pairs(data.data) do
                        if v.playing < v.maxPlayers and v.id ~= game.JobId then table.insert(servers, v.id) end
                    end
                end
            end
            if #servers > 0 then
                pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1,#servers)], LocalPlayer) end)
            else
                Library:Notify({ Title = "错误", Description = "未找到可用服务器。", Time = 5 })
            end
        end,
        DoubleClick = false,
    })
end
do

    local MenuGroup = Tabs["界面设置"]:AddLeftGroupbox("菜单", "wrench")
    
    MenuGroup:AddToggle("KeybindMenuOpen", {
        Text = "打开按键绑定菜单",
        Default = Library.KeybindFrame.Visible,
        Callback = function(value) Library.KeybindFrame.Visible = value end,
    })
    
    MenuGroup:AddToggle("ShowCustomCursor", {
        Text = "自定义光标",
        Default = true,
        Callback = function(Value) Library.ShowCustomCursor = Value end,
    })
    
    MenuGroup:AddDropdown("NotificationSide", {
        Values = { "左侧", "右侧" },
        Default = "右侧",
        Text = "通知位置",
        Callback = function(Value)
            local side = Value == "左侧" and "Left" or "Right"
            Library:SetNotifySide(side)
        end,
    })
    
    MenuGroup:AddDropdown("DPIDropdown", {
        Values = { "50%", "75%", "85", "100%", "125%", "150%", "175%", "200%" },
        Default = "75%",
        Text = "DPI 缩放",
        Callback = function(Value)
            Value = Value:gsub("%%", "")
            local DPI = tonumber(Value)
            Library:SetDPIScale(DPI)
        end,
    })
    
    MenuGroup:AddDivider()
    
    MenuGroup:AddLabel("菜单绑定键")
        :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "菜单绑定键" })
    
    MenuGroup:AddButton('卸载脚本', function() 
    -- 关闭所有功能
    if nowe then
        toggleFly(false)
    end
    if isAntiSelfDamage then
        toggleAntiSelfDamage(false)
    end
    if isAntiKnockback then
        toggleAntiKnockback(false)
    end
    if isAntiRagdoll then
        toggleAntiRagdoll(false)
    end
    
    Library:Unload() 
end)
    
    Library.ToggleKeybind = Options.MenuKeybind
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
    ThemeManager:SetFolder("WTB")
    SaveManager:SetFolder("WTB/GutsAndBlackpowder")
    SaveManager:BuildConfigSection(Tabs["界面设置"])
    ThemeManager:ApplyToTab(Tabs["界面设置"])
    SaveManager:LoadAutoloadConfig()
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.7)
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    local humRootPart = char:FindFirstChild("HumanoidRootPart")
    
    if hum then
        hum.PlatformStand = false
    end
    
    if humRootPart then
        humRootPart.CanCollide = true
    end
    
    if char:FindFirstChild("Animate") then
        char.Animate.Disabled = false
    end
    
    nowe = false
    tpwalking = false
    speeds = 1
    
    if Options.SpeedSlider then
        Options.SpeedSlider:SetValue(1)
    end
    
    if Options.FlightToggle then
        Options.FlightToggle:SetValue(false)
    end
    
    if isAntiSelfDamage then
        if namecallHook1 then
            hookmetamethod(game, "__namecall", namecallHook1)
        end
        namecallHook1 = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod():lower()
            if self.Name == "ForceSelfDamage" and method == "fireserver" then
                return nil
            end
            return namecallHook1(self, ...)
        end))
    end
    
    if isAntiKnockback then
        if renderConnection then
            renderConnection:Disconnect()
        end
        renderConnection = RunService.RenderStepped:Connect(function(deltaTime)
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if not hum then return end
            
            local antiFlingObj = char:FindFirstChild("Anti-fling/LocalPlat")
            if antiFlingObj then
                antiFlingObj:Destroy()
            end
            
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        end)
    end
    
    if isAntiRagdoll then
        if namecallHook2 then
            hookmetamethod(game, "__namecall", namecallHook2)
        end
        namecallHook2 = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = { ... }
            if method == "SetStateEnabled" and typeof(self) == "Instance" and self:IsA("Humanoid") then
                local state = args[1]
                if state == Enum.HumanoidStateType.Ragdoll then
                    return namecallHook2(self, state, false)
                end
            end
            return namecallHook2(self, ...)
        end))
    end
end)
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and nowe then
        if input.KeyCode == Enum.KeyCode.Space then
            tis = RunService.RenderStepped:Connect(function()
                local humRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humRootPart then
                    humRootPart.CFrame = humRootPart.CFrame * CFrame.new(0, 1, 0)
                end
            end)
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            dis = RunService.RenderStepped:Connect(function()
                local humRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humRootPart then
                    humRootPart.CFrame = humRootPart.CFrame * CFrame.new(0, -1, 0)
                end
            end)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Space and tis then
            tis:Disconnect()
            tis = nil
        elseif input.KeyCode == Enum.KeyCode.LeftShift and dis then
            dis:Disconnect()
            dis = nil
        end
    end
end)
