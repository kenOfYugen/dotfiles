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
  ["completion-buffers"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/completion-buffers"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["completion-treesitter"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["fennel.vim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/fennel.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.statusline\frequire\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  ["javacafe.vim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/javacafe.vim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
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
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0" },
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
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
  ["nvim.lua"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/nvim.lua"
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
  popfix = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-arduino"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-arduino"
  },
  ["vim-lua-format"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-lua-format"
  },
  ["vim-parinfer"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-parinfer"
  },
  ["vim-smali"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-smali"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/javacafe01/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  }
}

-- Config for: nvim-bufferline.lua
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.bufferbar\frequire\0", "config", "nvim-bufferline.lua")
-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0", "config", "nvim-lspconfig")
-- Config for: galaxyline.nvim
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.statusline\frequire\0", "config", "galaxyline.nvim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
