rednet.open("top")

mainID = 69

isActive = false

function moveZ(x)

    isActive = true
    rednet.send(mainID, isActive, "moveZ")

    if type(x) == "number" then

        time = math.abs(x/10)+0.2
    
        if x <= 0 then   

            redstone.setOutput("right", true)
            sleep(time)
            redstone.setOutput("right", false)

            isActive = false
            rednet.send(mainID, isActive, "moveZ")
        
        elseif x > 0 then

            redstone.setOutput("left", true)
            sleep(time)
            redstone.setOutput("left", false)
            
            isActive = false
            rednet.send(mainID, isActive, "moveZ")

        end
    
    elseif type(x) == "string" then

        if x == "+z" then

            redstone.setOutput("right", false)
            redstone.setOutput("left", true)
            sleep(0.2)

            isActive = false
            rednet.send(mainID, isActive, "moveZ")
        
        elseif x == "-z" then

            redstone.setOutput("left", false)
            redstone.setOutput("right", true)
            sleep(0.2)

            isActive = false
            rednet.send(mainID, isActive, "moveZ")

        elseif x == "stop" then

            redstone.setOutput("left", false)
            redstone.setOutput("right", false)
            sleep(0.2)

            isActive = false
            rednet.send(mainID, isActive, "moveZ")
        
        end
    end
end

while true do

    id, ins, protocol = rednet.receive("moveZ")

    moveZ(ins)
    ins = nil

    sleep(0.5)

    end
