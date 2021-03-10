local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")
local pad = helpers.pad

-- Text lines
------------------------------------------------------------
local user = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor6 .. "'>JavaCafe01</span>",
    widget = wibox.widget.textbox
}
local name = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor4 .. "'>Gokul Swami</span>",
    widget = wibox.widget.textbox
}

user:set_font(beautiful.font)
user:set_valign("top")
name:set_font(beautiful.font_name .. "14")
name:set_valign("top")

local text_area = wibox.layout.fixed.vertical()
text_area:add(name)
text_area:add(user)
------------------------------------------------------------

-- Bring it all together
------------------------------------------------------------
local align_vertical = wibox.layout.align.vertical()
align_vertical:set_middle(text_area)
align_vertical.expand = "none"
local area = wibox.widget {
    {
        {
            {
                {
                    markup = "<span foreground='" .. beautiful.xcolor2 ..
                        "'></span>",
                    align = "center",
                    valign = "center",
                    font = "FiraCode Nerd Font Mono 40",
                    widget = wibox.widget.textbox
                },
                margins = dpi(25),
                widget = wibox.container.margin
            },
            bg = beautiful.xcolor0,
            shape = gears.shape.circle,
            widget = wibox.container.background
        },
        left = dpi(35),
        widget = wibox.container.margin
    },
    {align_vertical, left = dpi(55), widget = wibox.container.margin},
    layout = wibox.layout.align.horizontal
}

return area
