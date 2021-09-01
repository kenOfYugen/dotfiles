local awful = require("awful")

require("ui.decorations.ncmpcpp")

local add_decorations = function(c) require("ui.decorations.top")(c) end

client.connect_signal("request::titlebars", function(c)
    c.titlebars = true
    if not c.bling_tabbed then
        if c.class ~= "music" then add_decorations(c) end
    end
end)

screen.connect_signal('arrange', function(s)
    local layout = s.selected_tag.layout.name

    for _, c in pairs(s.clients) do
        if not c.titlebars then goto continue end

        if layout == 'floating' or c.floating and not c.maximized then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end

        ::continue::
    end
end)
