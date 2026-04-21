game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "因为你检测到防御",
  Text = "正在启动XIAOXI防御",
  Icon = "rbxassetid://123691280552142",
  Duration = 1,
  Callback = bindable,
  Button1 = "谢谢使用",
  Button2 = "😘",
})
wait(1.5)
game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "打开的时候会卡一下",
  Text = "卡密进群获取 ",
  Icon = "rbxassetid://123691280552142",
  Duration = 1,
  Callback = bindable,
  Button1 = "qq群：705378396",
  Button2 = "作者qq：3574769415",
})
local vu1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Potato5466794/Wind/refs/heads/main/Wind.luau"))()
local v2 = vu1:CreateWindow({
    Title = "XIAOXI防御",
    Icon = "rbxassetid://123691280552142",
    IconThemed = true,
    Author = "by小西",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(480, 380),
    Transparent = true,
    Theme = "Light",
    UserEnabled = true,
    SideBarWidth = 135,
    HasOutline = true,
    Transparent = true,
    Background = "video:https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/c4b2e0536c1c3cb8d947baae97dcf796.mp4",
        User = {
            Enabled = true,
            Callback = function()
                WindUI:Notify({
                    Title = "点击了自己",
                    Content = "没什么", 
                    Duration = 1,
                    Icon = "4483362748"
                })
            end,
            Anonymous = false
        },
    SideBarWidth = 200,
    ScrollBarEnabled = true
})

Window:Tag({
    Title = "防御",
    Color = Color3.fromHex("FF69B4")
})

WindUI.Themes.Dark.Button = Color3.fromRGB(255, 255, 255)  
WindUI.Themes.Dark.ButtonBorder = Color3.fromRGB(255, 255, 255)  

local function addButtonBorderStyle()
    local mainFrame = Window.UIElements.Main
    if not mainFrame then return end
    
    local styleSheet = Instance.new("StyleSheet")
    styleSheet.Parent = mainFrame
    
    local rule = Instance.new("StyleRule")
    rule.Selector = "Button, ImageButton, TextButton"
    rule.Parent = styleSheet
    
    local borderProp = Instance.new("StyleProperty")
    borderProp.Name = "BorderSizePixel"
    borderProp.Value = 1
    borderProp.Parent = rule
    
    local colorProp = Instance.new("StyleProperty")
    colorProp.Name = "BorderColor3"
    colorProp.Value = Color3.fromRGB(255, 255, 255)
    colorProp.Parent = rule
end

Window:CreateTopbarButton("theme-switcher", "moon", function()
    local themes_list = {"Dark", "Light", "Mocha", "Aqua"}
    currentThemeIndex = (currentThemeIndex % #themes_list) + 1
    local newTheme = themes_list[currentThemeIndex]
    WindUI:SetTheme(newTheme)
    WindUI:Notify({
        Title = "主题已切换",
        Content = "当前主题: "..newTheme,
        Duration = 2
    })
end, 990)

WindUI.Themes.Dark.Toggle = Color3.fromHex("FF69B4")
WindUI.Themes.Dark.Checkbox = Color3.fromHex("FFB6C1")
WindUI.Themes.Dark.Button = Color3.fromHex("FF1493")
WindUI.Themes.Dark.Slider = Color3.fromHex("FF69B4")

local COLOR_SCHEMES = {
    ["黑白渐变"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(64, 64, 64)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(128, 128, 128)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(192, 192, 192)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }), "palette"},
    
    ["黑白渐变2"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(100, 100, 100)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 180, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
    }), "waves"},
    
    ["灰白渐变"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 160, 160)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))
    }), "candy"},
}

Window:EditOpenButton({
    Title = "<font color='#FFFFFF'>X</font><font color='#DDDDDD'>I</font><font color='#BBBBBB'>A</font><font color='#999999'>O</font><font color='#777777'>X</font><font color='#555555'>I</font><font color='#888888'></font>",
    CornerRadius = UDim.new(16,16),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(128, 128, 128)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }),
    Draggable = true,
})

local function createRainbowBorder(window, colorScheme, speed)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end
    
    local existingStroke = mainFrame:FindFirstChild("RainbowStroke")
    if existingStroke then
        existingStroke:Destroy()
    end
    
    if not mainFrame:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 16)
        corner.Parent = mainFrame
    end
    
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowStroke"
    rainbowStroke.Thickness = 2
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Parent = mainFrame
    
    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    
    local schemeData = COLOR_SCHEMES[colorScheme or "黑白渐变"]
    if schemeData then
        glowEffect.Color = schemeData[1]
    else
        glowEffect.Color = COLOR_SCHEMES["黑白渐变"][1]
    end
    
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke
    
    return rainbowStroke
end

local function startBorderAnimation(window, speed)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end
    
    local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
    if not rainbowStroke then return nil end
    
    local glowEffect = rainbowStroke:FindFirstChild("GlowEffect")
    if not glowEffect then return nil end
    
    local animation = game:GetService("RunService").Heartbeat:Connect(function()
        if not rainbowStroke or rainbowStroke.Parent == nil then
            animation:Disconnect()
            return
        end
        
        local time = tick()
        glowEffect.Rotation = (time * speed * 60) % 360
    end)
    
    return animation
end

local borderAnimation
local borderEnabled = true
local currentColor = "黑白渐变"
local animationSpeed = 5

local rainbowStroke = createRainbowBorder(Window, currentColor, animationSpeed)
if rainbowStroke then
    borderAnimation = startBorderAnimation(Window, animationSpeed)
end


local v3 = v2:Tab({
    Title = "静默功能",
    Icon = "crosshair",
    Locked = false
})

v3:Button({
    Title = "绕过反作弊",
    Callback = function()
        local v4 = next
        local v5, v6 = getgc(true)
        while true do
            local v7
            v6, v7 = v4(v5, v6)
            if v6 == nil then
                break
            end
            if typeof(v7) == "function" and (getfenv(v7).script and (getfenv(v7).script.Parent == nil and not isourclosure(v7))) then
                local v8 = debug.info(v7, "s")
                if v8 ~= "[C]" and not (v8:find("Network") or v8:find("PlayerGui.Client")) then
                    hookfunction(v7, function()
                        return coroutine.yield()
                    end)
                end
            end
        end
    end
})

local vu9 = game:GetService("Workspace")
local vu10 = game:GetService("Players")
local v11 = game:GetService("RunService")
local vu12 = vu10.LocalPlayer
local vu13 = vu9.CurrentCamera
local vu14 = false
local vu15 = "Head"
local vu16 = 250
local vu17 = false
local vu18 = 100
local vu19 = nil
local vu20 = nil
local vu21 = 0
local vu22 = 0.1
local vu23 = Drawing.new("Circle")
vu23.Visible = false
vu23.Radius = vu16
vu23.Color = Color3.fromRGB(255, 255, 255)
vu23.Thickness = 1
vu23.Transparency = 1
vu23.Filled = false
vu23.Position = Vector2.new(vu13.ViewportSize.X / 2, vu13.ViewportSize.Y / 2)
local v24 = vu13
vu13.GetPropertyChangedSignal(v24, "ViewportSize"):Connect(function()
    vu23.Position = Vector2.new(vu13.ViewportSize.X / 2, vu13.ViewportSize.Y / 2)
end)


local SilentAimTeamCheck = {
    Enabled = false,
    AttributeName = "Team"
}

local function getSilentTeamAttribute(player)
    local attr = player:GetAttribute(SilentAimTeamCheck.AttributeName)
    if attr ~= nil then return attr end
    if player.Character then
        attr = player.Character:GetAttribute(SilentAimTeamCheck.AttributeName)
        if attr ~= nil then return attr end
    end
    return nil
end

local function isSilentTeammate(player)
    if not SilentAimTeamCheck.Enabled then return false end
    local myTeam = getSilentTeamAttribute(vu12)
    local theirTeam = getSilentTeamAttribute(player)
    if myTeam == nil or theirTeam == nil then
        return false
    end
    return myTeam == theirTeam
end



local function vu55(p53)
    local v54 = p53:FindFirstChild("PlayerStates")
    if v54 and v54:FindFirstChild("Team") then
        return v54.Team.Value
    else
        return nil
    end
end

local function vu59(p56)
    local v57 = vu55(vu12)
    local v58 = vu55(p56)
    return v57 ~= nil and v57 == v58
end


local function checkIsTeammate(player)
    if SilentAimTeamCheck.Enabled then
        return isSilentTeammate(player)
    else
        return vu59(player)
    end
end

local function vu42()
    if vu14 then
        local v25 = math.huge
        local v26 = vu13.CFrame
        local v27 = v26.Position
        local v28 = v26.LookVector
        local v29 = vu10
        local v30, v31, v32 = ipairs(v29:GetPlayers())
        local v33 = nil
        while true do
            local v34
            v32, v34 = v30(v31, v32)
            if v32 == nil then
                break
            end
            if v34 ~= vu12 then
                
                if checkIsTeammate(v34) then
                    continue
                end
                local v35 = v34.Character
                if v35 then
                    local v36
                    if vu15 ~= "随机" then
                        v36 = v35:FindFirstChild(vu15)
                    else
                        local v37 = {
                            "Head",
                            "HumanoidRootPart",
                            "Left Arm",
                            "Right Arm",
                            "Left Leg",
                            "Right Leg"
                        }
                        v36 = v35:FindFirstChild(v37[math.random(1, #v37)])
                    end
                    local v38 = v35:FindFirstChildOfClass("Humanoid")
                    if v36 and (v38 and (v38.Health > 0 and not v35:FindFirstChild("ForceField"))) then
                        local v39 = v36.Position - v27
                        local v40 = v39.Magnitude
                        if math.deg(math.acos(v28:Dot(v39.Unit))) <= vu16 / 10 and v40 < v25 then
                            if vu17 then
                                local v41 = RaycastParams.new()
                                v41.FilterDescendantsInstances = {
                                    vu12.Character,
                                    v35
                                }
                                v41.FilterType = Enum.RaycastFilterType.Blacklist
                                if not vu9:Raycast(v27, v39, v41) then
                                    v33 = v36
                                    v25 = v40
                                end
                            else
                                v33 = v36
                                v25 = v40
                            end
                        end
                    end
                end
            end
        end
        vu20 = v33
    else
        vu20 = nil
    end
end

v11.RenderStepped:Connect(function()
    if vu22 < tick() - vu21 then
        vu21 = tick()
        vu42()
    end
end)

local function vu43()
    return vu20
end

vu19 = hookmetamethod(game, "__namecall", function(p44, ...)
    local v45 = getnamecallmethod()
    if checkcaller() or (p44 ~= vu9 or v45 ~= "Raycast" and v45 ~= "FindPartOnRay") then
        return vu19(p44, ...)
    end
    local v46 = vu43()
    if v46 and math.random(1, 100) <= vu18 then
        local v47 = {
            ...
        }
        local v48 = nil
        local v49 = nil
        if v45 == "Raycast" then
            v48 = v47[1]
            v49 = v47[2]
        else
            local v50 = v47[1]
            if typeof(v50) == "Ray" then
                v48 = v50.Origin
                v49 = v50.Direction
            end
        end
        if v48 and v49 then
            return {
                Instance = v46,
                Position = v46.Position,
                Normal = (v46.Position - v48).Unit,
                Material = Enum.Material.Plastic
            }
        end
    end
    return vu19(p44, ...)
end)


local vu51 = false
local vu52 = Drawing.new("Line")
vu52.Visible = false
vu52.Thickness = 1
vu52.Transparency = 1
vu52.Color = Color3.fromRGB(255, 255, 255)

local function vu65(p60)
    local v61, v62 = vu13:WorldToViewportPoint(p60)
    if not v62 then
        return false
    end
    local v63 = v61.X - vu23.Position.X
    local v64 = v61.Y - vu23.Position.Y
    return v63 * v63 + v64 * v64 <= vu16 * vu16
end

v11.RenderStepped:Connect(function()
    if vu51 and vu14 then
        local v66 = vu20
        if v66 then
            local v67 = v66.Parent
            if v67 then
                local v68 = vu10:GetPlayerFromCharacter(v67)
                if v68 then
                    if checkIsTeammate(v68) then
                        vu52.Visible = false
                        return
                    else
                        local v69 = v67:FindFirstChildOfClass("Humanoid")
                        if v69 and v69.Health > 0 then
                            if vu17 then
                                local v70 = RaycastParams.new()
                                v70.FilterDescendantsInstances = {
                                    vu12.Character,
                                    v67
                                }
                                v70.FilterType = Enum.RaycastFilterType.Blacklist
                                if vu9:Raycast(vu13.CFrame.Position, v66.Position - vu13.CFrame.Position, v70) then
                                    vu52.Visible = false
                                    return
                                end
                            end
                            if vu15 == "随机" then
                                v66 = v67:FindFirstChild("HumanoidRootPart") or v66
                            end
                            local v71 = v66.Position
                            if vu65(v71) then
                                local v72, v73 = vu13:WorldToViewportPoint(v71)
                                if v73 then
                                    vu52.From = Vector2.new(vu23.Position.X, vu23.Position.Y)
                                    vu52.To = Vector2.new(v72.X, v72.Y)
                                    vu52.Visible = true
                                else
                                    vu52.Visible = false
                                end
                            else
                                vu52.Visible = false
                                return
                            end
                        else
                            vu52.Visible = false
                            return
                        end
                    end
                else
                    vu52.Visible = false
                    return
                end
            else
                vu52.Visible = false
                return
            end
        else
            vu52.Visible = false
            return
        end
    else
        vu52.Visible = false
        return
    end
end)


v3:Toggle({
    Title = "打开静默",
    Value = false,
    Callback = function(p74)
        vu14 = p74
        vu23.Visible = p74
        if not p74 then
            vu52.Visible = false
        end
    end
})

v3:Slider({
    Title = "fov范围",
    Value = {
        Min = 100,
        Max = 300,
        Default = 250
    },
    Callback = function(p75)
        vu16 = tonumber(p75)
        vu23.Radius = vu16
    end
})

v3:Dropdown({
    Title = "默认部位",
    Multi = false,
    AllowNone = false,
    Value = "Head",
    Values = {
        "头部",
        "身体",
        "左手臂",
        "右手臂",
        "左腿",
        "右腿",
        "随机"
    },
    Callback = function(p76)
        if p76 == "头部" then vu15 = "Head"
        elseif p76 == "身体" then vu15 = "HumanoidRootPart"
        elseif p76 == "左手臂" then vu15 = "Left Arm"
        elseif p76 == "右手臂" then vu15 = "Right Arm"
        elseif p76 == "左腿" then vu15 = "Left Leg"
        elseif p76 == "右腿" then vu15 = "Right Leg"
        elseif p76 == "随机" then vu15 = "随机"
        else vu15 = p76 end
    end
})

v3:Toggle({
    Title = "墙壁检测",
    Value = false,
    Callback = function(p77)
        vu17 = p77
    end
})

v3:Slider({
    Title = "秒杀概率",
    Value = {
        Min = 1,
        Max = 100,
        Default = 100
    },
    Callback = function(p78)
        vu18 = tonumber(p78)
    end
})

v3:Toggle({
    Title = "瞄人提示",
    Value = false,
    Callback = function(p79)
        vu51 = p79
        if not p79 then
            vu52.Visible = false
        end
    end
})

v3:Toggle({
    Title = "队伍检测",
    Value = false,
    Callback = function(state)
        SilentAimTeamCheck.Enabled = state
    end
})

local ESPTab = v2:Tab({
    Title = "透视功能",
    Icon = "eye",
    Locked = false
})


local ESPSection = ESPTab:Section({
    Title = "ESP 设置",
})

local vu88 = {}
local vu85 = false


local AttributesTeamCheck = {
    Enabled = false,           
    AttributeName = "Team"     
}

local function getTeamAttribute(player)
    local attr = player:GetAttribute(AttributesTeamCheck.AttributeName)
    if attr ~= nil then return attr end
    if player.Character then
        attr = player.Character:GetAttribute(AttributesTeamCheck.AttributeName)
        if attr ~= nil then return attr end
    end
    return nil
end

local function isTeammateByAttribute(player)
    if not AttributesTeamCheck.Enabled then return false end
    local myTeam = getTeamAttribute(game.Players.LocalPlayer)
    local theirTeam = getTeamAttribute(player)
    if myTeam == nil or theirTeam == nil then
        return false
    end
    return myTeam == theirTeam
end

local vu97 = function(player)
    return player.Team == game.Players.LocalPlayer.Team
end

local ESPSettings = {
    Enabled = true,
    TeamCheck = true,
    MaxDistance = 200,
    FontSize = 11,
    FadeOut = {
        OnDistance = true,
        OnDeath = false,
        OnLeave = false,
    },
    Options = {
        Teamcheck = false, TeamcheckRGB = Color3.fromRGB(0, 255, 0),
        Friendcheck = true, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false, HighlightRGB = Color3.fromRGB(255, 0, 0),
    },
    Drawing = {
        Names = {
            Enabled = true,
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Flags = {
            Enabled = true,
        },
        Distances = {
            Enabled = true,
            Position = "Text",
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Weapons = {
            Enabled = true, WeaponTextRGB = Color3.fromRGB(119, 120, 255),
            Outlined = false,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(255, 255, 255), GradientRGB2 = Color3.fromRGB(119, 120, 255),
        },
        Healthbar = {
            Enabled = true,
            HealthText = true, 
            Lerp = false, 
            HealthTextRGB = Color3.fromRGB(0, 255, 0),
            Width = 2.5,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(0, 255, 0),
            GradientRGB2 = Color3.fromRGB(0, 255, 0),
            GradientRGB3 = Color3.fromRGB(0, 255, 0),
        },
        Boxes = {
            Animate = false,
            RotationSpeed = 300,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(119, 120, 255),
            GradientRGB2 = Color3.fromRGB(0, 0, 0),
            GradientFill = false,
            GradientFillRGB1 = Color3.fromRGB(119, 120, 255),
            GradientFillRGB2 = Color3.fromRGB(0, 0, 0),
            Filled = {
                Enabled = true,
                Transparency = 0.75,
                RGB = Color3.fromRGB(0, 0, 0),
            },
            Full = {
                Enabled = true,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Corner = {
                Enabled = true,
                RGB = Color3.fromRGB(255, 255, 255),
            },
        },
    },
}

local Weapon_Icons = {
    ["Wooden Bow"] = "http://www.roblox.com/asset/?id=17677465400",
    ["Crossbow"] = "http://www.roblox.com/asset/?id=17677473017",
    ["Salvaged SMG"] = "http://www.roblox.com/asset/?id=17677463033",
    ["Salvaged AK47"] = "http://www.roblox.com/asset/?id=17677455113",
    ["Salvaged AK74u"] = "http://www.roblox.com/asset/?id=17677442346",
    ["Salvaged M14"] = "http://www.roblox.com/asset/?id=17677444642",
    ["Salvaged Python"] = "http://www.roblox.com/asset/?id=17677451737",
    ["Military PKM"] = "http://www.roblox.com/asset/?id=17677449448",
    ["Military M4A1"] = "http://www.roblox.com/asset/?id=17677479536",
    ["Bruno's M4A1"] = "http://www.roblox.com/asset/?id=17677471185",
    ["Military Barrett"] = "http://www.roblox.com/asset/?id=17677482998",
    ["Salvaged Skorpion"] = "http://www.roblox.com/asset/?id=17677459658",
    ["Salvaged Pump Action"] = "http://www.roblox.com/asset/?id=17677457186",
    ["Military AA12"] = "http://www.roblox.com/asset/?id=17677475227",
    ["Salvaged Break Action"] = "http://www.roblox.com/asset/?id=17677468751",
    ["Salvaged Pipe Rifle"] = "http://www.roblox.com/asset/?id=17677468751",
    ["Salvaged P250"] = "http://www.roblox.com/asset/?id=17677447257",
    ["Nail Gun"] = "http://www.roblox.com/asset/?id=17677484756"
}

local Workspace, RunService, Players, CoreGui = cloneref(game:GetService("Workspace")), cloneref(game:GetService("RunService")), cloneref(game:GetService("Players")), game:GetService("CoreGui")
local lplayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local Cam = Workspace.CurrentCamera
local ScreenGui = nil

local function Create(Class, Properties)
    local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
    for Property, Value in pairs(Properties) do
        _Instance[Property] = Value
    end
    return _Instance
end

local function FadeOutOnDist(element, distance)
    if not element then return end
    local transparency = math.max(0.1, 1 - (distance / ESPSettings.MaxDistance))
    if element:IsA("TextLabel") then
        element.TextTransparency = 1 - transparency
    elseif element:IsA("ImageLabel") then
        element.ImageTransparency = 1 - transparency
    elseif element:IsA("UIStroke") then
        element.Transparency = 1 - transparency
    elseif element:IsA("Frame") then
        element.BackgroundTransparency = 1 - transparency
    end
end

local function CreatePlayerESP(plr)
    if not ScreenGui then return end
    if vu88[plr] then return end

    local Name = Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Distance = Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Weapon = Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Box = Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Filled.RGB, BackgroundTransparency = 0.75, BorderSizePixel = 0})
    local Outline = Create("UIStroke", {Parent = Box, Enabled = true, Transparency = 0, Color = ESPSettings.Drawing.Boxes.Full.RGB, LineJoinMode = Enum.LineJoinMode.Miter})
    local Healthbar = Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0})
    local BehindHealthbar = Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
    local HealthText = Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = ESPSettings.Drawing.Healthbar.HealthTextRGB, Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
    local WeaponIcon = Create("ImageLabel", {Parent = ScreenGui, BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 40)})
    local LeftTop, LeftSide, RightTop, RightSide = Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local BottomSide, BottomDown, BottomRightSide, BottomRightDown = Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)}), Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESPSettings.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local Flag1, Flag2 = Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)}), Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESPSettings.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})

    local function HideESP()
        Box.Visible, Name.Visible, Distance.Visible, Weapon.Visible = false, false, false, false
        Healthbar.Visible, BehindHealthbar.Visible, HealthText.Visible = false, false, false
        WeaponIcon.Visible, LeftTop.Visible, LeftSide.Visible = false, false, false
        BottomSide.Visible, BottomDown.Visible, RightTop.Visible = false, false, false
        RightSide.Visible, BottomRightSide.Visible, BottomRightDown.Visible = false, false, false
        Flag1.Visible, Flag2.Visible = false, false
    end

    local connection = RunService.RenderStepped:Connect(function()
        if not ESPSettings.Enabled then
            HideESP()
            return
        end
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = plr.Character.HumanoidRootPart
            local Humanoid = plr.Character:FindFirstChild("Humanoid")
            if not Humanoid then return end
            local Pos, OnScreen = Cam:WorldToScreenPoint(HRP.Position)
            local Dist = (Cam.CFrame.Position - HRP.Position).Magnitude / 3.5714285714
            if OnScreen and Dist <= ESPSettings.MaxDistance then
                local Size = HRP.Size.Y
                local scaleFactor = (Size * Cam.ViewportSize.Y) / (Pos.Z * 2)
                local w, h = 3 * scaleFactor, 4.5 * scaleFactor

                if ESPSettings.FadeOut.OnDistance then
                    FadeOutOnDist(Box, Dist); FadeOutOnDist(Outline, Dist); FadeOutOnDist(Name, Dist)
                    FadeOutOnDist(Distance, Dist); FadeOutOnDist(Weapon, Dist); FadeOutOnDist(Healthbar, Dist)
                    FadeOutOnDist(BehindHealthbar, Dist); FadeOutOnDist(HealthText, Dist); FadeOutOnDist(WeaponIcon, Dist)
                    FadeOutOnDist(LeftTop, Dist); FadeOutOnDist(LeftSide, Dist); FadeOutOnDist(BottomSide, Dist)
                    FadeOutOnDist(BottomDown, Dist); FadeOutOnDist(RightTop, Dist); FadeOutOnDist(RightSide, Dist)
                    FadeOutOnDist(BottomRightSide, Dist); FadeOutOnDist(BottomRightDown, Dist)
                    FadeOutOnDist(Flag1, Dist); FadeOutOnDist(Flag2, Dist)
                end

               
                local shouldShowESP = false
                if AttributesTeamCheck.Enabled then
                    
                    shouldShowESP = not isTeammateByAttribute(plr)
                else
                    
                    if ESPSettings.TeamCheck and plr ~= lplayer and ((lplayer.Team ~= plr.Team and plr.Team) or (not lplayer.Team and not plr.Team)) then
                        shouldShowESP = true
                    elseif not ESPSettings.TeamCheck then
                        shouldShowESP = true
                    end
                end
                

                if shouldShowESP then
                    LeftTop.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                    LeftSide.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                    BottomSide.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                    BottomSide.Size = UDim2.new(0, 1, 0, h / 5)
                    BottomSide.AnchorPoint = Vector2.new(0, 5)
                    BottomDown.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                    BottomDown.Size = UDim2.new(0, w / 5, 0, 1)
                    BottomDown.AnchorPoint = Vector2.new(0, 1)
                    RightTop.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2)
                    RightTop.Size = UDim2.new(0, w / 5, 0, 1)
                    RightTop.AnchorPoint = Vector2.new(1, 0)
                    RightSide.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2)
                    RightSide.Size = UDim2.new(0, 1, 0, h / 5)
                    RightSide.AnchorPoint = Vector2.new(0, 0)
                    BottomRightSide.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                    BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5)
                    BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                    BottomRightDown.Visible = ESPSettings.Drawing.Boxes.Corner.Enabled
                    BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                    BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1)
                    BottomRightDown.AnchorPoint = Vector2.new(1, 1)

                    Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    Box.Size = UDim2.new(0, w, 0, h)
                    Box.Visible = ESPSettings.Drawing.Boxes.Full.Enabled
                    Box.BackgroundColor3 = ESPSettings.Drawing.Boxes.Filled.RGB
                    Box.BackgroundTransparency = ESPSettings.Drawing.Boxes.Filled.Enabled and ESPSettings.Drawing.Boxes.Filled.Transparency or 1
                    Outline.Color = ESPSettings.Drawing.Boxes.Full.RGB

                    local health = Humanoid.Health / Humanoid.MaxHealth
                    Healthbar.Visible = ESPSettings.Drawing.Healthbar.Enabled
                    Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health))
                    Healthbar.Size = UDim2.new(0, ESPSettings.Drawing.Healthbar.Width, 0, h * health)
                    BehindHealthbar.Visible = ESPSettings.Drawing.Healthbar.Enabled
                    BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2)
                    BehindHealthbar.Size = UDim2.new(0, ESPSettings.Drawing.Healthbar.Width, 0, h)
                    
                    if ESPSettings.Drawing.Healthbar.HealthText then
                        local healthPercentage = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100)
                        HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                        HealthText.Text = tostring(healthPercentage)
                        HealthText.Visible = Humanoid.Health < Humanoid.MaxHealth
                        HealthText.TextColor3 = ESPSettings.Drawing.Healthbar.HealthTextRGB
                    else
                        HealthText.Visible = false
                    end

                    Name.Visible = ESPSettings.Drawing.Names.Enabled
                    if ESPSettings.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                        Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s', ESPSettings.Options.FriendcheckRGB.R * 255, ESPSettings.Options.FriendcheckRGB.G * 255, ESPSettings.Options.FriendcheckRGB.B * 255, plr.Name)
                    else
                        Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s', 255, 0, 0, plr.Name)
                    end
                    Name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - h / 2 - 9)

                    if ESPSettings.Drawing.Distances.Enabled then
                        if ESPSettings.Drawing.Distances.Position == "Bottom" then
                            Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18)
                            WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15)
                            Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7)
                            Distance.Text = string.format("%d meters", math.floor(Dist))
                            Distance.Visible = true
                        elseif ESPSettings.Drawing.Distances.Position == "Text" then
                            Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8)
                            WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5)
                            Distance.Visible = false
                            if ESPSettings.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s [%d]', ESPSettings.Options.FriendcheckRGB.R * 255, ESPSettings.Options.FriendcheckRGB.G * 255, ESPSettings.Options.FriendcheckRGB.B * 255, plr.Name, math.floor(Dist))
                            else
                                Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s [%d]', 255, 0, 0, plr.Name, math.floor(Dist))
                            end
                            Name.Visible = ESPSettings.Drawing.Names.Enabled
                        end
                    end

                    Weapon.Text = "none"
                    Weapon.Visible = ESPSettings.Drawing.Weapons.Enabled
                else
                    HideESP()
                end
            else
                HideESP()
            end
        else
            HideESP()
        end
    end)
    vu88[plr] = {connection}
end

local function vu158()
    if ScreenGui then
        ScreenGui:Destroy()
        ScreenGui = nil
    end
    for _, conn in pairs(vu88) do
        if type(conn) == "table" then
            for _, c in ipairs(conn) do
                pcall(function() c:Disconnect() end)
            end
        else
            pcall(function() conn:Disconnect() end)
        end
    end
    vu88 = {}
    ESPSettings.Enabled = false
end

local function vu153()
    vu158()
    ESPSettings.Enabled = true
    ScreenGui = Create("ScreenGui", {Parent = CoreGui, Name = "ESPHolder"})
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= lplayer and not vu88[v] then
            CreatePlayerESP(v)
        end
    end
    
    vu88.PlayerAdded = Players.PlayerAdded:Connect(function(v)
        if v ~= lplayer and not vu88[v] then
            CreatePlayerESP(v)
        end
    end)
end

ESPSection:Toggle({
    Title = "总开关ESP", 
    Value = false, 
    Callback = function(state)
        vu85 = state
        if state then
            vu153() 
        else
            vu158() 
        end
    end
})

ESPSection:Toggle({
    Title = "队伍检测",
    Value = false,
    Callback = function(state)
        AttributesTeamCheck.Enabled = state
    end
})

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Config = {
    RageShootEnabled = false,
    RageShootMultiplier = 3,
    RageShootTarget = "Head",
    RageShootInterval = 0.001
}

local RageTeamCheck = {
    Enabled = false,
    AttributeName = "Team"
}

local function getRageTeamAttribute(player)
    local attr = player:GetAttribute(RageTeamCheck.AttributeName)
    if attr ~= nil then return attr end
    if player.Character then
        attr = player.Character:GetAttribute(RageTeamCheck.AttributeName)
        if attr ~= nil then return attr end
    end
    return nil
end

local function isRageTeammate(player)
    if not RageTeamCheck.Enabled then return false end
    local myTeam = getRageTeamAttribute(LocalPlayer)
    local theirTeam = getRageTeamAttribute(player)
    if myTeam == nil or theirTeam == nil then
        return false
    end
    return myTeam == theirTeam
end

local function getTeamFromPlayerStates(player)
    local ps = player:FindFirstChild("PlayerStates")
    if ps and ps:FindFirstChild("Team") then
        return ps.Team.Value
    end
    return nil
end

local function isPlayerStatesTeammate(player)
    local myTeam = getTeamFromPlayerStates(LocalPlayer)
    local theirTeam = getTeamFromPlayerStates(player)
    return myTeam ~= nil and myTeam == theirTeam
end

-- 统一的队友检测
local function checkIsRageTeammate(player)
    if RageTeamCheck.Enabled then
        return isRageTeammate(player)
    else
        return isPlayerStatesTeammate(player)
    end
end

local Events = {
    Handle = RS:WaitForChild("Events"):WaitForChild("HandleShots"),
    Anim = RS:WaitForChild("URE_ViewmodelAnimStream"),
    Damage = RS:WaitForChild("Events"):WaitForChild("\224\182\189\224\183\128\224\182\158\224\182\169")
}

local function playShootSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6534948092"
    sound.Volume = 1
    sound.Parent = Camera
    sound.PlayOnRemove = true
    sound:Destroy()
end

local function createBeam(startPos, endPos)
    local part1 = Instance.new("Part")
    part1.Anchored = true
    part1.CanCollide = false
    part1.Transparency = 1
    part1.Size = Vector3.new(0.1, 0.1, 0.1)
    part1.Position = startPos
    part1.Parent = Workspace

    local part2 = Instance.new("Part")
    part2.Anchored = true
    part2.CanCollide = false
    part2.Transparency = 1
    part2.Size = Vector3.new(0.1, 0.1, 0.1)
    part2.Position = endPos
    part2.Parent = Workspace

    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = part1
    local attachment2 = Instance.new("Attachment")
    attachment2.Parent = part2

    local beam1 = Instance.new("Beam")
    beam1.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
    beam1.Transparency = NumberSequence.new(0)
    beam1.Width0 = 0.25
    beam1.Width1 = 0.25
    beam1.Texture = "rbxassetid://7136858729"
    beam1.TextureSpeed = 0.8
    beam1.TextureMode = Enum.TextureMode.Wrap
    beam1.Brightness = 1
    beam1.LightEmission = 0
    beam1.FaceCamera = true
    beam1.Attachment0 = attachment1
    beam1.Attachment1 = attachment2
    beam1.Parent = part1

    local beam2 = Instance.new("Beam")
    beam2.Color = ColorSequence.new(Color3.fromRGB(180, 200, 255))
    beam2.Transparency = NumberSequence.new(0.4)
    beam2.Width0 = 0.12
    beam2.Width1 = 0.12
    beam2.Texture = "rbxassetid://7136858729"
    beam2.TextureSpeed = 1.2
    beam2.TextureMode = Enum.TextureMode.Wrap
    beam2.Brightness = 1.2
    beam2.LightEmission = 0.6
    beam2.FaceCamera = true
    beam2.Attachment0 = attachment1
    beam2.Attachment1 = attachment2
    beam2.Parent = part1

    local shaking = true
    task.spawn(function()
        while shaking and part1 and part1.Parent do
            attachment1.Position = Vector3.new(math.random(-3, 3) / 100, math.random(-3, 3) / 100, math.random(-3, 3) / 100)
            attachment2.Position = Vector3.new(math.random(-3, 3) / 100, math.random(-3, 3) / 100, math.random(-3, 3) / 100)
            task.wait(0.02)
        end
    end)

    task.delay(math.random(10, 40) / 10, function()
        shaking = false
        for i = 0, 1, 0.05 do
            if not part1 or not part1.Parent then break end
            beam1.Transparency = NumberSequence.new(i)
            beam2.Transparency = NumberSequence.new(0.4 + i * 0.6)
            task.wait(0.03)
        end
        pcall(function() part1:Destroy() end)
        pcall(function() part2:Destroy() end)
    end)
end

local function getShootOrigin()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        return hrp.Position + Vector3.new(0, 5, 0)
    end
    return nil
end

local function GetTarget()
    local target, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            
            if checkIsRageTeammate(p) then
                continue
            end
            if p.Character and p.Character:FindFirstChild(Config.RageShootTarget) then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local targetPart = p.Character[Config.RageShootTarget]
                    local origin = getShootOrigin()
                    if origin then
                        local d = (targetPart.Position - origin).Magnitude
                        if d < dist then
                            dist = d
                            target = p.Character
                        end
                    end
                end
            end
        end
    end
    return target
end

local function RageShot()
    local targetChar = GetTarget()
    local weaponObj = RS.Weapons:FindFirstChild("G-17")

    if targetChar and weaponObj then
        local targetPart = targetChar:FindFirstChild(Config.RageShootTarget)
        local origin = getShootOrigin()
        
        if targetPart and origin then
           
            playShootSound()
            createBeam(origin, targetPart.Position)
            
            
            Events.Handle:FireServer("2", "Shoot")
            Events.Anim:FireServer(true, "fire2", "fire")

            local hitData = {
                ["Normal"] = Vector3.new(-0.454, 0.225, 0.862),
                ["Hit"] = targetChar,
                ["PartName"] = Config.RageShootTarget,
                ["hS"] = 2.4494898319244385, 
                ["Position"] = targetPart.Position
            }

            local damageArgs = {
                [1] = hitData,
                [2] = weaponObj,
                [4] = true
            }

            for i = 1, Config.RageShootMultiplier do
                Events.Damage:FireServer(unpack(damageArgs))
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(Config.RageShootInterval)
        if Config.RageShootEnabled then
            pcall(RageShot)
        end
    end
end)

local ViolenceTab = v2:Tab({ 
    Title = "暴力", 
    Icon = "eye", 
    Locked = false 
}) 

ViolenceTab:Toggle({ 
    Title = "愤怒机器人", 
    Value = false, 
    Callback = function(state) 
        Config.RageShootEnabled = state 
    end 
})

ViolenceTab:Slider({ 
    Title = "伤害倍率", 
    Value = {
        Min = 1, 
        Max = 10, 
        Default = 3
    }, 
    Callback = function(value) 
        Config.RageShootMultiplier = tonumber(value)
    end 
})

ViolenceTab:Dropdown({ 
    Title = "目标部位", 
    Multi = false, 
    AllowNone = false, 
    Value = "Head", 
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, 
    Callback = function(value) 
        Config.RageShootTarget = value 
    end 
})

ViolenceTab:Toggle({ 
    Title = "队伍检测", 
    Value = false, 
    Callback = function(state) 
        RageTeamCheck.Enabled = state 
    end 
})

local v183 = v2:Tab({
    Title = "设置",
    Icon = "设置",
    Locked = false
})

local v184, v185, v186 = pairs(vu1:GetThemes())
local v187 = {}
while true do
    local v188
    v186, v188 = v184(v185, v186)
    if v186 == nil then
        break
    end
    table.insert(v187, v186)
end

v183:Dropdown({
    Title = "自定义背景颜色",
    Multi = false,
    AllowNone = false,
    Value = "Rainbow",  
    Values = v187,
    Callback = function(p189)
        vu1:SetTheme(p189)  
    end
})