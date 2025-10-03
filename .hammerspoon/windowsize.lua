hs.hotkey.bind({"ctrl","alt","cmd"}, "i", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  print(hs.inspect(win:frame()))
  hs.alert.show(hs.inspect(win:frame()))
end)
