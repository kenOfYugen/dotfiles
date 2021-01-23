local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local set_titlebar = function(c, bottom_edge_height)
    awful.titlebar(c, {
        size = bottom_edge_height,
        bg = "transparent",
        position = "bottom"
    }):setup{
        nil,
        {
            {
                {
                    nil,
                    bg = beautiful.xbackground,
                    shape = helpers.prrect(beautiful.border_radius, false,
                                           false, true, true),
                    widget = wibox.container.background
                },
                bottom = beautiful.widget_border_width,
                left = beautiful.widget_border_width,
                right = beautiful.widget_border_width,
                widget = wibox.container.margin
            },
            bg = beautiful.xcolor0,
            shape = helpers.prrect(beautiful.border_radius + 2, false, false,
                                   true, true),
            widget = wibox.container.background
        },
        nil,
        layout = wibox.layout.align.horizontal

    }
end

local bottom = function(c)
    local bottom_edge_height = beautiful.titlebar_height * (3 / 5)
    set_titlebar(c, bottom_edge_height)
end

return bottom
