local mash = {"ctrl","cmd"}

-- Fractions for vertical placement (still proportional)
local fy, fh = 0.017, 0.98
local gutter = 2  -- padding between main and simulator

hs.hotkey.bind(mash, "Z", function()
  local mainWin = hs.window.focusedWindow()
  if not mainWin then return end
  local screenFrame = mainWin:screen():frame()

  local simApp = hs.application.find("Simulator")
  if simApp then
    local simWin = simApp:mainWindow()
    if simWin then
      local s = simWin:screen():frame()
      local simFrame = simWin:frame()
      local simWidth = simFrame.w

      -- 1) Main window: stop 5px before the simulator
      local mainFrame = {
        x = screenFrame.x,
        y = screenFrame.y,
        w = screenFrame.w - simWidth - 2 * gutter,
        h = screenFrame.h,
      }
      mainWin:setFrame(mainFrame)

      -- 2) Simulator window: move to the right of the screen
      local f = {
        x = s.x + s.w - simWidth - gutter,
        y = s.y + fy * s.h,
        w = simWidth,
        h = fh * s.h,
      }
      simWin:setFrame(f)
    else
      hs.alert.show("Simulator window not found")
    end
  else
    hs.alert.show("Simulator app not found")
  end
end)

