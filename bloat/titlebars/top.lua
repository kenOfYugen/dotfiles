local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local get_titlebar = require("bloat.titlebars.titlebar")

local titlebar

local get_titlebar = function(c, height, color)
    awful.titlebar(c, {size = height, bg = "transparent"}):setup{
        nil,
        {
            {
                {
                    get_titlebar(c),
                    bg = color,
                    shape = helpers.prrect(beautiful.border_radius, true, true,
                                           false, false),
                    widget = wibox.container.background
                },
                top = beautiful.widget_border_width,
                left = beautiful.widget_border_width,
                right = beautiful.widget_border_width,
                widget = wibox.container.margin
            },
            bg = beautiful.xcolor0,
            shape = helpers.prrect(beautiful.border_radius + 2, true, true,
                                   false, false),
            widget = wibox.container.background
        },
        nil,
        layout = wibox.layout.align.horizontal
    }
end

local top = function(c)
    local color = beautiful.xbackground

    if c.class == "firefox" then
        color = beautiful.xcolor0
    else
        color = beautiful.xbackground
    end

    local titlebar_height = beautiful.titlebar_height
    get_titlebar(c, titlebar_height, color)
end

return top
