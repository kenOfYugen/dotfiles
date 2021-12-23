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
        forced_width = dpi(12),
        forced_height = dpi(12),
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

local function create_title_bg(c, w, color_focus, color_unfocus, shp)
    local tb = wibox.widget {
        {w, margins = dpi(6), widget = wibox.container.margin},
        bg = color_focus,
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
    return {tb, margins = dpi(7), widget = wibox.container.margin}
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
        return function(cr)
            gears.shape.transform(gears.shape.cross):rotate_at(width / 2,
                                                               height / 2,
                                                               math.pi / 4)(cr,
                                                                            width,
                                                                            height,
                                                                            2)
        end
    end

    local close = create_title_button(c, beautiful.xcolor1,
                                      beautiful.xcolor0 .. "55", ci(12, 12))
    close:connect_signal("button::press", function() c:kill() end)

    awful.titlebar(c, {size = height, position = "top"}):setup{
        --[[{
            helpers.horizontal_pad(10),
            tabbed_misc.titlebar_indicator(c, {
                icon_size = dpi(18),
                icon_margin = dpi(6),
                layout_spacing = dpi(6),
                bg_color_focus = beautiful.lighter_bg,
                bg_color = beautiful.darker_bg,
                icon_shape = gears.shape.circle
            }),
            layout = wibox.layout.fixed.horizontal
        },--]]
        create_title_bg(c, awful.titlebar.widget.iconwidget(c),
                        beautiful.xcolor0, beautiful.xbackground,
                        helpers.rrect(beautiful.border_radius)),
        awful.titlebar.widget.titlewidget(c),
        {
            {
                close,
                top = dpi(1),
                right = dpi(15),
                widget = wibox.container.margin
            },
            valign = "center",
            halign = "center",
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
