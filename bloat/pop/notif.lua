-- notif.lua
-- Notification Popup Widget
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local popupLib = require("utils.popupLib")

local popupWidget = wibox.widget {
    {
        require("bloat.notifs.notif-center"),
        margins = dpi(8),
        widget = wibox.container.margin
    },
    expand = "none",
    layout = wibox.layout.fixed.horizontal
}

local width = 400
local margin = 10

local popup = popupLib.create(awful.screen.focused().geometry.width - width,
                              beautiful.wibar_height, nil, width, popupWidget,
                              dpi(25), false, false, false, true)

popup:set_xproperty("WM_NAME", "notif-center")

return popup

-- EOF ------------------------------------------------------------------------
