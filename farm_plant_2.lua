--##################
-- for 27x9 farm
-- Author: smk7758
--##################
-- Please set your farm size.
FARM_SIZE_A = 27
FARM_SIZE_B = 9
--##################
SEED_SLOT = 1
SEED_COUNT = 0

function fuel(FUEL_SUPPLY)
 turtle.turnRight()
 turtle.turnRight()
 local SUCCESS = turtle.suck(FUEL_SUPPLY / 80)
 if SUCCESS then
  print("Press any key to stop this program.")
  os.pullEvent("key")
  os.reboot()
 end
 turtle.refuel(FUEL_SUPPLY / 80)
 turtle.turnRight()
 turtle.turnRight()

 checkForJob()
end

function checkForJob()
 print("Start check for job.")

 -- # checkFuel #
 FARM_SIZE = FARM_SIZE_A * FARM_SIZE_B
 print("FarmSizeA: " .. FARM_SIZE_A)
 print("FarmSizeB: " .. FARM_SIZE_B)
 print("FarmSize: " .. FARM_SIZE)
 if turtle.getFuelLevel() >= FARM_SIZE then
  print("Fuel: OK")
 else
  FUEL_SUPPLY = FARM_SIZE - turtle.getFuelLevel()
  print("Fuel: Erorr")
  print("Not enough fuel. Please supply fuel: " .. FUEL_SUPPLY .. "\(in coal: " .. FUEL_SUPPLY / 80 .. "\)")
  print("Press any key to continue this program.")
  os.pullEvent("key")
  fuel(FUEL_SUPPLY)
 end

 -- # checkSeed #
 SEED_HAVE = 0
 for i=1, 16 do
  turtle.select(i)
  SEED_HAVE = SEED_HAVE + turtle.getItemCount()
 end
 if SEED_HAVE >= FARM_SIZE then
  print("Seed: OK")
 else
  SEED_SUPPLY = FARM_SIZE - SEED_HAVE
  print("Seed: Erorr")
  print("Not enough seed. Please supply seed: " .. SEED_SUPPLY)
  print("Press any key to move this program.")
  os.pullEvent("key")
  print("Continue.")
 end
end

-- SLOT Manage
function selectSeed()
 while turtle.getItemCount(SEED_SLOT) == 0 do
  SEED_SLOT = SEED_SLOT + 1
  -- Go to next SLOT
  if SEED_SLOT > 16 then
   os.reboot()
  end
 end
 turtle.select(SEED_SLOT)
end

function checkSeed()
 if not turtle.detectDown() then
  -- if: nothing down
  selectSeed()
 else
  print("The block is down.")
 end
end

-- get and put
function both()
 for i=1, FARM_SIZE_A - 1 do
  -- get
  local SUCCESS, BLOCK_DATA = turtle.inspectDown()
  if BLOCK_DATA.metadata == 7 then
   turtle.digDown()
  else
   print("The plant is not glown.")
  end
  -- put
  checkSeed()
  isPut = turtle.placeDown()
  if not isPut then
   print("Can't plant.")
  end
  -- move {
  turtle.forward()
  -- move }
 end
 -- LastLine
 -- get
 local SUCCESS, BLOCK_DATA = turtle.inspectDown()
 if BLOCK_DATA.metadata == 7 then
  turtle.digDown()
 else
  print("The plant is not glown.")
 end
 -- put
 checkSeed()
 isPut = turtle.placeDown()
 if isPut then
 SEED_COUNT = SEED_COUNT + 1
 else
  print("Can't plant.")
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

-- #################
-- Main

checkForJob()
sleep(1)
print("Start.")
turtle.forward()
both()
goRight()
both()
goLeft()
both()
goRight()
both()
goLeft()
both()
goRight()
both()
goLeft()
both()
goRight()
both()
goLeft()
both()
--##################
--Main_return
returnHome()
print("Complete.")
