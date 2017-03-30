--##################
-- for 27x9 farm
-- Author: smk7758
--##################
-- Please set your farm size.
PLACE_SIZE_HEIGHT = 27
PLACE_SIZE_WIDTH = 9
--##################
DEBUG_MODE = true
-- PLACE_SIZE = H * W -- in need?
arg1, arg2, arg3 = ...
PLANT_MODE = 0
PLACE_SIZE = 0
MOVE_AMOUNT = 0
PLANT_COUNT = 0

function printDebug(local MSG)
 if DEBUG_MODE then
  print("Debug: " .. MSG)
 end
end

function getFuel(local FUEL_SUPPLY)
-- 取る時に必要・・・？(要検証)
 local FUEL_SUPPLY_FOR_GET = FUEL_SUPPLY / 80
 printDebug("FUEL_SUPPLY: " .. FUEL_SUPPLY)
 printDebug("FUEL_SUPPLY(for get): " .. FUEL_SUPPLY_FOR_GET)
 local SUCCESS_GET_FUEL = turtle.suck(FUEL_SUPPLY_FOR_GET)
 if SUCCESS_GET_FUEL then
  print("Turtle can't get any fuel.")
  print("Press any key to stop this program.")
  os.pullEvent("key")
  os.reboot()
 end
 turtle.refuel(FUEL_SUPPLY_FOR_GET)
end

function checkForJobFuel(local PLACE_SIZE)
 if turtle.getFuelLevel() >= SIZE then
  print("Fuel: OK")
  return true, 0
 end
 -- if: fuel is not ok.
 FUEL_SUPPLY = FARM_SIZE - turtle.getFuelLevel()
 print("Fuel: Erorr")
 print("Not enough fuel. Please supply fuel: " .. FUEL_SUPPLY .. "\(in coal: " .. FUEL_SUPPLY / 80 .. "\)")
 return false, FUEL_SUPPLY
end

function checkForJobItem(local ITEM)
 -- item counter
 if ~
 return true, 0
 
 return false, ITEM_SUPPLY
end

-- 未完成
function checkForJobMain(local PLACE_SIZE, local ITEM)
 printDebug("Start check for job.")
 printDebug("PLACE_SIZE: " .. PLACE_SIZE)
 local isFUEL, local FUEL_SUPPLY = checkForJobFuel(PLACE_SIZE)
 if isFUEL then
  print("Fuel: OK")
 else
  print("Fuel: NG")
  getFuel(FUEL_SUPPLY)
 end

 printDebug("ITEM: " .. ITEM)
 
end

-- SLOT Manage(未完成)
function selectItem()
 while turtle.getItemCount(SEED_SLOT) == 0 do
  SEED_SLOT = SEED_SLOT + 1
  -- Go to next SLOT
  if SEED_SLOT > 16 then
   os.reboot()
  end
 end
 turtle.select(SEED_SLOT)
end

function isNoBlockDown()
 if not turtle.detectDown() then
  print("DwonBlock: OK")
  return true
 else
  printDebug("DownBlock: NG")
  return false
 end
end

function goRight()
 turtle.turnRight()
 turtle.forward()
 turtle.turnRight()
end

function goLeft()
 turtle.turnLeft()
 turtle.forward()
 turtle.turnLeft()
end

--未完成
function plant()


end

--未完成
function returnHome()
 turtle.turnRight()
 for i=1, FARM_SIZE_B - 1 do
  turtle.back()
 end
 turtle.turnLeft()
 for i=1, FARM_SIZE_A do
  turtle.back()
 end
end

--##################
-- Main
if arg1 ~= nil or arg1 ~= 0 and arg1 == 0 or arg1 == 1 then
 PLANT_MODE = arg1
end
if arg2 ~= nil or arg2 ~= 0 then
 PLACE_SIZE_HEIGHT = arg2
end
if arg3 ~= nil or arg3 ~= 0 then
 PLACE_SIZE_WIDTH = arg3
end
PLACE_SIZE = PLACE_SIZE_HEIGHT * PLACE_SIZE_WIDTH
checkForJobMain(PLACE_SIZE, PLANT_MODE)
sleep(1)
harvast()
plant(PLACE_SIZE, PLANT_MODE)
returnHome()
print("Finish.")