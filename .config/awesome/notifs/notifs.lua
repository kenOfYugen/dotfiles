
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi

require("notifs.brightness_notif")
require("notifs.volume_notif")

naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 3
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(15)
naughty.config.defaults.border_width = 0
naughty.config.defaults.border_color = beautiful.xcolor0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = gears.shape.rectangle

naughty.config.padding = dpi(7)
naughty.config.spacing = dpi(7)
naughty.config.icon_dirs = {
   "/usr/share/icons/Papirus-Dark",
   "/usr/share/pixmaps/"
}
naughty.config.icon_formats = {"png", "svg"}

-- Timeouts
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
   font = beautiful.font,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.low = {
   font = beautiful.font,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.critical = {
   font = "SF Display Bold 10",
   fg = "#ffffff",
   bg = "#ff0000",
   position = "top_right",
   timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical
