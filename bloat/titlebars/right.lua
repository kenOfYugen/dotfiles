local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local set_titlebar = function(c, right_border_img, client_color)
    awful.titlebar(c, {
        position = "right",
        size = beautiful.widget_border_width,
        bg = beautiful.xcolor0,
        widget = wibox.container.background
    }):setup{bgimage = right_border_img, widget = wibox.container.background}
end

local left = function(c) set_titlebar(c) end

return left
