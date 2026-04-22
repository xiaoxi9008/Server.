local Env = getfenv()

local LogService = game:GetService("LogService")
local getconnections = Env.getconnections
local MessageOut = "MessageOut"
local cons = getconnections(LogService[MessageOut])
if cons then
    for _, v in pairs(cons) do
        pcall(function() v:Disable() end)
    end
end

local function cleanupConnections()
    pcall(function()
        
        for _, conn in ipairs(getconnections(LogService.MessageOut) or {}) do
            pcall(function() conn:Disable() end)
        end
    end)
end
cleanupConnections()

print("✅ 环境净化完成，LogService 干扰已禁用")


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)

    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/shenqin/refs/heads/main/ui.lua"))()
    end
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ConfigFileName = "XIAOXI_Script_Config.json"
local LastScriptKey = "LastScript"

-- ====================== 【作者配置】 ======================
local AUTHOR_NAME = "xiaoxi_919"
local SCRIPT_TAG = "XIAOXI_SCRIPT_USER"
local ShowXIAOXIUser = true -- 默认开启

-- 给脚本用户打标记
do
    local tag = Instance.new("StringValue")
    tag.Name = SCRIPT_TAG
    tag.Parent = LocalPlayer.PlayerGui
end

local function createTag(player, text)
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head or head:FindFirstChild("XIAOXI_Tag") then return end

    local bill = Instance.new("BillboardGui")
    bill.Name = "XIAOXI_Tag"
    bill.Size = UDim2.new(0, 200, 0, 50)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true
    bill.Parent = head

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1,1,1)
    txt.TextScaled = true
    txt.Text = text
    txt.Parent = bill
end

local function removeTag(player)
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if head and head:FindFirstChild("XIAOXI_Tag") then
        head.XIAOXI_Tag:Destroy()
    end
end

local function checkUsers()
    if not ShowXIAOXIUser then
        for _, plr in pairs(Players:GetPlayers()) do
            removeTag(plr)
        end
        return
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if not plr.PlayerGui:FindFirstChild(SCRIPT_TAG) then
            removeTag(plr)
            continue
        end

        if LocalPlayer.Name == AUTHOR_NAME then
            createTag(plr, plr.Name.." 【高级用户】")
        end
        if plr.Name == AUTHOR_NAME then
            createTag(plr, plr.Name.." 【作者】")
        end
    end
end

RunService.Heartbeat:Connect(checkUsers)

-- ========================================================

local function saveLastScript(scriptUrl, scriptName)
    local success, data = pcall(function()
        local content = readfile(ConfigFileName)
        if content and content ~= "" then
            return game:GetService("HttpService"):JSONDecode(content)
        end
        return {}
    end)
    
    if not success or not data then
        data = {}
    end
    
    data[LastScriptKey] = {
        url = scriptUrl,
        name = scriptName,
        timestamp = os.time()
    }
    
    local json = game:GetService("HttpService"):JSONEncode(data)
    writefile(ConfigFileName, json)
end

local function loadLastScript()
    local success, data = pcall(function()
        local content = readfile(ConfigFileName)
        if content and content ~= "" then
            return game:GetService("HttpService"):JSONDecode(content)
        end
        return nil
    end)
    
    if success and data and data[LastScriptKey] then
        return data[LastScriptKey]
    end
    return nil
end

local function executeScript(url, name, shouldSave)
    if shouldSave == nil then shouldSave = true end
    if shouldSave then
        saveLastScript(url, name)
    end
    
    if Window and Window.Destroy then
        Window:Destroy()
    end
    
    task.wait(0.1)
    loadstring(game:HttpGet(url))()
end

local function createUI()
    Window = WindUI:CreateWindow({
        Title = "<font color='#C0C0C0'>X</font><font color='#B0B0B0'>I</font><font color='#A0A0A0'>A</font><font color='#909090'>O</font><font color='#808080'>X</font><font color='#707070'>I</font>",
        Folder = "ftgshub",
        NewElements = true,
        HideSearchBar = false,
        Size = UDim2.fromOffset(200, 395),
        Theme = "Dark",
        UserEnabled = true,
        SideBarWidth = 135,
        HasOutline = true,
        Background = "https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/image_download_1776648555077.jpg",
        
        OpenButton = {
            Title = "<font color='#C0C0C0'>X</font><font color='#B0B0B0'>I</font><font color='#A0A0A0'>A</font><font color='#909090'>O</font><font color='#808080'>X</font><font color='#707070'>I</font>",
            CornerRadius = UDim.new(1,0),
            StrokeThickness = 2,
            Enabled = true,
            Draggable = true,
            OnlyMobile = false,
            Color = ColorSequence.new(
                Color3.fromRGB(80, 80, 80), 
                Color3.fromRGB(180, 180, 180)
            )
        },
        Topbar = {
            Height = 44,
            ButtonsType = "Mac",
        }
    })

    Window:Tag({
        Title = "选择版本",
        Color = Color3.fromRGB(150, 150, 150)
    })

    local Purple = Color3.fromRGB(120, 120, 130)
    local Yellow = Color3.fromRGB(200, 200, 100)
    local Green = Color3.fromRGB(100, 200, 100)
    local Grey = Color3.fromRGB(140, 140, 150)
    local Blue = Color3.fromRGB(100, 150, 220)
    local Red = Color3.fromRGB(220, 80, 80)

    local AboutTab = Window:Tab({
        Title = "公告",
        Desc = "脚本信息", 
        Icon = "solar:info-square-bold",
        IconColor = Grey,
        IconShape = "Square",
        Border = true,
    })

    AboutTab:Paragraph({
        Title = "欢迎使用 XIAOXI 脚本",
        Desc = "本人比较推荐v4.5.5这个经常更新",
        ImageSize = 50,
        Thumbnail = "https://raw.githubusercontent.com/xiaoxi9008/XIAOXIBUXINB/refs/heads/main/Image_1774762956572_963.jpg",
        ThumbnailSize = 170
    })

    AboutTab:Divider()

    AboutTab:Button({
        Title = "显示欢迎通知",
        Icon = "bell",
        Callback = function()
            WindUI:Notify({
                Title = "欢迎!",
                Content = "请选择版本",
                Icon = "heart",
                Duration = 3
            })
        end
    })

    -- ====================== 【开关：XIAOXI用户检测】 ======================
    AboutTab:Toggle({
        Title = "开启 XIAOXI 用户检测",
        Default = true, -- 默认开启
        Callback = function(state)
            ShowXIAOXIUser = state
        end
    })
    -- ====================================================================

    local ScriptTab = Window:Tab({
        Title = "选择版本",
        Desc = "点击即可",
        Icon = "solar:code-square-bold",
        IconColor = Green,
        IconShape = "Square",
        Border = true,
    })

    ScriptTab:Section({
        Title = "选择版本",
        Description = "点击下方按钮执行对应脚本"
    })

    ScriptTab:Button({
        Title = "v4.5.5自动检测服务器",
        Color = Color3.fromRGB(200, 70, 70),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            executeScript(
                "https://raw.githubusercontent.com/xiaoxi9008/Mysterious-coral./refs/heads/main/XIAOXI付费版服务器id.lua",
                "v4.5.5自动检测服务器"
            )
        end
    })

    ScriptTab:Button({
        Title = "v5.0.0加载器",
        Color = Color3.fromRGB(200, 70, 70),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            executeScript(
                "https://raw.githubusercontent.com/xiaoxi9008/Mysterious-coral./refs/heads/main/防止俄亥俄XIAOXI.lua",
                "v5.0.0加载器"
            )
        end
    })

    -- 黑白渐变边框动画
    local function startBlackWhiteBorder()
        task.wait(0.3)
        
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if not mainFrame then
            mainFrame = Window.Main
        end
        
        if not mainFrame then
            warn("无法找到窗口主框架")
            return
        end
        
        local corner = mainFrame:FindFirstChildOfClass(UICorner)
        if not corner then
            corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 16)
            corner.Parent = mainFrame
        end
        
        local oldStroke = mainFrame:FindFirstChild("BWStroke")
        if oldStroke then oldStroke:Destroy() end
        
        local colorScheme = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(100, 100, 100)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200, 200, 200)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(200, 200, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
        })
        
        local stroke = Instance.new("UIStroke")
        stroke.Name = "BWStroke"
        stroke.Thickness = 2
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.LineJoinMode = Enum.LineJoinMode.Round
        stroke.Enabled = true
        stroke.Transparency = 0
        stroke.Parent = mainFrame
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = colorScheme
        gradient.Rotation = 0
        gradient.Parent = stroke
        
        local angle = 0
        local animationConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not stroke or stroke.Parent == nil then
                animationConnection:Disconnect()
                return
            end
            angle = (angle + 60 * deltaTime) % 360
            gradient.Rotation = angle
        end)
        
        print("黑白渐变边框动画已启动")
    end

    startBlackWhiteBorder()
end

local lastScript = loadLastScript()

if lastScript and lastScript.url then
    
    WindUI:Popup({
        Title = "检测到上次版本",
        IconThemed = true,
        Content = string.format("是否继续使用上次使用的版本？\n【%s】", lastScript.name or "未知脚本"),
        Buttons = {
            {
                Title = "拒绝",
                Callback = function() 
                    createUI()
                end,
                Variant = "Secondary",
            },
            {
                Title = "确定",
                Icon = "arrow-right",
                Callback = function() 
                    if Window and Window.Destroy then
                        Window:Destroy()
                    end
                    task.wait(0.1)
                    loadstring(game:HttpGet(lastScript.url))()
                end,
                Variant = "Primary",
            }
        }
    })
else
    createUI()
end
