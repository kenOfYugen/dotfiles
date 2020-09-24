local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local popupLib = require("utils.popupLib")

local popupWidget = wibox.widget {
    require("notifs.notif-center"),
    expand = "none",
    layout = wibox.layout.fixed.horizontal
}

local width = 400
local margin = 10

local popup = popupLib.create(awful.screen.focused().geometry.width - width - 5,
                              beautiful.wibar_height + 5, nil, width,
                              popupWidget)

return popup
