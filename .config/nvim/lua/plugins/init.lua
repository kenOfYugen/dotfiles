-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then

    local directory = string.format('%s/site/pack/packer/opt/',
                                    vim.fn.stdpath('data'))
    vim.fn.mkdir(directory, 'p')
    local git_clone_cmd = vim.fn.system(string.format('git clone %s %s',
                                                      'https://github.com/wbthomason/packer.nvim',
                                                      directory ..
                                                          '/packer.nvim'))
    print(git_clone_cmd)
    print("Installing packer.nvim...")

    return
end

vim.cmd [[autocmd! BufWritePost */plugins*.lua PackerCompile]]

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Status Line
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'plugins.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Startup Time Plugin
    use 'tweekmonster/startuptime.vim'

    -- Buffer Bar
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require 'plugins.bufferbar' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Colorscheme
    use 'JavaCafe01/javacafe.vim'

    -- Lua formatter
    use 'andrejlevkovitch/vim-lua-format'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require 'plugins.treesitter' end,
        run = ':TSUpdate'
    }

    -- Rust Plugin
    use {
        'rust-lang/rust.vim',
        config = function() vim.cmd "let g:rustfmt_autosave = 1" end
    }

    -- Dash
    use 'glepnir/dashboard-nvim'

    -- COC
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Better Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

end)
