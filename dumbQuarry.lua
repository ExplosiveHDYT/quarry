turtle.select(1)
turtle.refuel()
turtle.select(2)

-- placeDown OR digDown

action = turtle.digDown

function move(x, sel)
  for i =1,x do
    turtle.select(sel)
    turtle.forward()
    sleep(0.2)
    action()
    sleep(0.2)
  end
end

function turnRight()
  turtle.turnRight()
  sleep(0.2)
  turtle.forward()
  sleep(0.2)
  action()
  turtle.forward()
  sleep(0.2)
  action()
  sleep(0.2)
  turtle.turnRight()
  sleep(0.2)
end

function turnLeft()
  turtle.turnLeft()
  sleep(0.2)
  turtle.forward()
  sleep(0.2)
  action()
  turtle.forward()
  sleep(0.2)
  action()
  sleep(0.2)
  turtle.turnLeft()
  sleep(0.2)
end

function width(z)
  for i=1, z do
    move(length, 2)
    turnRight()
    move(length, 3)
    turnLeft()
  end
end


length = 15
width(15/3)




