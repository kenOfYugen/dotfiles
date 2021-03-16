" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/javacafe01/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/javacafe01/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/javacafe01/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/javacafe01/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/javacafe01/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.statusline\frequire\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["javacafe.vim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/javacafe.vim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.bufferbar\frequire\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust.vim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\31let g:rustfmt_autosave = 1\bcmd\bvim\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-lua-format"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-lua-format"
  }
}

-- Config for: nvim-bufferline.lua
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.bufferbar\frequire\0", "config", "nvim-bufferline.lua")
-- Config for: galaxyline.nvim
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.statusline\frequire\0", "config", "galaxyline.nvim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: rust.vim
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\31let g:rustfmt_autosave = 1\bcmd\bvim\0", "config", "rust.vim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
