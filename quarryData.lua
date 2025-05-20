rednet.open("bottom")

mainID = 69

while true do

x,y,z = gps.locate()

coordinates = {x = x, y = y, z = z}

maxLim = {
x = redstone.getInput("left"),
y = redstone.getInput("front"),
z = redstone.getInput("back"),
cap = redstone.getAnalogInput("right")
}

rednet.send(mainID, coordinates, "gpsPosition")
rednet.send(mainID, maxLim, "positionStatus")
print("Sent: ")
print(coordinates.x,coordinates.y,coordinates.z)
print(maxLim.x,maxLim.y,maxLim.z,maxLim.cap)
print(" ")
sleep(0.1)
end
