rednet.open("top")
monitor = peripheral.wrap("left")
dC = nil

xID = 72
yID = 74
zID = 73

-- Collects data and returns coordinates and limits
function dataCollect()
    local id, pos, protocol = rednet.receive("gpsPosition")
    local id, mLim, protocol = rednet.receive("positionStatus")

    return {
        pos = pos,
        mLim = mLim,
        x = pos.x,
        y = pos.y,
        z = pos.z,
        mX = mLim.x,
        mY = mLim.y,
        mZ = mLim.z,
        mCap = mLim.cap
    }
    
end

-- Prints to terminal and monitor
function printToScreens(x, y, z, maxX, maxY, maxZ, maxCap)
    term.clear()
    term.setCursorPos(1, 1)

    monitor.clear()
    monitor.setCursorPos(1, 1)

    maxX = tostring(maxX)
    maxY = tostring(maxY)
    maxZ = tostring(maxZ)

    print(x, y, z)
    print(maxX, maxY, maxZ, maxCap)

    monitor.write("Current Position: x:"..x.." y:"..y.." z:"..z)
    monitor.setCursorPos(1, 3)
    monitor.write("Limits Reached:")
    monitor.setCursorPos(1, 4)
    monitor.write("x:"..maxX.." y:"..maxY.." z:"..maxZ.." cap:"..maxCap)
end

function dataPrint()
    dC = dataCollect()
    printToScreens(dC.x, dC.y, dC.z, dC.mX, dC.mY, dC.mZ, dC.mCap)
    return dC
end 




-- Base command functions ----------------------------------------------------

-- Send command to computerX
function commandX(x)

    rednet.send(xID, x, "moveX")

    local id, isActive, protocol = rednet.receive("moveX")
    while isActive do
        local id, msg, protocol = rednet.receive("moveX")
        isActive = msg
        sleep(0.1)
    end

    sleep(0.4)

end

-- Send command to computerZ
function commandZ(z)

    rednet.send(zID, z, "moveZ")

    local id, isActive, protocol = rednet.receive("moveZ")
    while isActive do
        local id, msg, protocol = rednet.receive("moveZ")
        isActive = msg
        sleep(0.1)
    end

    sleep(0.4)

end

-- Send command to computerY
function commandY(y)

    rednet.send(yID, y, "moveY")

    local id, isActive, protocol = rednet.receive("moveY")
    while isActive do
        local id, msg, protocol = rednet.receive("moveY")
        isActive = msg
        sleep(0.1)
    end

    sleep(0.4)

end

-- Base command functions ----------------------------------------------------



-- Defined Movement Functions ------------------------------------------------

-- Instruct ComputerX to move
function moveX(x)

    if type(x) == "number" then

        local initialBlocks = math.floor(math.abs(x)%10) 
        local repititions = math.floor(math.abs(x)/10)
        local inc = 1

        dC = dataPrint()

        if x > 0 then

            commandX(initialBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandX(10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mX == true
            end

        elseif x < 0 then

            commandX(-1*initialBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandX(-10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mX == true
            end
        end

    elseif type(x) == "string" then
        commandX(x)
    end
end

-- Instruct ComputerZ to move
function moveZ(z)

    if type(z) == "number" then

        local repititions = math.floor(math.abs(z)/10)
        local finalBlocks = math.floor(math.abs(z)%10) 
        local inc = 1

        dC = dataPrint()

        if z > 0 then

            commandZ(finalBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandZ(10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mZ == true
            end

        elseif z < 0 then

            commandZ(-1*finalBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandZ(-10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mZ == true    
            end
        end

    elseif type(z) == "string" then
        commandZ(z)
    end
end

-- Instruct ComputerY to move
function moveY(y)

    if type(y) == "number" then

        local repititions = math.floor(math.abs(y)/10)
        local finalBlocks = math.floor(math.abs(y)%10) 
        local inc = 1

        dC = dataPrint()

        if y > 0 then

            commandY(finalBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandY(10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mY == true
            end

        elseif y < 0 then

            commandY(-1*finalBlocks)
            dC = dataPrint()

            if repititions ~= 0 then
                repeat
                    commandY(10)
                    dC = dataPrint()
                    inc = inc + 1
                until inc > repititions or dC.mY == true
            end
        end

    elseif type(y) == "string" then
        commandY(y)
    end
end

-- Defined Movement Functions ------------------------------------------------



-- Movement Programs ---------------------------------------------------------

-- Returns to home and deposits items
function home()

    dC = dataPrint()

    moveY("return")
    while not dC.mY do
        dC = dataCollect()
        sleep(0.1)
    end
    sleep(0.1)
    moveY("stop")

    dC = dataPrint()

    moveY(-1)
    moveX(-1)
    moveZ(-1)

    dC = dataPrint()

    moveZ("-z")
    while not dC.mZ do
        dC = dataCollect()
        sleep(0.1)
    end
    sleep(0.1)
    moveZ("stop")

    dC = dataPrint()

    moveX("-x")
    while not dC.mX do
        dC = dataCollect()
        sleep(0.1)
    end
    sleep(0.1)
    moveX("stop")

    dC = dataPrint()

    redstone.setOutput("back", true)
    sleep(0.1)

    moveY("return")
    while not dC.mY do
        dC = dataCollect()
        sleep(0.1)
    end
    sleep(0.1)
    moveY("stop")

    redstone.setOutput("back", false)

    dC = dataPrint()

    sleep(0.4)

end

-- Retracts drill and moves to location
function moveTo(x,z)

    dC = dataPrint()

    if dC.mY == false then

        moveY("return")
        while not dC.mY do
            dC = dataCollect()
            sleep(0.1)
        end
        sleep(0.1)
        moveY("stop")

    end

    repeat

    dC = dataPrint()
    distX = (x - dC.x)
    distZ = (z - dC.z)

    moveX(distX)
    moveZ(distZ)

    until (distX == 0 and distZ == 0) or dC.mX == true or dC.mZ == true

    dC = dataPrint()

    sleep(0.4)

end

-- Drills specific location down to specified bound, or to bedrock -- returns when tank is full
function drillPosition(x,z,b)

    dC = dataPrint()

    bedrock = -58 -- 5 blocks above bedrock layer

    if b == nil then
        b = -999
    end

    moveTo(x,z)

    repeat

        commandY(-10)

        dC = dataPrint()
        if dC.mCap >= 14 then

            local x1 = dC.x
            local y1 = dC.y
            local z1 = dC.z

            home()
            move(x1,z1)
            
            dC = dataPrint()
            commandY(y - dC.y)

        end

    until dC.y <= b or dC.y <= bedrock

    home()
    
    dC = dataPrint()

    sleep(0.4)

end

-- Drills within a specified area
function drillArea(x1,z1,x2,z2,b)

    dC = dataPrint()

    local x1 = x1 + 4
    local z1 = z1 + 4
    local x2 = x2 - 4
    local z2 = z2 - 4

    moveTo(x2,z2)
    dC = dataPrint()

    if dC.mX == true then
        x2 = dC.x
    end

    if dC.mZ == true then
        z2 = dC.z
    end

    moveTo(x1,z1)
    dC = dataPrint()

    if dC.mX == true then
        x1 = dC.x
    end

    if dC.mZ == true then
        z1 = dC.z
    end

    local distX = x2 - x1
    local distZ = z2 - z1

    local initialX = math.floor(math.abs(distX)%9)
    local initialZ = math.floor(math.abs(distZ)%9)

    local zi = z1
    local xi = x1

    drillPosition(xi, zi, b)
    xi = xi + initialX
    while xi <= x2 do
        drillPosition(xi, zi, b)
        xi = xi + 9
    end
    xi = x1

    zi = z1 + initialZ
    while zi <= z2 do

        drillPosition(xi, zi, b)
        xi = xi + initialX
        while xi <= x2 do
            drillPosition(xi, zi, b)
            xi = xi + 9
        end
        xi = x1

        zi = zi + 9
    end
end
-- Movement Programs ---------------------------------------------------------



-- Main program -----------------------------------------------------------------------------------------------------------------------------------------------------

home()

while true do
    dC = dataPrint()
    sleep(0.5)
end
