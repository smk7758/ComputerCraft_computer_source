--##################
-- Fishing program.
-- Author: smk7758
--##################

TIME_INTERVAL = 20
LONG_TO_CHEST = 2
CHEST_HIGHT = 2

--##################

function putChest()
CHEST_PLACE = 1
 for i=1, LONG_TO_CHEST do
  turtle.forward()
 end
 for i=1, 16 do
  turtle.select(i)
  ITEM_COUNT = turtle.getItemCount()
  isPUT_CHEST = turtle.drop(ITEM_COUNT)
  if not isPUT_CHEST then
   -- If: Can't put in chest.
   if CHEST_PLACE <= CHEST_HIGHT then
    turtle.up()
    CHEST_PLACE = CHEST_PLACE + 1
   else
    print("Chest: Error")
    print("Can't find a empty chests. Please make empty chest.")
    print("The program will stop after return home.")
   end
  end
 end
 turtle.select(1)
 if CHEST_PLACE ~= 1 then
 -- If: CHEST_PLACE is not fist number.
  for i=1, CHEST_PLACE do
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

function isItemFull()
 isFULL = {}
 for i=1, 16 do
  if turtle.getItemSpace(i) == 1 then
   isFULL[i] = true
  else
   isFULL[i] = false
  end
 end
 if isFULL[1] and isFULL[2] and isFULL[3] and isFULL[4] and isFULL[5] and isFULL[6] and isFULL[7] and isFULL[8] and isFULL[9] and isFULL[10] and isFULL[11] and isFULL[12] and isFULL[13] and isFULL[14] and isFULL[15] and isFULL[16] then
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
 print("Start checking item slots.")
 if isItemFull() then
  print("Slot: Error")
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
 isFISH = turtle.digDown()
  if not isFISH then
   print("Oops! I could't fish anything.")
  end
 print("Fish something.")
end