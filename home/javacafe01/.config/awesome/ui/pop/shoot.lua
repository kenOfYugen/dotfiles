local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local delay = 0

local shoot_manager = {}

shoot_manager.menu = awful.popup({
    widget = {
        {
            {text = "Bruh", widget = wibox.widget.textbox},
            margins = 20,
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        shape_border_width = beautiful.widget_border_width,
        shape_border_color = beautiful.widget_border_color,
        shape = helpers.rrect(beautiful.widget_border_radius),
        widget = wibox.container.background
    },
    type = "dropdown_menu",
    visible = false,
    screen = mouse.screen,
    ontop = true,
    placement = awful.placement.centered,
    bg = "#00000000"
})

shoot_manager.keygrabber = nil

shoot_manager.hide = function(self)
    awful.keygrabber.stop(shoot_manager.keygrabber)
    self.menu.visible = false
end

shoot_manager.show = function(self)
    self.key_grabber = awful.keygrabber.run(
                           function(_, key, event)

            key = key:lower()

            if event == "release" then return end

            if key == 'escape' or key == 'q' or key == 'x' then
                self:hide()
            end
        end)
    self.menu.visible = true
end

return shoot_manager
