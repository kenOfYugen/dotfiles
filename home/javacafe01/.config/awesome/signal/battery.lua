-- Provides:
-- signal::battery
--      device UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
local awful = require("awful")
local upower_widget = require("module.battery_widget")

local battery_listener = upower_widget {
    device_path = '/org/freedesktop/UPower/devices/battery_BAT0',
    instant_update = true
}

battery_listener:connect_signal("upower::update", function(widget, device)
    awesome.emit_signal("signal::battery", device)
end)
