local repo = 'https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local playerName = game:GetService("Players").LocalPlayer.Name
Library:Notify({
    Title = "XIAOXI HUB",
    Description = "欢迎付费用户: " .. playerName .. " 丨 正在加载XIAOXI内脏与黑火药",
    Time = 6
})
local startTime = tick()      
loadstring(game:HttpGet('https://raw.githubusercontent.com/xiaoxi9008/Server./refs/heads/main/XIAOXI付费版GB.lua'))()
local endTime = tick()
local loadTime = string.format("%.2f", endTime - startTime)
Library:Notify({
    Title = "XIAOXI HUB",
    Description = "加载器加载完成！耗时: " .. loadTime .. "秒",
    Time = 6
})
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://85276853168939"
Sound.Parent = game:GetService("SoundService")
Sound.Volume = 5
Sound:Play()
Sound.Ended:Wait()
Sound:Destroy()