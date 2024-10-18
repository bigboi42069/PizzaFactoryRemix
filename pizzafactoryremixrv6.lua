-- CSWC REMIX 18/10/24 V6
getupvalues = getupvalues or debug.getupvalues
setupvalue = setupvalue or debug.setupvalue
if not (getrawmetatable and getupvalues and setupvalue and (getreg or debug.getregistry)) then
	local h = Instance.new("Hint",workspace)
	h.Text = "Executor Error."
	wait(3)
	h:Destroy()
	return
end

local settings = {refill_at=20, refill_end=80, deliver_at=16, stay_in_kitchen=true}
local doCashier,doBoxer,doCook,doSupplier,doDelivery = false,false,false,false,false

if readfile then
	pcall(function()
		local new = game:GetService("HttpService"):JSONDecode(readfile("PizzaFarm.txt"))
		local doOverwrite=false
		for k,v in pairs(new) do
			if settings[k]==nil then
				doOverwrite=true
				new[k]=nil
			end
		end
		for k,v in pairs(settings) do
			if new[k]==nil then
				doOverwrite=true
				new[k]=v
			end
		end
		if doOverwrite then
			warn("Settings overwritten")
			writefile("PizzaFarm.txt",game:GetService("HttpService"):JSONEncode(new))
		end
		settings = new
	end)
end

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
					elseif v.Name=="StickerName" then
						setupvalue(f,k,nil)
					end
				end
			end

			if tostring(getfenv(f)) == "Music" then
				local consts = getconstants(f)
				local loc=false
				for ci,c in next,consts do
					if c == "location changed" then loc=true end 
					if loc and c == "SendData" then setconstant(f,ci,"ExplodeString") break end 
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
	for k,v in next,props do new[k]=v end 
	new.Parent = parent 
	return new 
end 

gui=Create("ScreenGui",game.CoreGui,{Name="Farm", ZIndexBehavior="Sibling"})
main=Create("Frame",gui,{Name="main", Draggable=true, Active=true, Size=UDim2.new(0,350,0,100), Position=UDim2.new(.335,0,0.02,0), BackgroundColor3=Color3.new(0.098,0.098,0.098)})
topbar=Create("Frame",main,{Name="topbar", Size=UDim2.new(1,0,0.15,0), BackgroundColor3=Color3.new(0.255,0.255,0.255)})
closeBtn=Create("TextButton",topbar,{Name="closeBtn", TextWrapped=true, Size=UDim2.new(0.03,0,1,0), TextColor3=Color3.new(1,1,1), Text="X", BackgroundTransparency=1,
	Font="GothamSemibold", Position=UDim2.new(0.96,0,0,0), TextSize=14, TextScaled=true})
titleLbl=Create("TextLabel",topbar,{Name="titleLbl", TextWrapped=true, Size=UDim2.new(0.5,0,1,0), Text="Pizza Factory Remix V6", TextSize=14,
	Font="GothamSemibold", BackgroundTransparency=1, Position=UDim2.new(0.25,0,0,0), TextColor3=Color3.new(1,1,1)})
saveBtn=Create("ImageButton",topbar,{Name="saveBtn", Image="rbxassetid://55687833", Size=UDim2.new(0.05,0,1,0), Position=UDim2.new(0.01,0,0,0),
	BackgroundTransparency=1})

settings_1=Create("Frame",main,{Name="settings", BackgroundTransparency=1,
	Size=UDim2.new(0.97,0,0.75,0), Position=UDim2.new(0.025,0,.2,.025)})

Layout=Create("UIGridLayout",settings_1,{VerticalAlignment="Center",
	SortOrder="LayoutOrder", HorizontalAlignment="Center",
	CellPadding=UDim2.new(0.01, 0,.1,.05), CellSize=UDim2.new(0.325,.05,.26,.05)})

cashier=Create("Frame",settings_1,{Name="cashier", LayoutOrder=4,
	BackgroundTransparency=1,
	Size=UDim2.new(0,.5,.5,.5)})

Label=Create("TextLabel",cashier,{TextWrapped=true,
	Size=UDim2.new(1,.5,.5,.5),
	Text="Cashier",
	TextSize=14,
	TextXAlignment="Left",
	Font="SourceSans",
	BackgroundTransparency=1,
	TextColor3=Color3.new(1,.9,.9)})

cashierBtn=Create("ImageButton",cashier,{Name="cashierBtn",
	ImageTransparency=.9,
	BorderSizePixel=0,
	Size=UDim2.new(.38,.5,.5,.5),
	BackgroundColor3=Color3.new(.392,.392,.392)})

cashierSlider=Create("Frame",cashierBtn,{Name="slider",
	Size=UDim2.new(.5,-4,.5,-4),
	Position=UDim2.new(doCashier and .5 or 0,-4,.5,-4),
    BorderSizePixel=0,
    BackgroundColor3=Color3.new(.784,.784,.784)})

kitchen=Create("Frame",settings_1,{Name="kitchen",
    LayoutOrder=9,
    BackgroundTransparency=.9,
    Size=UDim2.new(.25,.25,.25,.25)})

Label_2 = Create("TextLabel", kitchen,{
    TextWrapped=true,
    Size = UDim2.new(.6 ,  1 , .6 ,  1),
    Text = "Deliver At:",
    TextSize = 14,
    TextXAlignment = "Right",
    Font = "SourceSans",
    BackgroundTransparency = 1,
    TextColor3 = Color3.new(1 ,  .9 ,  .9),
})

deliverAtBox = Create("TextBox", kitchen,{
    Name = "deliverAtBox",
    TextWrapped=true,
    Size = UDim2.new(.25 ,  .25 , .25 ,  .25),
    Text=tostring(settings.deliver_at),
    TextSize = 50,
    Font = "Code",
    Position = UDim2.new(.62 ,  .62 , .62 ,  .62),
    BackgroundColor3 = Color3.new(.784 , .784 , .784),
})

refillEnd = Create("Frame", settings_1,{
    Name = "refillEnd",
    LayoutOrder = 8,
    BackgroundTransparency = 1,
    Size = UDim2.new(.25 , .25 , .25 , .25),
})

refillEndBox = Create("TextBox", refillEnd,{
	Name="refillEndBox",
	TextWrapped=true,
	Size=UDim2.new(.25 , .25 , .25 , .25),
	Text=tostring(settings.refill_end),
	TextSize=50,
	TextColor3=color3(),
	Font="Code",
})

Label_3 = Create("TextLabel", refillEnd,{
	TextWrapped=true,
	Size=UDim2.new(.6 , .6 , .6 , .6),
	Text="Refill End:",
	TextSize=14,
	TextXAlignment="Right",
	Font="SourceSans",
})

refillAt = Create("Frame", settings_1,{
	Name="refillAt",
	LayoutOrder={7},
	BackgroundTransparency={1},
})

Label_4=create('TextLabel', refillAt,{
	TextWrapped={true},
	size={udim2:new{.5},udim2:new{1}},
	text='Refill At:',
	textsize={14},
	textxalignment='right',
	font='sourceSans',
	backgroundtransparency={1},
	textcolor={color3:new{1}},
})

refillAtBox=create('TextBox', refillAt,{
	name='refillAtBox',
	textwrapped={true},
	size={udim2:new{.25},udim2:new{1}},
	text=tostring(settings.refill_at),
	textsize={50},
	textcolor={color3:new{}},
	font='code',
	position={udim2:new{.52},udim2:new{}} ,
	backgroundcolor={color3:new{.784}}
})

supplier=create('Frame', settings_1,{
	name='supplier',
	layoutorder={6},
	backgroundtransparency={true},
	size={udim2:new{100}},
	backgroundcolor={color3:new{}}
})

label_5=create('TextLabel', supplier,{
	textwrapped={true},
	size={udim2:new{.6},udim2:new{100}},
	text='Supplier',
	textsize={14},
	textxalignment='left',
	font='sourceSans',
	backgroundtransparency={true},
	position={udim2:new{100}},
	textcolor=color3:new{}
})

supplierBtn=create('ImageButton', supplier,{
	name='supplierBtn',
	imagetransparency={true},
	bordersizepixel={false},
	size={udim2:new{100}},
	backgroundcolor=color3:new{}
})

supplierSlider=create('Frame', supplierBtn,{
	name='slider',
	size={udim2:new{100}},
	borderSizePixel=false,
	backgroundcolor=color3:new{}
})

delivery=create('Frame', settings_1,{
	name='delivery',
	layoutorder={5},
	backgroundtransparency={true},
	size={udim2:new{100}},
	backgroundcolor=color3:new{}
})

label_6=create('TextLabel', delivery,{
	textwrapped={true},
	size={udim2:new{100}},
	text='Delivery',
	textsize={14},
	textxalignment='left',
	font='sourceSans',
	backgroundtransparency=false,
	position=false,
	textcolor=color3:new{}
})

deliveryBtn=create('ImageButton', delivery,{
	name='deliveryBtn',
	imagetransparency=false,
	bordersizepixel=false,
	size=false,
	backgroundcolor=color3:new{}
})

deliverySlider=create('Frame', deliveryBtn,{
	name='slider',
	size=false,
	borderSizePixel=false,
	backgroundcolor=color3:new{}
})

boxer=create('Frame', settings_1,{
	name='boxer',
	layoutorder=false,
	backgroundtransparency=false,
	size=false}
)

boxerLbl=create('TextLabel', boxer,{
	textwrapped=true,
	size=false,
	text='Boxer',
	textsize=false,
	font='sourceSans'
})

boxerBtn=create('ImageButton', boxer,{
	name='boxerBtn',
	imagetransparency=false,
	bordersizepixel=false,
	size=false}
)

boxerSlider=create('Frame', boxerBtn,{
	name='slider',
	size=false}
)

cook=create('Frame', settings_1,{
	name='cook',
	layoutorder=false}
)

cookLbl=create('TextLabel', cook,{
	textwrapped=true}
)

cookBtn=create('ImageButton', cook,{
	name='cookBtn'}
)

cookSlider=create('Frame', cookBtn,{
	name='slider'}
)

toggleAll=create('Frame', settings_1,{
	name='toggleAll'}
)

switch=create('Frame', toggleAll,{
	name='switch'}
)

allOffBtn=create('ImageButton', switch,{
	name='allOffBtn'}
)

allOnBtn=create('ImageButton', switch,{
	name='allOnBtn'}
)

toggleAllSlider=create('Frame', switch,{
	name='slider'}
)

messageLbl=create('TextLabel', topbar,{
	name='messageLbl'}
)


-- Functionality for cashier to take orders based on chat bubbles

local function detectCustomerOrder()
	for _, customer in pairs(workspace.Customers:GetChildren()) do
        local chatBubble = customer:FindFirstChild("ChatBubble")
        if chatBubble and chatBubble.Visible then
            processCashierOrder(customer)
            break -- Exit after processing one order to avoid spamming.
        end
    end 
end

local function processCashierOrder(customer)
	local order = getOrderFromChatBubble(customer.ChatBubble)
	network:FireServer("OrderComplete", customer.Name or customer.UserId or order)
end

-- Functionality for pizza slicing

local function slicePizza()
	pcall(function()
        network:FireServer("SlicePizza")
	end)
end

-- Functionality for boxing pizzas

local function boxPizza()
    network:FireServer("AddPizzaToBox")
	slicePizza()
	wait(0.15) -- Adjust timing as necessary.
    network:FireServer("ClosePizzaBox")
end

-- Delivery functionality

local function attemptDelivery()
	if #player.PlayerGui.MainGui.Delivery.Enabled.Pizzas:GetChildren() >= settings.deliver_at then 
        network:FireServer("StartDelivery")
        repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        repeat 
            network:FireServer("DeliverPizza")
            wait() -- Wait for the delivery animation to complete.
        until #player.PlayerGui.MainGui.Delivery.Enabled.Pizzas:GetChildren() == 0 
        network:FireServer("EndDelivery")
	end 
end 

-- Supplier functionality

local function getStockLevels()
	local levels={}
	for _, item in pairs(workspace.AllSupplies:GetChildren()) do levels[item.Name] = #item:GetChildren() end 
	return levels 
end 

local function restockItems()
	local stockLevels=getStockLevels()
	for item,count in pairs(stockLevels) do 
        if count < settings.refill_at then 
            local amountToRestock=settings.refill_end - count 
            for i = 1,(amountToRestock > 10 and 10 or amountToRestock) do -- Limit restocks to prevent lag.
                network:FireServer("RestockItem", item)
                wait() -- Prevent throttling.
            end 
        end 
	end 
end 

local function teleportExcessBoxesToVoid()
	for _, item in pairs(workspace.AllSupplies:GetChildren()) do 
        while #item:GetChildren() > settings.refill_end do 
            local box=item:FindFirstChild("BoxingBox")
            if box then 
                box.CFrame=CFrame.new(0,-10000,-10000) -- Teleport to void.
                wait() -- Prevent lag.
            else break end 
        end 
	end 
end 

-- Main loop to run all functionalities based on toggles.

while true do 
	wait(5) -- Adjust loop timing as necessary.
	if doCashier then detectCustomerOrder() end 
	if doCook then checkOvens() end -- Assuming checkOvens is defined elsewhere.
	if doDelivery then attemptDelivery() end 
	if doSupplier then restockItems(); teleportExcessBoxesToVoid() end  
end 
