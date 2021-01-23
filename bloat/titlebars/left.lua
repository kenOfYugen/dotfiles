local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local set_left_titlebar = function(c)
    awful.titlebar(c, {
        position = "left",
        size = beautiful.widget_border_width,
        bg = beautiful.xcolor0
    })
end

local set_thunar_left_titlebar = function(c, left_border_img)
    local custom_titlebar = require("bloat.titlebars.thunar")(c)

    awful.titlebar(c, {position = "left", size = 70, bg = transparent}):setup{
        {
            bg = beautiful.xcolor0,
            forced_width = beautiful.widget_border_width,
            widget = wibox.container.background
        },
        {
            custom_titlebar,
            bg = beautiful.xbackground,
            widget = wibox.container.background
        },
        layout = wibox.layout.fixed.horizontal
    }
end

local left = function(c)
    if c.class == "Thunar" and c.type == "normal" then
        set_thunar_left_titlebar(c)
    else
        set_left_titlebar(c)
    end
end

return left
