local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local popupLib = require("utils.popupLib")
local helpers = require("helpers")

local videoWidget = wibox.widget {
    {
        markup = '<b>Record</b>',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    {
        markup = 'This <i>is</i> a <b>textbox</b>!!!',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    },

    layout = wibox.layout.align.vertical
}

local pictureWidget = wibox.widget {
    markup = '<b>Capture</b>',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local popupWidget = wibox.widget {
    {
        {
            {videoWidget, margins = dpi(10), widget = wibox.container.margin},
            shape = helpers.rrect(beautiful.border_radius),
            bg = beautiful.xcolor0,
            widget = wibox.container.background
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    {
        {
            pictureWidget,
            shape = helpers.rrect(beautiful.border_radius),
            bg = beautiful.xcolor0,
            widget = wibox.container.background
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },

    spacing = dpi(5),
    layout = wibox.layout.flex.horizontal
}

local width = 400
local margin = 10

local popup = popupLib.create(
                  awful.screen.focused().geometry.width / 2 - width / 2,
                  awful.screen.focused().geometry.height / 2, nil, width,
                  popupWidget)

return popup
