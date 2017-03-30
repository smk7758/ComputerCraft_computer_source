--##################
-- for 27x9 farm
-- Author: smk7758
--##################
FARM_SIZE_A = 27
FARM_SIZE_B = 9
SEED_COUNT = 1
SEED_SLOT = 1

-- SLOT Manage
function selectSeed()
 if SEED_COUNT > 64 then
  SEED_SLOT = SEED_SLOT + 1
  -- Go to next SLOT
  SEED_COUNT = 1
  turtle.select(SEED_SLOT)
 else
  turtle.select(SEED_SLOT)
 end
end

function checkSeed()
 if not turtle.detectDown() then
  -- if: nothing down
  selectSeed()
 else
  print("The block is down.")
 end
end

-- 植えていく。
function put()
 for i=1, FARM_SIZE_A - 1 do
  checkSeed()
  -- 植えS
  isPut = turtle.placeDown()
  -- 植える+結果報告。
  if isPut then
   -- 植えれた時。
   SEED_COUNT = SEED_COUNT + 1
  else
   print("Can't plant.")
  end
  -- 植えF
  turtle.forward()
 end
 -- #LastLine(A)
 checkSeed()
 -- S植え
 isPut = turtle.placeDown()
 -- 植える+結果報告。
 if isPut then
  -- 植えれた時。
  SEED_COUNT = SEED_COUNT + 1
 else
  print("Can't plant.")
 end
 -- F植え
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
print("Start.")
turtle.forward()

put()
goRight()
put()
goLeft()
put()
goRight()
put()
goLeft()
put()
goRight()
put()
goLeft()
put()
goRight()
put()
goLeft()
put()
--##################
--Main_return
returnHome()
print("Complete.")

-- # todo: make a checker! + 汎用性 #