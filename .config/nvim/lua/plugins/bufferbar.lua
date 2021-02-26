-- Bufferline
-- 
require'bufferline'.setup {
    options = {
        view = "default",
        numbers = "none",
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        show_buffer_close_icons = true,
        persist_buffer_sort = true,
        separator_style = "slant",
        always_show_bufferline = true
    },
    highlights = {
        buffer_selected = {gui = 'bold'},
        fill = {guibg = '#29343d'},
        separator_selected = {guifg = '#29343d'},
        separator = {guifg = '#29343d'}
    }
}
