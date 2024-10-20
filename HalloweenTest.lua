-- Function to find the relevant house front door's ClickDetector
local function getFrontDoorDetector(address)
    local house = workspace.Houses:FindFirstChild(address)
    if house and house:FindFirstChild("Doors") and house.Doors:FindFirstChild("FrontDoorMain") then
        return house.Doors.FrontDoorMain:FindFirstChild("ClickDetector")
    else
        return nil
    end
end

-- Function to teleport smoothly using a CFrame position
local function smoothTP(cf)
    local success, err = pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    end)
    
    if not success then
        warn("Teleportation failed: " .. tostring(err))
    end
end

-- Function to process a single house for trick-or-treating
local function processHouse(address)
    local frontDoorDetector = getFrontDoorDetector(address)

    -- Error check: If the front door's ClickDetector is not found
    if not frontDoorDetector then
        warn("Error: No ClickDetector found for house address: " .. address)
        return
    end

    -- Get the player's current position
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    -- Error check: If player’s HumanoidRootPart is missing
    if not root then
        warn("Error: Player's HumanoidRootPart not found!")
        return
    end

    -- Teleport to the front door position
    local doorPosition = frontDoorDetector.Parent.Position  -- Get position of the door
    smoothTP(doorPosition + Vector3.new(0, 7, 0))  -- Offset by 7 on Y-axis to avoid clipping
    wait(1)  -- Small wait after teleporting

    -- Check the distance to ensure proper teleportation
    local distance = (doorPosition - root.Position).Magnitude

    if distance > 9 then
        print("Player is too far from the door. Teleported to house address: " .. address)
    else
        print("Already close enough to house with address: " .. address)
    end

    -- Fire the front door's click detector (triggering trick-or-treat event)
    local success, err = pcall(function()
        frontDoorDetector.Detector:FireServer()
    end)

    if not success then
        warn("Failed to fire ClickDetector for house address: " .. address .. ": " .. tostring(err))
    else
        print("ClickDetector fired for house address: " .. address)
    end

    -- Wait 5 seconds between house actions
    wait(5)
end

-- Main function to loop through all house addresses (House1 to House12)
local function main()
    for i = 1, 12 do
        local houseAddress = "House" .. i  -- Address format should match game (e.g., "House1", "House2", etc.)
        processHouse(houseAddress)
    end

    print("Finished processing all houses.")
end

-- Start the main process
main()
