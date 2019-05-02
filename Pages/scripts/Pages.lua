--[[----------------------------------------------------------------------------

  Application Name: Pages

  Description:
  Introduction for creating application specific user interfaces.

  This sample includes a specific user interface for its application. The application
  itself has just an integer variable which is incremented by a timer periodically.
  The user interface presents the incrementing variable and allows to reset it via
  the reset button.
  There are 2 different connections used for updating the variable on the page:
  1: request (get) mechanism (updated every 1000ms through polling). Can only be used
  uni-directional.
  2: WebSocket push/get (each time variable changes). Can be used bi-directional.

  How to demo this script:
  Connect a web-browser to the AppEngine (localhost address "127.0.0.1") and you will
  see the webpage of this sample. Use the reset-button to set the value to 0.
  Use the toggle-button to turn the increment-timer on/off. In off-state the value can
  be changed via the up/down buttons.

  The UI itself is created using the UI builder. It can be found by clicking the
  "Pages.msdd". In the dropdown menu at the upper right "sample" can be selected.
  More information can be found in the tutorials.

------------------------------------------------------------------------------]]

--Start of Global Scope---------------------------------------------------------

--luacheck: globals timerHandle

-- Serve get/set functions for web socket access
Script.serveEvent("Pages.OnNewCounter", "OnNewCounter")

-- Create a periodic timer and register the function "handleTimer" on it
timerHandle = Timer.create()
Timer.setExpirationTime(timerHandle, 100)
Timer.setPeriodic(timerHandle, true)
local timerStarted = false
local counter  = 0
-- The handle needs to be hold so that the timer runs
-- It is meaningful to evaluate the return value
if not timerHandle then
   print ("Could not create the timer")
end

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  Timer.start(timerHandle)
  timerStarted = true
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--@handleOnStarted()
local function handleOnStarted()
  -- TODO: Insert your event handling code here
end
Script.register("Engine.OnStarted", handleOnStarted)

-- Called locally to set and publish the new counter value
local function setAndPublishCounter(newCount)
  counter = newCount
  Script.notifyEvent("OnNewCounter",counter)  --publish value at once
  print("Variable value:" .. counter)
end

-- Definition of the callback function which is called via the web page when pressing "Reset!"
local function resetCounter()
  setAndPublishCounter(0)
end
-- Serve the function resetCounter for http access
Script.serveFunction("Pages.resetCounter", resetCounter)

-- Definition of the callback function which is called via the web page when pressing the toggle button.
local function toggleTimer(active)
  print("Timer toggled.")
  if active == true then
    Timer.start(timerHandle)
  else
    Timer.stop(timerHandle)
  end
  timerStarted = active
end
-- Serve the function toggleTimer for http access
Script.serveFunction("Pages.toggleTimer", toggleTimer)

-- Definition of the callback function which is called via the web page when when slider is moved.
local function setTimerPeriod(period)
  print("Timer period set to " .. period)
  Timer.stop(timerHandle)
  Timer.setExpirationTime(timerHandle, period)
  if timerStarted then
    Timer.start(timerHandle)
  end
end
-- Serve the function toggleTimer for http access
Script.serveFunction("Pages.setTimerPeriod", setTimerPeriod)

-- Definition of the callback function which is called periodically via the web page.
local function getCounter()
  return counter
end
-- Serve a function to get the counter for http access
Script.serveFunction("Pages.getCounter", getCounter)

-- Definition of the setter function which is called each time the value is changed by the user
local function setCounter(newCount)
  print("Variable set to " .. newCount)
  counter = newCount
end
Script.serveFunction("Pages.setCounter", setCounter)

-- Definition of the callback function which is registered to the Timer
local function handleTimer()
  setAndPublishCounter(counter + 1)
end
Timer.register(timerHandle, "OnExpired", handleTimer)

--End of Function and EventScope------------------------------------------------
