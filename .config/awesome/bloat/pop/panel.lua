local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icon_theme = "sheet"
local icons = require("icons")
local popupLib = require("utils.popupLib")

icons.init(icon_theme)

local box_radius = beautiful.border_radius
local box_gap = dpi(6)

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)

    local boxed_widget = wibox.widget {
        {
            {
                nil,
                {
                    nil,
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal
            },
            widget = box_container
        },
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }
    return boxed_widget
end

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, icon)
    icon.forced_height = dpi(36)
    icon.forced_width = dpi(36)
    icon.resize = true
    bar.forced_width = dpi(215)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    -- bar.forced_height = dpi(30)
    -- bar.paddings = dpi(4)
    -- bar.border_width = dpi(2)
    -- bar.border_color = x.color8

    local w = wibox.widget {
        nil,
        {icon, bar, spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

--- {{{ Volume Widget

-- local volume_icon = wibox.widget.imagebox(icons.volume)

-- awesome.connect_signal("ears::volume", function(volume, muted)
--    if muted then
--        volume_icon.image = icons.muted
--    else
--        volume_icon.image = icons.volume
--    end
-- end)

local volume = require("widgets.volume_arc")
-- local volume = format_progress_bar(volume_bar, volume_icon)

-- apps_volume = function()
--    helpers.run_or_raise({class = 'Pavucontrol'}, true, "pavucontrol")
-- end

-- volume:buttons(gears.table.join( -- Left click - Mute / Unmute
-- awful.button({}, 1, function() helpers.volume_control(0) end),
-- Scroll - Increase / Decrease volume
-- awful.button({}, 4, function() helpers.volume_control(5) end),
-- awful.button({}, 5, function() helpers.volume_control(-5) end)))

--- }}}
--
--- {{{ Brightness Widget

-- local brightness_icon = wibox.widget.imagebox(icons.brightness)
-- local brightness_bar = require("widgets.brightness_bar")
-- local brightness = format_progress_bar(brightness_bar, brightness_icon)

local brightness = require("widgets.brightness_arc")

--- }}}

--- {{{ Ram Widget

local ram = require("widgets.ram_arc")

-- local ram_icon = wibox.widget.imagebox(icons.ram)
-- local ram_bar = require("widgets.ram_bar")
-- local ram = format_progress_bar(ram_bar, ram_icon)

--- }}}

--- {{{ Cpu Widget

local cpu = require("widgets.cpu_arc")

-- local cpu_icon = wibox.widget.imagebox(icons.cpu)
-- local cpu_bar = require("widgets.cpu_bar")
-- local cpu = format_progress_bar(cpu_bar, cpu_icon)

--- }}}

--- {{{ Clock

local fancy_time_widget = wibox.widget.textclock("%H%M")
fancy_time_widget.markup = fancy_time_widget.text:sub(1, 2) ..
                               "<span foreground='" .. beautiful.xcolor12 ..
                               "'>" .. fancy_time_widget.text:sub(3, 4) ..
                               "</span>"
fancy_time_widget:connect_signal("widget::redraw_needed", function()
    fancy_time_widget.markup = fancy_time_widget.text:sub(1, 2) ..
                                   "<span foreground='" .. beautiful.xcolor12 ..
                                   "'>" .. fancy_time_widget.text:sub(3, 4) ..
                                   "</span>"
end)
fancy_time_widget.align = "center"
fancy_time_widget.valign = "center"
fancy_time_widget.font = "JetBrains Mono 55"

local fancy_time = {fancy_time_widget, layout = wibox.layout.fixed.vertical}

local calPop = require('bloat.pop.cal')

fancy_time_widget:connect_signal("mouse::enter",
                                 function() calPop.visible = true end)

fancy_time_widget:connect_signal("mouse::leave",
                                 function() calPop.visible = false end)

---}}}

-- {{{ Music Widget

local mpd = require("widgets.mpd")
local mpd_box = create_boxed_widget(mpd, 400, 125, beautiful.xcolor0)
local mpd_area = {
    nil,
    {
        mpd_box,
        left = dpi(5),
        right = dpi(5),
        top = dpi(0),
        bottom = dpi(0),
        layout = wibox.container.margin
    },
    nil,
    layout = wibox.layout.align.vertical
}

-- }}}

local nord = require("widgets.nord")
local nord_box = create_boxed_widget(nord, 400, 125, beautiful.xcolor0)
local nord_area = {
    nil,
    {
        nord_box,
        left = dpi(5),
        right = dpi(5),
        top = dpi(0),
        bottom = dpi(0),
        layout = wibox.container.margin
    },
    nil,
    layout = wibox.layout.align.vertical
}

-- {{{ Info Widget

local info = require("widgets.info")
local info_box = create_boxed_widget(info, 400, 125, beautiful.xcolor0)
local info_area = wibox.layout.align.vertical()
info_area:set_top(nil)
info_area:set_middle(wibox.container.margin(info_box, dpi(5), dpi(5), 0, 0))
info_area:set_bottom(nil)

---}}}

local sys = wibox.widget {
    nil,
    {
        volume,
        brightness,
        cpu,
        ram,
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous = true,
        expand = false,
        spacing = 50,
        layout = wibox.layout.grid
    },
    nil,
    expand = "outside",
    layout = wibox.layout.align.horizontal
}
local sys_box = create_boxed_widget(sys, 400, 350, beautiful.xcolor0)
local sys_area = wibox.layout.align.vertical()
sys_area:set_top(nil)
sys_area:set_middle(wibox.container.margin(sys_box, dpi(5), dpi(5), 0, 0))
sys_area:set_bottom(nil)

local time = wibox.widget {
    fancy_time,
    top = dpi(10),
    left = dpi(20),
    right = dpi(20),
    bottom = dpi(10),
    widget = wibox.container.margin
}

local time_box = create_boxed_widget(time, 400, 125, beautiful.xcolor0)
local time_area = wibox.layout.align.vertical()
time_area:set_top(nil)
time_area:set_middle(wibox.container.margin(time_box, dpi(5), dpi(5), 0, 0))
time_area:set_bottom(nil)

local panelWidget = wibox.widget {
    info_area,
    time_area,
    {sys_area, nord_area, mpd_area, layout = wibox.layout.fixed.vertical},
    layout = wibox.layout.align.vertical
}

local width = 400
local margin = 5

local panelPop = popupLib.create(margin, beautiful.wibar_height + margin, nil,
                                 width, panelWidget)

return panelPop
