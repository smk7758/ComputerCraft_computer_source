--##################
-- This program moves turtle to next farm.
-- Author: smk7758
--##################
arg1, arg2, arg3 = ...
if arg1 == "r" or arg1 == "right" then
 print("Go right farm.")
 turtle.turnRight()
 for i=1, 9 do
  turtle.forward()
 end
 turtle.turnLeft()
elseif arg1 == "l" or arg1 == "left" then
 print("Go left farm.")
 turtle.turnLeft()
 for i=1, 9 do
  turtle.forward()
 end
 turtle.turnRight()
elseif arg1 == "rf" or arg1 == "right_farm" then
 print("Go right farm and do \"farm\".")
 turtle.turnRight()
 for i=1, 9 do
  turtle.forward()
 end
 turtle.turnLeft()
 print("Finish moving. Start \"farm\".")
 shell.run("farm")
elseif arg1 == "lf" or arg1 == "left_farm" then
 print("Go left farm and do \"farm\".")
 turtle.turnLeft()
 for i=1, 9 do
  turtle.forward()
 end
 turtle.turnRight()
 print("Finish moving. Start \"farm\".")
 shell.run("farm")
else
 print("Error: Please enter a argument.")
 print("Arguments list: right(r), left(l), right_farm(rf), left_farm(lf)")
end