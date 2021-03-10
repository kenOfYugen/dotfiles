local exit_manager = require(... .. ".exitscreen")
local start = require(... .. ".start")
-- local dash_manager = require(... .. ".dash")
local notif = require(... .. ".notif")

--[[
awesome.connect_signal("widgets::dashboard::show",
                       function() dash_manager.dash_show() end)
--]]

awesome.connect_signal("widgets::exit_screen::show",
                       function() exit_manager.exit_screen_show() end)

awesome.connect_signal("widgets::notif_panel::show", function(s)
    notif.screen = s
    notif.visible = not notif.visible
    awesome.emit_signal("widgets::notif_panel::status", notif.visible)
end)

awesome.connect_signal("widgets::start::show", function(s)
    start.screen = s
    start.visible = not start.visible
    awesome.emit_signal("widgets::start::status", start.visible)
end)
