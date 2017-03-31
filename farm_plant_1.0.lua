--##################
-- for 27x9 farm
-- Author: smk7758
--##################
-- Please set your farm size.
PLACE_SIZE_HEIGHT = 27
PLACE_SIZE_WIDTH = 9
--##################
DEBUG_MODE = true
--##################
-- PLANT_MODE's mode.
-- if 0
--  Do all.
-- if 1
--  Chainge item every part of place and select items evety floor of Inv.
-- if 2
--  Continue untill out of items.
-- if 3
--  Only plant.
-- if 4
--  ...
PLANT_MODE = 0
--##################
arg1, arg2, arg3 = ...
-- PLACE_SIZE = H * W -- in need?
PLACE_SIZE = 0
MOVED_HEIGHT = 0
MOVED_WIDTH = 0
PLANT_COUNT = 0
ITEM_COUNT = 0

function printDebug(local MSG)
 if DEBUG_MODE then
  print("Debug: " .. MSG)
 end
end

function getFuel(local FUEL_SUPPLY)
 local FUEL_SUPPLY_FOR_GET = FUEL_SUPPLY / 80
 printDebug("FUEL_SUPPLY: " .. FUEL_SUPPLY)
 printDebug("FUEL_SUPPLY(for get): " .. FUEL_SUPPLY_FOR_GET)
 local isGET_FUEL, local ERROR_MSG = turtle.suck(FUEL_SUPPLY_FOR_GET)
 if isGET_FUEL then
  print("GetFuel: OK")
 else
  print("GetFuel: NG")
  printDebug("Error message: " .. ERROR_MSG)
  return false
 end
 local isREFUEL, local ERROR_MSG = turtle.refuel(FUEL_SUPPLY_FOR_GET)
 if isGET_FUEL then
  print("Refuel: OK")
  return true
 else
  print("Refuel: NG")
  printDebug("Error message: " .. ERROR_MSG)
  return false
 end
end

function checkForJobFuel()
 if turtle.getFuelLevel() >= PLACE_SIZE then
  print("Fuel: OK")
  return true, 0
 end
 -- if: fuel is not ok.
 local FUEL_SUPPLY = PLACE_SIZE - turtle.getFuelLevel()
 print("Fuel: NG")
 print("Not enough fuel. Please supply fuel: " .. FUEL_SUPPLY .. "\(in coal: " .. FUEL_SUPPLY / 80 .. "\)")
 return false, FUEL_SUPPLY
end

--未完成
function getItem(local FUEL_SUPPLY)
 local FUEL_SUPPLY_FOR_GET = FUEL_SUPPLY / 80
 printDebug("FUEL_SUPPLY: " .. FUEL_SUPPLY)
 printDebug("FUEL_SUPPLY(for get): " .. FUEL_SUPPLY_FOR_GET)
 local isGET_FUEL, local ERROR_MSG = turtle.suck(FUEL_SUPPLY_FOR_GET)
 if isGET_FUEL then
  print("GetFuel: OK")
 else
  print("GetFuel: NG")
  printDebug("Error message: " .. ERROR_MSG)
  return false
 end
 local isREFUEL, local ERROR_MSG = turtle.refuel(FUEL_SUPPLY_FOR_GET)
 if isGET_FUEL then
  print("Refuel: OK")
  return true
 else
  print("Refuel: NG")
  printDebug("Error message: " .. ERROR_MSG)
  return false
 end
end

-- MODE 未完成
function checkForJobItem()
 -- item counter
 if PLANT_MODE == 0
  -- 単純に数える。
  local ITEM_CHECK_COUNT = 0
  for local i_SLOT_COUNT = 1, 16  do
   ITEM_CHECK_COUNT = ITEM_CHECK_COUNT + turtle.getItemCount(i_SLOT_COUNT)
  end
  printDebug("ITEM_CHECK_COUNT: " .. ITEM_CHECK_COUNT)
  if ITEM_CHECK_COUNT >= PLACE_SIZE then
   print("Item: OK")
   return true, 0
  else
   print("Item: NG")
   print("Not enough seed. Please supply seed: " .. SEED_SUPPLY)
   local ITEM_SUPPLY = PLACE_SIZE - ITEM_CHECK_COUNT
   return false, ITEM_SUPPLY
  end
 elseif PLANT_MODE == 1
  -- 放置。
 elseif PLANT_MODE == 2
  -- 放置。
 end



 return true, 0
 
 return false, 
end

function checkForJobMain()
 printDebug("Start checking for job.")
 printDebug("PLACE_SIZE: " .. PLACE_SIZE)
 -- Fuel!
 local isFUEL, local FUEL_SUPPLY = checkForJobFuel()
 if not isFUEL then
  local isGET_FUEL = getFuel(FUEL_SUPPLY)
  if not isGET_FUEL then
   return false
  end
 end
 -- Item!
 local isITEM, local ITEM_SUPPLY = checkForJobItem()
 if not isITEM then
  local isGET_ITEM = getItem(ITEM_SUPPLY)
  if not isGET_ITEM then
   return false
  end
 end
 printDebug("Complete checking for job.")
 return true
end

function harvast()
  local isGET_DOWN_BLOCK_DATA, local BLOCK_DATA = turtle.inspectDown()
  if BLOCK_DATA.metadata == 7 then
   printDebug("The plant is glown.")
  else
   printDebug("The plant is not glown.")
   return false
  end
  local isHARVAST, local ERROR_MSG = turtle.digDown()
  if not isHARVAST then
   printDebug("Harvast: NG")
   printDebug("Error message: " .. ERROR_MSG)
   return false
  end
  return true
end

function isBlockDown()
 if turtle.detectDown() then
  printDebug("DownBlock: NG")
  return true
 else
  printDebug("DownBlock: OK")
  return false
 end
end

-- Must make for PLANT_MODE.(未完成)
function selectItem()
 local ITEM_SLOT = 0
 local isITEM_SELECT_SEARCH_FIRST = true
 while turtle.getItemCount(ITEM_SLOT) == 0 or turtle.getItemCount(ITEM_SLOT) == nil do
 -- when: ITEM_SLOT is empty.
  if ITEM_SLOT >= 16 then
   printDebug("Item slot is last in searching.")
   -- Slot is last or not correct number.
   if isITEM_SELECT_SEARCH_FIRST then
    -- if: Searching is first time.
    printDebug("Item slot is last, and first time searching.")
    ITEM_SLOT = 1
    isITEM_SELECT_SEARCH_FIRST = false
   else
    -- Searching is not first time.
    print("Turtle can't find item.")
    -- もーどによっては・・・。
    return false
   end
  else
   -- Slot is not last.
   ITEM_SLOT + 1
   -- Go to next SLOT
  end
 end
 local isSELECT_ITEM, local ERROR_MSG = turtle.select(ITEM_SLOT)
 if not isSELECT_ITEM then
  printDebug("SelectItem: NG")
  printDebug("Selecting did not move correctly.")
  printDebug("Error message: " .. ERROR_MSG)
  return false
 end
 printDebug("SelectItem: OK")
 return true
end

function plant()
 local isPLANT, local ERROR_MSG = turtle.placeDown()
 if isPLANT then
  -- 作付できた時。
  PLANT_COUNT = PLANT_COUNT + 1
  printDebug("Plant: OK")
 else
  printDebug("Plant: NG")
  printDebug("Error message:" .. ERROR_MSG)
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

function isLastHight()
 for i=1, PLACE_SIZE_WIDTH - 1 do
  if PLACE_SIZE_HEIGHT * i == MOVED_HEIGHT + 1 then
   -- 処理中=処理完了するまでは、MOVEDに+1されないため。
   return true
  else
   return false
  end
 end
end

function farmingMain()
 for local i_WIDTH = 1, PLACE_SIZE_WIDTH do
  for local i_HEIGHT = 1, PLACE_SIZE_HEIGHT do
   local isHARVAST = harvast()
   if not isHARVAST then
    return false

   if isBlockDown() then
    return false
   end
   -- checkItem?() - if: Slot is full.
   --[[
   if not checkItem() then
    return false
   end
   ]]--
   local isSELECT_ITEM = selectItem()
   if not isSELECT_ITEM then
    return false
   end
   local isPLANT = plant()
   if not isPLANT then
    return false
   end

   printDebug("i_WIDTH: " .. i_WIDTH .. ", MOVED_WIDTH: " .. MOVED_WIDTH)
   printDebug("i_HEIGHT: " .. i_HEIGHT ", MOVED_HEIGHT: " .. MOVED_HEIGHT)
   if isLastHight() then
    -- 縦: 最後の行。
    printDebug("isLastHight, true")
    if MOVED_WIDTH == PLACE_SIZE_WIDTH then
     printDebug("Last Line Of Width, true")
     -- 横: 最後の行。
     break
    else
     -- 横: 最後の行以外。
     printDebug("NotLastLineOfWidth.")
     -- goRight() or goLeft()
     -- 奇数だったら右へ、偶数だったら左へ。
     if MOVED_WIDTH + 1 % 2 ~= 0
      -- first, third...
      goRight()
     else
      goLeft()
     end
    end
   else
    -- 縦: 最後の行以外。
    printDebug("isLastHight, false")
    turtle.forward()
   end
   -- iでも良し？
   MOVED_HEIGHT = MOVED_HEIGHT + 1
   --   MOVED_HEIGHT = i_HEIGHT
  end
  MOVED_WIDTH = MOVED_WIDTH + 1
  --  MOVED_WIDTH = i_WIDTH
 end
 return true
end

-- 完全動作時のみOK = 他(途中停止時)はまだ -> 未完成, 関数も違う。
-- Error時の時とかね。
function returnHome()
 
 -- 完全動作時
 turtle.turnRight()
 for i=1, PLACE_SIZE_WIDTH - 1 do
  turtle.back()
 end
 turtle.turnLeft()
 for i=1, PLACE_SIZE_HEIGHT do
  -- 格納場所が畑真上ではない=畑の外のため、"-1"しない。
  turtle.back()
 end
end

--##################
-- Main
if (arg1 ~= nil or arg1 ~= 0) and arg1 == 1 then
-- 引数は1以外出来ない(現状)。
 PLANT_MODE = arg1
end
if arg2 ~= nil or arg2 ~= 0 then
 PLACE_SIZE_HEIGHT = arg2
end
if arg3 ~= nil or arg3 ~= 0 then
 PLACE_SIZE_WIDTH = arg3
end
PLACE_SIZE = PLACE_SIZE_HEIGHT * PLACE_SIZE_WIDTH

isCHECK_CLEAR = checkForJobMain()
if not isCHECK_CLEAR then
 -- stop
end
sleep(1)
isFARMING = farmingMain()
if not isFARMING then
 -- stop
end
returnHome()
print("Finish.")