local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi
local helpers = require('helpers')

local height = 900
local width = height

local start_angle = math.pi
local end_angle = 3 * math.pi / 2

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {150, 50}, -- replace with w,h later
    stops = {{0, beautiful.xcolor6}, {0.75, beautiful.xcolor14}}
}

local volume_arc = wibox.widget {
    max_value = 520,
    thickness = 20,
    start_angle = end_angle + math.pi / 15, -- 2pi*3/4
    rounded_edge = true,
    bg = beautiful.xbackground,
    paddings = 10,
    colors = {active_color},
    widget = wibox.container.arcchart
}

local vol_icon = {
    {
        markup = "<span foreground='" .. beautiful.xcolor6 ..
            "'><b></b></span>",
        font = beautiful.font_name .. '30',
        widget = wibox.widget.textbox
    },
    bottom = 795,
    left = 360,
    widget = wibox.container.margin
}

awesome.connect_signal("ears::volume", function(volume, muted)
    if muted then
        volume_arc.bg = beautiful.xcolor1
    else
        volume_arc.bg = beautiful.xbackground
    end

    volume_arc.value = volume
end)

local active_color2 = {
    type = 'linear',
    from = {0, 0},
    to = {150, 50}, -- replace with w,h later
    stops = {{0, beautiful.xcolor5}, {0.75, beautiful.xcolor13}}
}

local brightness_arc = wibox.widget {
    max_value = 520,
    thickness = 20,
    start_angle = end_angle + math.pi / 12.6, -- 2pi*3/4
    rounded_edge = true,
    bg = beautiful.xbackground,
    paddings = 10,
    colors = {active_color2},
    widget = wibox.container.arcchart
}

local bright_icon = {
    {
        markup = "<span foreground='" .. beautiful.xcolor5 ..
            "'><b></b></span>",
        font = beautiful.font_name .. '30',
        widget = wibox.widget.textbox
    },
    bottom = 670,
    left = 298,
    widget = wibox.container.margin
}

awesome.connect_signal("ears::brightness", function(value)
    if value >= 0 then brightness_arc.value = value end
end)

local vol = wibox.widget {vol_icon, volume_arc, layout = wibox.layout.stack}
vol:raise(2)
local bright = wibox.widget {
    bright_icon,
    brightness_arc,
    layout = wibox.layout.stack
}
bright:raise(2)
local widgetContainer = wibox.widget {
    {vol, margins = dpi(40), widget = wibox.container.margin},
    {bright, margins = dpi(100), widget = wibox.container.margin},
    forced_height = height,
    forced_width = width,
    layout = wibox.layout.stack
}

local widgetBG = wibox.widget {
    widgetContainer,
    border_width = beautiful.widget_border_width,
    border_color = beautiful.widget_border_color,
    bg = beautiful.xbackground,
    shape = helpers.pie(height, width, start_angle, end_angle, height / 2),
    widget = wibox.container.background
}

local popupWidget = awful.popup {
    screen = screen.primary,
    widget = widgetBG,
    visible = false,
    ontop = true,
    x = awful.screen.focused().geometry.width - width / 2,
    y = awful.screen.focused().geometry.height - height / 2 -
        beautiful.wibar_height - 3,
    bg = beautiful.xbackground .. "00"
    -- shape = helpers.rrect(beautiful.client_radius),
    -- border_width = beautiful.widget_border_width,
    -- border_color = beautiful.widget_border_color
}

local mouseInPopup = false
local timer = gears.timer {
    timeout = 1.25,
    single_shot = true,
    callback = function()
        if not mouseInPopup then popupWidget.visible = false end
    end
}

popupWidget:connect_signal("mouse::leave", function()
    if popupWidget.visible then
        mouseInPopup = false
        timer:again()
    end
end)

popupWidget:connect_signal("mouse::enter", function() mouseInPopup = true end)

return popupWidget
