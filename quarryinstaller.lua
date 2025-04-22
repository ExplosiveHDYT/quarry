-- installer.lua

local url = {
  main = "https://raw.githubusercontent.com/ExplosiveHDYT/quarry/refs/heads/main/main.lua",
  moveX = "https://raw.githubusercontent.com/ExplosiveHDYT/quarry/refs/heads/main/moveX.lua",
  moveY = "https://raw.githubusercontent.com/ExplosiveHDYT/quarry/refs/heads/main/moveY.lua",
  moveZ = "https://raw.githubusercontent.com/ExplosiveHDYT/quarry/refs/heads/main/moveZ.lua",
  quarryData = "https://raw.githubusercontent.com/ExplosiveHDYT/quarry/refs/heads/main/quarryData.lua"
}

print([[
Package?
 - main
 - moveX
 - moveY
 - moveZ
 - quarryData
]])

print("insert package name")
local name = read()

print("Install " .. name .. " as startup.lua? (y/n)")
if read() == "y" then
  if fs.exists("startup.lua") then
    fs.delete("startup.lua")
  end
  shell.run("wget", url[name], "startup.lua")
  print("Done.")
else
  print("Cancelled.")
end
