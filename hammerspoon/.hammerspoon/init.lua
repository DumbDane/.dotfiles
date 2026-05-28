require("resize")
require("windowsize")
require("allwindows")
-- Reload Hammerspoon config with Ctrl+Shift+Opt+R
hs.hotkey.bind({"ctrl", "cmd"}, "R", function()
  hs.alert.show("🔄 Hammerspoon loading")
  hs.timer.doAfter(0.2, function()      -- wait 1 second
    hs.reload()
  end)
end)
