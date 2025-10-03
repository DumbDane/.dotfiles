local mash = {"ctrl","alt","cmd"}

-- Fixed simulator width (from your capture)
local simWidth = 450

-- Shortcut: resize focused window to avoid the simulator area (on the right side)
hs.hotkey.bind(mash, "Z", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local screenFrame = win:screen():frame()

  -- Make window take the left portion of the screen, excluding sim area on the right
  local f = {
    x = screenFrame.x,
    y = screenFrame.y,
    w = screenFrame.w - simWidth,  -- reserve 444px for simulator on right
    h = screenFrame.h
  }

  win:setFrame(f)
end)

