local awful = require("awful")
local gears = require("gears")
local wibox = require "wibox"
local exit_manager = require(... .. ".exitscreen")
local start = require(... .. ".start")
-- local dash_manager = require(... .. ".dash")
-- local notif = require(... .. ".notif")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local awestore = require("awestore")

--[[
awesome.connect_signal("widgets::dashboard::show",
function() dash_manager.dash_show() end)
--]]

--[[
awesome.connect_signal("widgets::notif_panel::show", function(s)
    notif.screen = s
    notif.visible = not notif.visible
    awesome.emit_signal("widgets::notif_panel::status", notif.visible)
end)
--]]

awesome.connect_signal("widgets::exit_screen::show",
                       function() exit_manager.exit_screen_show() end)

-- start.placement = awful.placement.bottom_left
start.x = dpi(-450)
start.y = dpi(awful.screen.focused().geometry.height - 1000 -
                  beautiful.wibar_height + 2 - 48)
start.visible = true

local panel_anim = awestore.tweened(-450, {
    duration = 200,
    easing = awestore.easing.circ_in_out
})

panel_anim:subscribe(function(x) start.x = x end)

local start_close = true
awesome.connect_signal("widgets::start::show", function(s)
    start.screen = s
    start_close = not start_close

    if not start_close then
        start.visible = true
        panel_anim:set(-1)
    else
        panel_anim:set(-450)
        local timer = gears.timer {
            timeout = 0.21,
            single_shot = true,
            callback = function() start.visible = false end
        }:again()
    end

    awesome.emit_signal("widgets::start::status", start.visible)
end)
