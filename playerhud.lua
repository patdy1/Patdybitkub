local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local userId = player.UserId

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "PlayerHUD"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 1000
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Frame
local frame = Instance.new("Frame")
frame.Name = "HUDFrame"
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.4
frame.BorderSizePixel = 0
frame.Size = UDim2.new(0, 140, 0, 60) -- ปรับสูงขึ้นนิดหน่อยให้พอดี
frame.AnchorPoint = Vector2.new(0, 0)
frame.Active = false
frame.Selectable = false
frame.Draggable = false
frame.Parent = gui

-- UI Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Avatar
local thumb = Instance.new("ImageLabel")
thumb.Name = "Avatar"
thumb.BackgroundTransparency = 1
thumb.Size = UDim2.new(0, 28, 0, 28)
thumb.Position = UDim2.new(0, 6, 0, 8)
thumb.Image = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
thumb.Parent = frame

-- ชื่อเล่น (อยู่บน)
local nicknameLabel = Instance.new("TextLabel")
nicknameLabel.Name = "NicknameLabel"
nicknameLabel.BackgroundTransparency = 1
nicknameLabel.Position = UDim2.new(0, 40, 0, 4)
nicknameLabel.Size = UDim2.new(1, -45, 0, 14)
nicknameLabel.Text = "ชื่อเล่น: " .. player.DisplayName
nicknameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nicknameLabel.TextXAlignment = Enum.TextXAlignment.Left
nicknameLabel.Font = Enum.Font.Gotham
nicknameLabel.TextSize = 10
nicknameLabel.Parent = frame

-- ชื่อจริง (อยู่ล่าง)
local realNameLabel = Instance.new("TextLabel")
realNameLabel.Name = "RealNameLabel"
realNameLabel.BackgroundTransparency = 1
realNameLabel.Position = UDim2.new(0, 40, 0, 18)
realNameLabel.Size = UDim2.new(1, -45, 0, 12)
realNameLabel.Text = "ชื่อจริง: " .. player.Name
realNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
realNameLabel.TextXAlignment = Enum.TextXAlignment.Left
realNameLabel.Font = Enum.Font.Gotham
realNameLabel.TextSize = 10
realNameLabel.Parent = frame

-- วันที่
local dateLabel = Instance.new("TextLabel")
dateLabel.Name = "DateLabel"
dateLabel.BackgroundTransparency = 1
dateLabel.Position = UDim2.new(0, 40, 0, 32)
dateLabel.Size = UDim2.new(1, -45, 0, 12)
dateLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
dateLabel.TextXAlignment = Enum.TextXAlignment.Left
dateLabel.Font = Enum.Font.Gotham
dateLabel.TextSize = 10
dateLabel.Parent = frame

-- เวลา
local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.BackgroundTransparency = 1
timeLabel.Position = UDim2.new(0, 40, 0, 45)
timeLabel.Size = UDim2.new(1, -45, 0, 12)
timeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 10
timeLabel.Parent = frame

-- อัปเดตวัน/เวลาแบบเรียลไทม์
RunService.RenderStepped:Connect(function()
	local now = os.date("*t")
	dateLabel.Text = ("วันที่: %02d/%02d/%04d"):format(now.day, now.month, now.year)
	timeLabel.Text = ("เวลา: %02d:%02d:%02d"):format(now.hour, now.min, now.sec)
end)

-- ปรับขนาดตัวอักษรอัตโนมัติตามขนาด HUD
frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	local w = frame.AbsoluteSize.X
	local small = w < 120
	nicknameLabel.TextSize = small and 9 or 10
	realNameLabel.TextSize = small and 9 or 10
	dateLabel.TextSize = small and 9 or 10
	timeLabel.TextSize = small and 9 or 10
end)

-- ปรับตำแหน่งให้อยู่บนซ้าย
local function updateHUDPosition()
	local topBarInset = GuiService:GetGuiInset()
	local offsetX, offsetY = 8, topBarInset.Y + 8
	frame.Position = UDim2.new(0, offsetX, 0, offsetY)
end

RunService.RenderStepped:Connect(updateHUDPosition)