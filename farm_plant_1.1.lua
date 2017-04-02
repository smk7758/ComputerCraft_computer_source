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
-- args
arg1, arg2, arg3 = ...
if (arg1 ~= nil or arg1 ~= 0) and arg1 == 1 then
-- 引数は1以外出来ない(現状)。
 PLANT_MODE = arg1
end

if arg2 ~= nil and arg2 ~= 0 then
 PLACE_SIZE_HEIGHT = arg2
end

if arg3 ~= nil and arg3 ~= 0 then
 PLACE_SIZE_WIDTH = arg3
end
--##################
-- PLACE_SIZE = H * W -- in need?
PLACE_SIZE = 0
MOVED_HEIGHT = 0
MOVED_WIDTH = 0
PLANT_COUNT = 0
-- PLANTED_COUNT?
ITEM_COUNT = 0

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
function getItem(FUEL_SUPPLY)
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

-- MODE 未完成
function checkForJobItem()
 -- item counter
 if PLANT_MODE == 0 then
  -- Do all.
  local ITEM_CHECK_COUNT = 0
  for i_SLOT_COUNT = 1, 16  do
   printDebug("i_SLOT_COUNT: " .. i_SLOT_COUNT)
   -- Count itemss.
   ITEM_CHECK_COUNT = ITEM_CHECK_COUNT + turtle.getItemCount(i_SLOT_COUNT)
   -- Arrange items.
--   aa = iが16 + i___ で 17!!
   i_SLOT_ARRANGE_LIMIT = 16 - i_SLOT_COUNT
   if i_SLOT_COUNT ~= 16 then
    for i=1, i_SLOT_ARRANGE_LIMIT do
      printDebug("i: " .. i)
     if turtle.compareTo(i_SLOT_COUNT + i) then
      local ITEM_SPACE =  turtle.getItemSpace(i_SLOT_COUNT)
      if ITEM_SPACE ~= 0 then
       turtle.select(i_SLOT_COUNT + i)
       turtle.transferTo(i_SLOT_COUNT, ITEM_SPACE)
       turtle.select(i_SLOT_COUNT)
       printDebug("Items arranged.")
      end
     end
    end
   end
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
--[[
 elseif PLANT_MODE == 1 then
   -- item counter
  local ITEM_CHECK_COUNT = 0
  for i_SLOT_COUNT = 1, 4  do
   printDebug("i_SLOT_COUNT: " .. i_SLOT_COUNT)
   -- Count itemss.
   ITEM_CHECK_COUNT = ITEM_CHECK_COUNT + turtle.getItemCount(i_SLOT_COUNT)
   -- Arrange items.
--   aa = iが16 + i___ で 17!!
   i_SLOT_ARRANGE_LIMIT = 16 - i_SLOT_COUNT
   if i_SLOT_COUNT ~= 16 then
    for i=1, i_SLOT_ARRANGE_LIMIT do
      printDebug("i: " .. i)
     if turtle.compareTo(i_SLOT_COUNT + i) then
      local ITEM_SPACE =  turtle.getItemSpace(i_SLOT_COUNT)
      if ITEM_SPACE ~= 0 then
       turtle.select(i_SLOT_COUNT + i)
       turtle.transferTo(i_SLOT_COUNT, ITEM_SPACE)
       turtle.select(i_SLOT_COUNT)
       printDebug("Items arranged.")
      end
     end
    end
   end
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
]]--
--[[
  1~4
  5~8
  9~13
  14~16
  return true, 0
  -- 放置。
 elseif PLANT_MODE == 2 then
  -- 放置。
]]--
 end
end

function checkForJobMain()
 printDebug("Start checking for job.")
 printDebug("PLACE_SIZE: " .. PLACE_SIZE)
 -- Fuel!
 local isFUEL, FUEL_SUPPLY = checkForJobFuel()
 if not isFUEL then
  local isGET_FUEL = getFuel(FUEL_SUPPLY)
  if not isGET_FUEL then
   return false
  end
 end
 -- Item!
 local isITEM, ITEM_SUPPLY = checkForJobItem()
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
  local isGET_DOWN_BLOCK_DATA, BLOCK_DATA = turtle.inspectDown()
  if BLOCK_DATA.metadata == 7 then
   printDebug("The plant is glown.")
  else
   printDebug("The plant is not glown.")
   return false
  end
  local isHARVAST, ERROR_MSG = turtle.digDown()
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
 local ITEM_SLOT = 1
 local isITEM_SELECT_SEARCH_FIRST = true
 local SLOT_LIMIT = 16
 if PLANT_MODE == 1 then
  local PLANT_COUNT_NOW = PLANT_COUNT + 1
  for i=1, PLANT_COUNT_NOW, i * 4 do
   if i == PLANT_COUNT_NOW then
    ITEM_SLOT = 1
    SLOT_LIMIT = 4
     break
   elseif i + 1 == PLANT_COUNT_NOW then
    ITEM_SLOT = 5
    SLOT_LIMIT = 8
    break
   elseif i +2 == PLANT_COUNT_NOW then
    ITEM_SLOT = 9
    SLOT_LIMIT = 12
    break
   elseif i +3 == PLANT_COUNT_NOW then
    ITEM_SLOT = 13
    SLOT_LIMIT = 16
    break
   end
  end
 end
 while turtle.getItemCount(ITEM_SLOT) == 0 or turtle.getItemCount(ITEM_SLOT) == nil do
 -- when: ITEM_SLOT is empty.
  if ITEM_SLOT >= SLOT_LIMIT then
   printDebug("Item slot is last in searching.")
   -- Slot is last or not correct number.
   if isITEM_SELECT_SEARCH_FIRST then
    -- if: Searching is first time.
    printDebug("Item slot is last, and first time searching.")
    if PLANT_MODE ~= 1 then
     ITEM_SLOT = 1
     isITEM_SELECT_SEARCH_FIRST = false
    else
     -- Searching is not first time.
     print("Turtle can't find item.")
     -- もーどによっては・・・。
     return false
    end
   else
    return false
   end
  else
   -- Slot is not last.
   ITEM_SLOT = ITEM_SLOT + 1
   -- Go to next SLOT
  end
 end
 local isSELECT_ITEM, ERROR_MSG = turtle.select(ITEM_SLOT)
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
 local isPLANT, ERROR_MSG = turtle.placeDown()
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
 if PLACE_SIZE_HEIGHT == MOVED_HEIGHT then
  printDebug("Height: Last Line!!!")
  return true
 else
  printDebug("Height: NotLastLine.")
  return false
 end
end

function isLastWidth()
 if PLACE_SIZE_WIDTH == MOVED_WIDTH then
  -- 横: 最後の行。
  printDebug("Last Line Of Width, true")
  return true
 else
  -- 横: 最後の行以外。
  printDebug("NotLastLineOfWidth.")
  return false
 end
end

function moveNextWidth()
 -- goRight() or goLeft()
 -- 奇数だったら右へ、偶数だったら左へ。
 if MOVED_WIDTH % 2 == 0 then
  goLeft()
 else
  -- first, third...
  goRight()
 end
end

function farmingMain()
 turtle.forward()
 for i_WIDTH = 1, PLACE_SIZE_WIDTH do
  MOVED_WIDTH = i_WIDTH
  for i_HEIGHT = 1, PLACE_SIZE_HEIGHT do
   MOVED_HEIGHT = i_HEIGHT
   printDebug("i_WIDTH: " .. i_WIDTH .. ", MOVED_WIDTH: " .. MOVED_WIDTH)
   printDebug("i_HEIGHT: " .. i_HEIGHT .. ", MOVED_HEIGHT: " .. MOVED_HEIGHT)
   -- Harvast.
   local isHARVAST = harvast()
   if not isHARVAST then
    -- return false
   end
   if isBlockDown() then
    -- return false
   end
   -- checkItem?() - if: Slot is full.
   --[[
   if not checkItem() then
    return false
   end
   ]]--
   local isSELECT_ITEM = selectItem()
   if not isSELECT_ITEM then
    -- return false
   end
   -- Plant.
   local isPLANT = plant()
   if not isPLANT then
    -- return false
   end
   -- Move.
   if not isLastHight() then
    -- if: Not last hight.
    turtle.forward()
    --??
   else
    -- if: Last hight.
    printDebug("isLastHight, true")
    if not isLastWidth() then
     moveNextWidth()
    else
     break
    end
   end
  end
 end
 return true
end

-- 完全動作時のみOK = 他(途中停止時)はまだ -> 未完成, 関数も違う。
-- Error時の時とかね。
function returnHome()
 
 -- 完全動作時
 turtle.turnRight()
 for i=2, PLACE_SIZE_WIDTH do
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