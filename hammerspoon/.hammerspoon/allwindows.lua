-- Debug: list all visible windows
hs.hotkey.bind({"ctrl","alt","cmd"}, "L", function()
  local wins = hs.window.allWindows()
  for _, w in ipairs(wins) do
    print(string.format("App: %s | Title: %s", w:application():name(), w:title()))
  end
  hs.alert.show("Window list printed to Hammerspoon Console")
end)
