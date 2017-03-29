--##################
-- Fishing program.
-- Author: smk7758
--##################
TIME_INTERVAL = 35
--##################

print("If you want to stop this program, press \"Ctrl+T\" for a while time.")
while true do
 isDownWater = turtle.attackDown()
 if not isDownWater then
  print("There is no water down turtle.")
  print("Press any key to stop this program.")
  os.pullEvent("key")
  print("Reboot.")
  os.reboot()
 end
 print("Start fishing.")
 sleep(TIME_INTERVAL)
 isFish = turtle.digDown()
 print("Fish something.")
end