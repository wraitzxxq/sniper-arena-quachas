-- Temizlenmiş ve mantığı anlaşılır hale getirilmiş versiyon
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local CORRECT_KEY = "sniperdiego28"
local DISCORD_INVITE = "https://discord.gg/mAT6y8K4M2"
local SCRIPT_URL = "https://raw.githubusercontent.com/DiegoRRQ/sniper-arena/refs/heads/main/main"
-- Eski GUI varsa sil
if CoreGui:FindFirstChild("DiegoKey") then
    CoreGui.DiegoKey:Destroy()
end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiegoKey"
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui
-- Bildirim (notification) fonksiyonu
local function showNotification(title, message, success)
    local color = success and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
   
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 85)
    frame.Position = UDim2.new(1, -280, 0.85, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
   
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
   
    -- Sol renk çubuğu
    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 6, 1, 0)
    accent.BackgroundColor3 = color
    accent.BorderSizePixel = 0
    accent.Parent = frame
   
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 8)
   
    -- Başlık
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.Text = title:upper()
    titleLabel.TextColor3 = color
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 13
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
   
    -- Mesaj
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -20, 0, 20)
    msgLabel.Position = UDim2.new(0, 15, 0, 35)
    msgLabel.Text = message
    msgLabel.TextColor3 = Color3.fromRGB(180, 228, 255)
    msgLabel.Font = Enum.Font.GothamMedium
    msgLabel.TextSize = 15
    msgLabel.BackgroundTransparency = 1
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.Parent = frame
   
    -- Animasyon: sağdan gir → 1.5 sn bekle → aşağı kayarak çık
    frame:TweenPosition(UDim2.new(1, -280, 0.85, -100), "Out", "Back", 0.4, true)
   
    task.delay(2.5, function()
        frame:TweenPosition(UDim2.new(1, -280, 1.2, 0), "In", "Quart", 0.4, true)
        task.wait(0.45)
        frame:Destroy()
    end)
end
-- Ana anahtar giriş ekranı
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 330, 0, 240)
mainFrame.Position = UDim2.new(0.5, -165, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.2
stroke.Color = Color3.fromRGB(45, 45, 200)
stroke.Parent = mainFrame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame
-- Glow efekti (arka plan)
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Position = UDim2.new(0, -35, 0, -35)
glow.Size = UDim2.new(1, 70, 1, 70)
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = Color3.fromRGB(9, 0, 85)
glow.ImageTransparency = 0.5
glow.Parent = mainFrame
-- Başlık (BURADA DEĞİŞTİ)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 50)
titleLabel.Text = 'QUACHAS | SNIPER ARENA'
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = mainFrame
-- Input kutusu çerçevesi
local inputBox = Instance.new("Frame")
inputBox.Size = UDim2.new(0, 270, 0, 42)
inputBox.Position = UDim2.new(0.5, -135, 0, 70)
inputBox.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
inputBox.Parent = mainFrame
local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(35, 35, 35)
inputStroke.Parent = inputBox
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -16, 1, 0)
textBox.Position = UDim2.new(0, 8, 0, 0)
textBox.BackgroundTransparency = 1
textBox.PlaceholderText = "Enter key..."
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
textBox.Font = Enum.Font.GothamMedium
textBox.TextSize = 13
textBox.Parent = inputBox
-- Buton oluşturma yardımcı fonksiyonu
local function createButton(text, pos, bgColor, isMain, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 270, 0, 42)
    btn.Position = pos
    btn.BackgroundColor3 = bgColor
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.AutoButtonColor = false
    btn.Parent = mainFrame
   
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
   
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = bgColor:Lerp(Color3.new(1,1,1), 0.1)
        }):Play()
    end)
   
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = bgColor
        }):Play()
    end)
   
    btn.MouseButton1Click:Connect(callback)
end
-- CHECK KEY butonu
createButton("CHECK KEY", UDim2.new(0.5, -135, 0, 124), Color3.fromRGB(30, 30, 30), true, function()
    if textBox.Text == CORRECT_KEY then
        -- Başarılı animasyon
        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(0, 255, 100),
            Thickness = 2
        }):Play()
       
        showNotification("ACCES GRANTED", "Welcome!", true)
       
        -- Scripti yükle
        task.spawn(function()
            loadstring(game:HttpGet(SCRIPT_URL))()
        end)
       
        -- Ekranı kapat
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -165, 1.5, 0),
            BackgroundTransparency = 1
        }):Play()
       
        task.wait(0.45)
        screenGui:Destroy()
       
    else
        -- Yanlış → shake efekti + kırmızı
        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(255, 70, 70)
        }):Play()
       
        showNotification("INVALID", "Key entered is incorrect.", false)
       
        local originalPos = mainFrame.Position
        for i = 1, 6 do
            mainFrame.Position = originalPos + UDim2.new(0, math.random(-6,6), 0, math.random(-6,6))
            task.wait(0.01)
        end
        mainFrame.Position = originalPos
    end
end)
-- GET KEY butonu
createButton("GET KEY (DISCORD)", UDim2.new(0.5, -135, 0, 179), Color3.fromRGB(88, 101, 242), false, function()
    setclipboard(DISCORD_INVITE)
    showNotification("COPIED", "Discord Invite has been copied!", true)
end)
-- Pencereyi sürükleme (draggable)
local dragging, dragInput, dragStart, startPos
titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
-- Başlangıç bildirimi
showNotification("KEY SYSTEM READY", "Waiting for correct key...", true)