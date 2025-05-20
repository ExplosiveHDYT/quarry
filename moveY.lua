rednet.open("top")

mainID = 69

isActive = false

function dig(x)

    isActive = true
    rednet.send(mainID, isActive, "moveY")

    if type(x) == "number" then

        time = (math.abs(x)/10)+0.2

        if x >= 0 then

            redstone.setOutput("left", true)
            sleep(time)
            redstone.setOutput("left", false)

            isActive = false
            rednet.send(mainID, isActive, "moveY")
        
        elseif x < 0 then

            redstone.setOutput("right", true)
            sleep(time+0.03)
            redstone.setOutput("right", false)
        
            isActive = false
            rednet.send(mainID, isActive, "moveY")

        end
        
    elseif type(x) == "string" then

        if x == "return" then

            redstone.setOutput("right", false)
            redstone.setOutput("left", true)
            sleep(0.2)

            isActive = false
            rednet.send(mainID, isActive, "moveY")

        elseif x == "stop" then

            redstone.setOutput("left", false)
            redstone.setOutput("right", false)
            sleep(0.2)

            isActive = false
            rednet.send(mainID, isActive, "moveY")
    
        end
    end
end

while true do

    id, ins, protocol = rednet.receive("moveY")
    
    dig(ins)
    ins = nil

    sleep(0.5)

    end
    
