local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")


local get_titlebar = function(c, height)

    local buttons = gears.table.join(awful.button({}, 1, function()
        client.focus = c
        c:raise()
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        client.focus = c
        c:raise()
        awful.mouse.client.resize(c)
    end))

       awful.titlebar(c, {size = height, position = "top"})
       awful.titlebar(c, {size = height, position = "left"})
       awful.titlebar(c, {size = height, position = "right"})        
       awful.titlebar(c, {size = height, position = "bottom"})
end

local top = function(c)
    local titlebar_height = beautiful.titlebar_2bwm_size
    get_titlebar(c, titlebar_height)
end

return top
