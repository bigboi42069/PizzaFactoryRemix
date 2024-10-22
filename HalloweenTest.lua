-- CSWC REMIX 18/10/24
getupvalues = getupvalues or debug.getupvalues
setupvalue = setupvalue or debug.setupvalue
if not (getrawmetatable and getupvalues and setupvalue and (getreg or debug.getregistry)) then
	local h = Instance.new("Hint",workspace)
	h.Text = "Executor Error."
	wait(10)
	h:Destroy()
	return
end
local settings = {refill_at=50, refill_end=80, deliver_at=16, stay_in_kitchen=true}
local doDelivery = false

if getconnections then
	for _,c in next,getconnections(game:GetService("ScriptContext").Error) do
		c:Disable()
	end
end

local player = game:GetService("Players").LocalPlayer
local ffc = game.FindFirstChild
local RNG = Random.new()
local network
local character,root,humanoid
do
	local reg = (getreg or debug.getregistry)()
	for i=1,#reg do
		local f = reg[i]
		if type(f)=="function" then
			for k,v in next,getupvalues(f) do
				if typeof(v)=="Instance" then
					if v.Name=="CashOut" then
						setupvalue(f,k,{MouseButton1Click={wait=function()end,Wait=function()end}})
					end
				end
			end
			if tostring(getfenv(f)) == "Music" then
				local consts = getconstants(f)
				local loc=false
				for ci,c in next,consts do
					if c == "location changed" then
						loc=true
					elseif loc and c == "SendData" then
						setconstant(f,ci,"ExplodeString")
						break
					end
				end
			end
		elseif type(f)=="table" and rawget(f,"FireServer") and rawget(f,"BindEvents") then
			network = f
		end
	end
end
assert(network,"failed to find network")

Create = function(class,parent,props)
	local new = Instance.new(class)
	for k,v in next,props do
		new[k]=v
	end
	new.Parent = parent
	return new
end
gui=Create("ScreenGui",game.CoreGui,{Name="Farm", ZIndexBehavior="Sibling"})
main=Create("Frame",gui,{Name="main", Draggable=true, Active=true, Size=UDim2.new(0,100,0,50), Position=UDim2.new(.335,0,0.02,0), BackgroundColor3=Color3.new(0.098,0.098,0.098)})
topbar=Create("Frame",main,{Name="topbar", Size=UDim2.new(1,0,0.15,0), BackgroundColor3=Color3.new(0.255,0.255,0.255)})
closeBtn=Create("TextButton",topbar,{Name="closeBtn", TextWrapped=true, Size=UDim2.new(0.03,0,1,0), TextColor3=Color3.new(1,1,1), Text="X", BackgroundTransparency=1, 
	Font="GothamSemibold", Position=UDim2.new(0.96,0,0,0), TextSize=14, TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
titleLbl=Create("TextLabel",topbar,{Name="titleLbl", TextWrapped=true, Size=UDim2.new(0.5,0,1,0), Text="Trick Or Treat", TextSize=14, Font="GothamSemibold", 
	BackgroundTransparency=1, Position=UDim2.new(0.25,0,0,0), TextColor3=Color3.new(1,1,1), BackgroundColor3=Color3.new(1,1,1)})
saveBtn=Create("ImageButton",topbar,{Name="saveBtn", Image="rbxassetid://55687833", Size=UDim2.new(0.05,0,1,0), Position=UDim2.new(0.01,0,0,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(), Visible=writefile~=nil})
settings_1=Create("Frame",main,{Name="settings", BackgroundTransparency=1, Size=UDim2.new(0.97,0,0.75,0), Position=UDim2.new(0.025,0,0.2,0), BackgroundColor3=Color3.new(1,1,1)})
Layout=Create("UIGridLayout",settings_1,{VerticalAlignment="Center", SortOrder="LayoutOrder", HorizontalAlignment="Center", CellPadding=UDim2.new(0.01,0,0.1,0), CellSize=UDim2.new(0.325,0,0.26,0)})
delivery=Create("Frame",settings_1,{Name="delivery", LayoutOrder=5, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label_6=Create("TextLabel",delivery,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Start", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
deliveryBtn=Create("ImageButton",delivery,{Name="deliveryBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.333,0.333,0.333)})
deliverySlider=Create("Frame",deliveryBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doDelivery and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
messageLbl=Create("TextLabel",topbar,{Name="messageLbl", Size=UDim2.new(0.5,0,1,0), Text="Saved.", TextSize=14, Font="GothamSemibold", BackgroundTransparency=1, 
	Position=UDim2.new(0.07,0,0,0), TextColor3=Color3.new(1,1,1), Visible=false, TextXAlignment="Left"})
camframe=Create("Frame",gui,{Name="camframe", BackgroundTransparency=1, Size=UDim2.new(0,120,0,40), Position=UDim2.new(0.675,-400,0,-40), BackgroundColor3=Color3.new(0.118,0.118,0.118)})
rightCamBtn=Create("ImageButton",camframe,{Name="rightCamBtn", Image="rbxassetid://144168163", Size=UDim2.new(0.333,0,1,0), Rotation=180, Position=UDim2.new(0.666,0,0,0), BackgroundTransparency=1, 
	BackgroundColor3=Color3.new(1,1,1)})
leftCamBtn=Create("ImageButton",camframe,{Name="leftCamBtn", Image="rbxassetid://144168163", Size=UDim2.new(0.333,0,1,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(1,1,1)})
centerCamBtn=Create("ImageButton",camframe,{Name="centerCamBtn", Image="rbxassetid://58282192", Size=UDim2.new(0.333,0,1,0), Position=UDim2.new(0.333,0,0,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(1,1,1)})
creditLbl=Create("TextLabel",main,{Position=UDim2.new(0,0,1,4),Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),Text="by BallsNDeath",TextScaled=true,TextStrokeTransparency=.8})

local function toggleButtonColor(button)
    if button.BackgroundColor3 == Color3.new(0.333,0.333,0.333) then
        button.BackgroundColor3 = Color3.new(0.888,0.111,0.111)
    else
        button.BackgroundColor3 = Color3.new(0.333,0.333,0.333)
    end
end

local function toggleDelivery(bool)
	if bool~=nil then
		doDelivery=bool
	else
		doDelivery = not doDelivery
	end
	deliverySlider:TweenPosition(UDim2.new(doDelivery and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end

deliveryBtn.MouseButton1Click:Connect(function()
    toggleDelivery()
	toggleButtonColor(deliveryBtn)
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	doCashier,doBoxer,doCook,doSupplier,doDelivery = false,false,false,false,false
end)
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3=Color3.new(.9,0,0) end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3=Color3.new(1,1,1) end)
local cameraArray = {CFrame.new(23,14,65,0.629,0.386,-0.674,-0,0.867,0.497,0.777,-0.313,0.545),CFrame.new(39,15,83,-0.571,0.392,-0.720,-0,0.878,0.478,0.820,0.273,-0.502),CFrame.new(40,20,-38,-0.801,-0.229,0.552,-0,0.923,0.384,-0.598,0.307,-0.739),CFrame.new(51,15,-25,-0.707,0.338,-0.620,0,0.878,0.478,0.707,0.338,-0.620),CFrame.new(47,12,21,0.026,0.323,-0.945,-0,0.946,0.323,0.999,-0.008,0.024)}
local cameraIndex = 0
centerCamBtn.MouseButton1Click:Connect(function()
	centerCamBtn.BackgroundColor3 = Color3.new(0.111,0.888,0.111)
	wait(0.2)
	centerCamBtn.BackgroundColor3 = Color3.new(1,1,1)
	cameraIndex = 0
	workspace.CurrentCamera.CameraType = "Custom"
end)
leftCamBtn.MouseButton1Click:Connect(function()
	leftCamBtn.BackgroundColor3 = Color3.new(0.111,0.888,0.111)
	wait(0.2)
	leftCamBtn.BackgroundColor3 = Color3.new(1,1,1)
	cameraIndex = cameraIndex - 1
	if cameraIndex < 0 then
		cameraIndex = #cameraArray
	end
	if cameraIndex == 0 then
		workspace.CurrentCamera.CameraType="Custom"
	else
		local cf = cameraArray[cameraIndex]
		workspace.CurrentCamera.CameraType="Scriptable"
		workspace.CurrentCamera:Interpolate(cf,cf+cf.lookVector*10,0.5)
	end
end)
rightCamBtn.MouseButton1Click:Connect(function()
	rightCamBtn.BackgroundColor3 = Color3.new(0.111,0.888,0.111)
	wait(0.2)
	rightCamBtn.BackgroundColor3 = Color3.new(1,1,1)
	cameraIndex = cameraIndex + 1
	if cameraIndex > #cameraArray then
		cameraIndex = 0
		workspace.CurrentCamera.CameraType="Custom"
	else
		local cf = cameraArray[cameraIndex]
		workspace.CurrentCamera.CameraType="Scriptable"
		workspace.CurrentCamera:Interpolate(cf,cf+cf.lookVector*10,0.5)
	end
end)

local function smoothTP(cf)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
end

local function getHousePart(address)
	local houses = workspace.Houses:GetChildren()
	for i=1,#houses do
		local h = houses[i]
		if ffc(h,"Address") and h.Address.Value==address and ffc(h,"GivePizza",true) then
			return ffc(h,"GivePizza",true)
		end
	end
end
local function onCharacterAdded(char)
	if not char then return end
	character=char
	root = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	humanoid:SetStateEnabled("FallingDown",false)
end
onCharacterAdded(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(onCharacterAdded)

local function smoothTP2(cf)
	local cf0 = (cf-cf.p) + root.Position + Vector3.new(0,4,0)
	local diff = cf.p - root.Position
	local oldg = workspace.Gravity
	workspace.Gravity = 0
	for i=0,diff.Magnitude,0.9 do
		humanoid.Sit=false
		root.CFrame = cf0 + diff.Unit * i
		root.Velocity,root.RotVelocity=Vector3.new(),Vector3.new()
		wait()
	end
	root.CFrame = cf
	workspace.Gravity = oldg
end
for _,o in ipairs(workspace.Ovens:GetChildren()) do
	if ffc(o,"Bottom") then
		o.Bottom.CanTouch = false
	end
end

wait(0.1)

while gui.Parent do
	wait(0.5)
	humanoid.Sit=false
	if RNG:NextInteger(1,20)==1 then
		game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
		wait()
		game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
	end
	if doDelivery then
		local fatass=false
		for i = 1, 12 do
			if not doDelivery then
				break
			end
			humanoid.Sit=false
			local houseName = "House" .. i
            		local giver = getHousePart(houseName)  
			if giver then
				local ogp = giver.Position
				if (giver.Position-root.Position).Magnitude > 9 then
					smoothTP(giver.CFrame+Vector3.new(0,7,0))
					if giver.Parent==nil or (giver.Position-ogp).Magnitude>1 then
						giver = getHousePart(houseName) or giver
						smoothTP(giver.CFrame+Vector3.new(0,7,0))
					end
					wait(10)
					fatass=false
				else
					if fatass then
						wait(0.2)
					else
						wait(0.7)
					end
					wait()
					fatass=true
				end
			end
		end
		delTick = tick()
	end
end
