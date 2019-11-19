--Start of Global Scope---------------------------------------------------------

--luacheck: globals timerHandle paramListener

-- Create parameter listener for TimerPeriod parameter (see .cid.xml file)
-- which is used to store the timer period. This parameter is also bound in the UI.
paramListener = Parameters.Listener.create()
paramListener:add("TimerPeriod")

-- Create a periodic timer, the handle needs to be hold so that the timer runs
timerHandle = Timer.create()
Timer.setExpirationTime(timerHandle, Parameters.get("TimerPeriod"))
Timer.setPeriodic(timerHandle, true)
local timerStarted = false
local counter  = 0

-- It is meaningful to evaluate the return value
if not timerHandle then
   Log.warning("Could not create the timer")
end

-- Serve event for UI binding on which the new counter value can be published
Script.serveEvent("Pages.OnNewCounter", "OnNewCounter")

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  Timer.start(timerHandle)
  timerStarted = true
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)


-- Called locally to set and publish the new counter value
local function setAndPublishCounter(newCount)
  counter = newCount
  -- Publish new counter value via the served event
  Script.notifyEvent("OnNewCounter", counter)
  print("Variable value:" .. counter)
end

-- Callback function which is called via the web page when pressing "Reset!"
local function resetCounter()
  setAndPublishCounter(0)
end
-- Serve the function resetCounter for http access
Script.serveFunction("Pages.resetCounter", resetCounter)

-- Callback function which is called via the web page when pressing the toggle button.
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

-- Callback function which is called via the web page on refresh.
local function getTimerStarted()
  return timerStarted
end
-- Serve the function getTimerStarted for http access
Script.serveFunction("Pages.getTimerStarted", getTimerStarted)


-- Definition of the callback function which is called periodically via the web page.
local function getCounter()
  return counter
end
-- Serve a function to get the counter for http access
Script.serveFunction("Pages.getCounter", getCounter)

-- Setter function which is called each time the value is manually changed by the user.
local function setCounter(newCount)
  setAndPublishCounter(newCount)
end
Script.serveFunction("Pages.setCounter", setCounter)

-- Callback function which is registered to the Timer and is called on every exipration
local function handleTimer()
  setAndPublishCounter(counter + 1)
end
Timer.register(timerHandle, "OnExpired", handleTimer)


-- Function which is called locally after "TimerPeriod" parameter change was detected
local function setTimerPeriod(period)
  print("Timer period set to " .. period)
  Timer.stop(timerHandle)
  Timer.setExpirationTime(timerHandle, period)
  if timerStarted then
    Timer.start(timerHandle)
  end
end

-- Callback function which registered to the Parameter listener and called every time the
-- "TimerPeriod" parameter has changed.
--@handleOnChanged()
local function handleOnChanged()
  local period = Parameters.get("TimerPeriod")
  setTimerPeriod(period)
end
Parameters.Listener.register(paramListener, "OnChanged", handleOnChanged)

--End of Function and EventScope------------------------------------------------
