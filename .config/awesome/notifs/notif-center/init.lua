local wibox = require('wibox')
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local notif_header = wibox.widget {
    markup = '<b>Notification Center</b>',
    font = "JetBrains Mono 12",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

return wibox.widget {
    {
        notif_header,
        nil,
        require("notifs.notif-center.clear-all"),
        expand = "none",
        spacing = dpi(10),
        layout = wibox.layout.align.horizontal
    },
    {
        require('notifs.notif-center.build-notifbox'),
        max_size = 600,
        step_function = wibox.container.scroll.step_functions
            .waiting_nonlinear_back_and_forth,
        speed = 100,
        layout = wibox.container.scroll.vertical
    },
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}
