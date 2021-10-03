local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local bling = require("module.bling")

local function create_title_button(c, color_focus, color_unfocus, shp)
    local tb = wibox.widget {
        forced_width = dpi(16),
        forced_height = dpi(16),
        bg = color_focus .. 80,
        shape = shp,
        widget = wibox.container.background
    }

    local function update()
        if client.focus == c then
            tb.bg = color_focus
        else
            tb.bg = color_unfocus
        end
    end
    update()

    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    tb:connect_signal("mouse::enter", function() tb.bg = color_focus .. 55 end)
    tb:connect_signal("mouse::leave", function() tb.bg = color_focus end)

    tb.visible = true
    return tb
end

local get_titlebar = function(c, height)

    local tabbed_misc = bling.widget.tabbed_misc

    local buttons = gears.table.join(awful.button({}, 1, function()
        client.focus = c
        c:raise()
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        client.focus = c
        c:raise()
        awful.mouse.client.resize(c)
    end))

    local ci = function(width, height)
        return function(cr) gears.shape.circle(cr, width, height) end
    end

    local close = create_title_button(c, beautiful.xcolor1,
                                      beautiful.xcolor0 .. "55", ci(12, 12))
    close:connect_signal("button::press", function() c:kill() end)
    local min = create_title_button(c, beautiful.xcolor3,
                                    beautiful.xcolor0 .. "55", ci(12, 12))
    min:connect_signal("button::press", function() c.minimized = true end)
    local max = create_title_button(c, beautiful.xcolor4,
                                    beautiful.xcolor0 .. "55", ci(12, 12))
    max:connect_signal("button::press",
                       function() c.maximized = not c.maximized end)

    awful.titlebar(c, {size = height, position = "top"}):setup{
        tabbed_misc.titlebar_indicator(c, {
            icon_size = dpi(18),
            icon_margin = dpi(6),
            layout_spacing = dpi(6),
            bg_color_focus = beautiful.darker_bg,
            bg_color = beautiful.xbackground,
            icon_shape = helpers.rrect(4)
        }),
        nil,
        {
            {
                {
                    max,
                    helpers.horizontal_pad(10),
                    min,
                    helpers.horizontal_pad(10),
                    close,
                    helpers.horizontal_pad(10),
                    layout = wibox.layout.flex.horizontal
                },
                top = dpi(5),
                widget = wibox.container.margin
            },
            valign = "center",
            widget = wibox.container.place
        },
        expand = "none",
        buttons = buttons,
        layout = wibox.layout.align.horizontal
    }
end

local top = function(c)
    local titlebar_height = beautiful.titlebar_size
    get_titlebar(c, titlebar_height)
end

return top
