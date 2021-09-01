local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local cpu_bar = wibox.widget {
    max_value = 100,
    background_color = beautiful.xcolor0 .. 55,
    color = beautiful.xcolor8 .. 55,
    shape = helpers.rrect(beautiful.widget_border_radius),
    widget = wibox.widget.progressbar
}

awesome.connect_signal("signal::cpu", function(value) cpu_bar.value = value end)

return wibox.widget {
    cpu_bar,
    direction = 'east',
    widget = wibox.container.rotate
}
