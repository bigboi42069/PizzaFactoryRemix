-- Function to find the relevant house part (e.g., to teleport to or interact with)
local function ffc(obj, child, recursive)
    return recursive and obj:FindFirstChildWhichIsA(child) or obj:FindFirstChild(child)
end

-- Function to retrieve the 'GiveCandy' or similar part from the house by address
local function getHousePart(address)
    local houses = workspace.Houses:GetChildren()
    for i = 1, #houses do
        local h = houses[i]
        -- Check if the house has an 'Address' value and matches the given address
        if ffc(h, "Address") and h.Address.Value == address and ffc(h, "Medium", true) then
            return h.Medium  -- Return the 'Medium' part where the front door is located
        end
    end
    return nil  -- Return nil if no match found
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
    local housePart = getHousePart(address)

    -- Error check: If 'Medium' part is not found
    if not housePart then
        warn("Error: No 'Medium' part found for house address: " .. address)
        return
    end

    -- Get the player's current position
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    -- Error check: If player’s HumanoidRootPart is missing
    if not root then
        warn("Error: Player's HumanoidRootPart not found!")
        return
    end

    -- Calculate the distance between the player and the house
    local distance = (housePart.Position - root.Position).Magnitude

    -- If the distance is greater than 9 studs, teleport the player to the house's 'Medium' part
    if distance > 9 then
        smoothTP(housePart.CFrame + Vector3.new(0, 7, 0))  -- Offset by 7 on Y-axis to avoid clipping
        wait(1)  -- Small wait after teleporting
    else
        print("Already close enough to house with address: " .. address)
    end

    -- Fire the front door's click detector (triggering trick-or-treat event)
    local frontDoor = housePart.Doors:FindFirstChild("FrontDoorMain") and housePart.Doors.FrontDoorMain:FindFirstChild("ClickDetector")

    -- Error check: If FrontDoorMain or ClickDetector is missing
    if not frontDoor then
        warn("Error: FrontDoorMain or ClickDetector not found for house address: " .. address)
        return
    end

    local success, err = pcall(function()
        frontDoor.Detector:FireServer()
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
