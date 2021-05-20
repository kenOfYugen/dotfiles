local wezterm = require('wezterm')

local tabs = {}
local tab_style = {}

-- Tab Bar Options
tabs.enable_tab_bar = true
tabs.hide_tab_bar_if_only_one_tab = true
tabs.show_tab_index_in_tab_bar = false
tabs.tab_max_width = 25

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  if tab.is_active then
    return {
      {Background={Color="blue"}},
      {Text=" " .. tab.active_pane.title .. " "},
    }
  end
  return tab.active_pane.title
end)

return tabs
