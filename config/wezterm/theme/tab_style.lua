local wezterm = require('wezterm')

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local tabs1 = {}

-- Tab Bar Options
tabs1.enable_tab_bar = true
tabs1.hide_tab_bar_if_only_one_tab = true
tabs1.show_tab_index_in_tab_bar = false
tabs1.tab_max_width = 25

return tabs1
