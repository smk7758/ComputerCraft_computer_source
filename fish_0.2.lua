--##################
-- Fishing program.
-- Author: smk7758
--##################

TIME_INTERVAL = 20
LONG_TO_CHEST = 2
CHEST_HIGHT = 2

--##################

function printDebug(MSG)
if DEBUG_MODE then
print("Debug: " .. MSG)
end
end

function getFuel(FUEL_SUPPLY)
local FUEL_SUPPLY_FOR_GET = FUEL_SUPPLY / 80
printDebug("FUEL_SUPPLY: " .. FUEL_SUPPLY)
printDebug("FUEL_SUPPLY(for get): " .. FUEL_SUPPLY_FOR_GET)
local isGET_FUEL, ERROR_MSG = turtle.suck(FUEL_SUPPLY_FOR_GET)
if isGET_FUEL then
print("GetFuel: OK")
else
print("GetFuel: NG")
printDebug("Error message: " .. ERROR_MSG)
return false
end
local isREFUEL, ERROR_MSG = turtle.refuel(FUEL_SUPPLY_FOR_GET)
if isGET_FUEL then
print("Refuel: OK")
return true
else
print("Refuel: NG")
printDebug("Error message: " .. ERROR_MSG)
return false
end
end
checkFuel will stop after return home.")
end
end
end
turtle.select(1)
if CHEST_PLACE ~= 1 then
-- If: CHEST_PLACE is not fist number.
for i=1, CHEST_PLACE - 1 do
turtle.down()
end
end
for i=1, LONG_TO_CHEST do
turtle.back()
end
if not isPUT_CHEST and CHEST_PLACE <= CHEST_HIGHT then
-- Can't put in chest.
os.reboot()
else
print("Put all items to chest.")
end
end

function checkFuel()
if turtle.getFuelLevel() > LONG_TO_CHEST + 2 then
print("Fuel: OK")
return true, 0
end
-- if: fuel is not ok.
local FUEL_SUPPLY = 64 * 80
print("Fuel: NG")
print("Not enough fuel. Please supply fuel: " .. FUEL_SUPPLY .. "\(in coal: " .. FUEL_SUPPLY / 80 .. "\)")
return false, FUEL_SUPPLY
end

function isItemFull()
isFULL = {}
for i=1, 16 do
if turtle.getItemSpace(i) == 0 then
isFULL[i] = true
else
isFULL[i] = false
end
end
if (isFULL[1] or isFULL[2] or isFULL[3] or isFULL[4] or isFULL[5] or isFULL[6] or isFULL[7] or isFULL[8] or isFULL[9] or isFULL[10] or isFULL[11] or isFULL[12] or isFULL[13] or isFULL[14] or isFULL[15] or isFULL[16]) and turtle.getItemCount(16) > 0 then
-- If: All isFULL are full.
return true
else
return false
end
end

--##################
-- Main
print("If you want to stop this program, press \"Ctrl+T\" for a while time.")
while true do
print("Check fuel.")
if not checkFuel() then
turtle.turnLeft()
for i=1, LONG_TO_CHEST do
turtle.forward()
end
getFuel()
for i=1, LONG_TO_CHEST
turtle.back()
end
turtle.turnRight()
end

print("Start checking item slots.")
if isItemFull() then
print("Slot: NG")
print("Some item slots are full. Turtle is going to put items in chest.")
putChest()
else
print("Slot: OK")
end
isDOWN_WATER = turtle.attackDown()
if not isDOWN_WATER then
print("There is no water down turtle.")
print("Press any key to stop this program.")
os.pullEvent("key")
print("Reboot.")
os.reboot()
end
print("Start fishing.")
sleep(TIME_INTERVAL)
isFISH, msg = turtle.digDown()
if not isFISH then
print("Oops! I could't fish anything.")
print("Cause by: " .. msg .. " .")
end
print("Fish something.")
end
