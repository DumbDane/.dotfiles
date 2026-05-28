hs.hotkey.bind({"ctrl","alt","cmd"}, "i", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  print(hs.inspect(win:frame()))
  hs.alert.show(hs.inspect(win:frame()))
end)
hs.hotkey.bind({"ctrl","alt","cmd"}, "P", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local s = win:screen():frame()
  local f = win:frame()

  local fx = (f.x - s.x) / s.w
  local fy = (f.y - s.y) / s.h
  local fw = f.w / s.w
  local fh = f.h / s.h

  print(string.format("fx=%.3f, fy=%.3f, fw=%.3f, fh=%.3f", fx, fy, fw, fh))
  hs.alert.show("Fractions printed to console")
end)

