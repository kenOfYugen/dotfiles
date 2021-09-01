-- notifs.lua
-- Notif Panel Widget
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local notif_manager = {}

local box_radius = beautiful.client_radius
local box_gap = dpi(8)

local width = 451
local height =
    725 - beautiful.useless_gap + 76 + beautiful.widget_border_width + 40

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = beautiful.xbackground
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)
    box_container.border_width = 0 or beautiful.widget_border_width
    box_container.border_color = beautiful.widget_border_color

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

local notifs = wibox.widget {
    require("ui.notifs.notif-center"),
    top = dpi(8),
    bottom = dpi(20),
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin
}

local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true,
                                               false, true, 5)
        end
    else
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end
end

styles.month = {
    padding = 0,
    bg_color = beautiful.xbackground,
    shape = helpers.rrect(beautiful.border_radius)
}
styles.normal = {
    padding = dpi(7),
    fg_color = beautiful.xforeground .. 55,
    bg_color = beautiful.xcolor0 .. 00,
    shape = helpers.rrect(beautiful.border_radius)
}
styles.focus = {
    fg_color = beautiful.xforeground,
    bg_color = beautiful.xcolor8 .. 00,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = helpers.rrect(beautiful.border_radius)
}
styles.header = {
    fg_color = beautiful.xcolor3,
    bg_color = beautiful.xcolor0 .. 00,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = helpers.rrect(beautiful.border_radius)
}
styles.weekday = {
    fg_color = beautiful.xcolor6,
    bg_color = beautiful.xcolor0 .. 00,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = helpers.rrect(beautiful.border_radius)
}
local function decorate_cell(widget, flag, date)
    if flag == 'monthheader' and not styles.monthheader then flag = 'header' end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {
        year = date.year,
        month = (date.month or 1),
        day = (date.day or 1)
    }
    local weekday = tonumber(os.date('%w', os.time(d)))
    local default_bg = (weekday == 0 or weekday == 6) and '#232323' or '#383838'
    local ret = wibox.widget {
        {
            {widget, halign = 'center', widget = wibox.container.place},
            margins = (props.padding or 2) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        shape = props.shape,
        border_color = props.border_color or '#b9214f',
        border_width = props.border_width or 0,
        fg = props.fg_color or '#999999',
        bg = props.bg_color or default_bg,
        widget = wibox.container.background
    }
    return ret
end

local panelWidget = wibox.widget {
    {
        {
            notifs,
            right = dpi(20),
            left = dpi(20),
            top = dpi(20),
            bottom = dpi(0),
            forced_height = dpi(500),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        shape = helpers.rrect(10),
        border_width = beautiful.widget_border_width,
        border_color = beautiful.widget_border_color,
        widget = wibox.container.background
    },
    {
        {
            {
                date = os.date('*t'),
                fn_embed = decorate_cell,
                widget = wibox.widget.calendar.month
            },
            left = dpi(35),
            top = dpi(40),
            bottom = dpi(30),
            right = dpi(35),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        shape = helpers.rrect(10),
        border_width = beautiful.widget_border_width,
        border_color = beautiful.widget_border_color,
        widget = wibox.container.background
    },
    nil,
    spacing = beautiful.useless_gap * 2,
    layout = wibox.layout.fixed.vertical
}

local placement_fn = function(c)
    awful.placement.bottom_right(c, {
        margins = {
            bottom = beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2
        }
    })
end

notif_manager.menu = awful.popup({
    widget = {
        panelWidget,
        forced_height = height,
        forced_width = width,
        layout = wibox.layout.fixed.vertical
    },
    visible = false,
    placement = placement_fn,
    ontop = true,
    type = "dock",
    bg = beautiful.xbackground .. "00"
})

notif_manager.toggle = function(self)

    local notif_menu = self.menu

    if not notif_menu.visible then
        notif_menu.visible = true
    else
        notif_menu.visible = false
    end

    awesome.emit_signal("widgets::notifs::status", notif_menu.visible)
end

return notif_manager

-- EOF ------------------------------------------------------------------------
