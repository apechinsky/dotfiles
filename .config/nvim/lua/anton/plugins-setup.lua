-- Plugin init

-- Autoinstall 'packer' plugin manager
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

packer_bootstrap = ensure_packer()

-- List plugins to install with packer
return require('packer').startup(function(use)
    -- plugin manager manages itself
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'morhetz/gruvbox'

    -- navigate beteween windows with Ctrl hjkl
    use 'christoomey/vim-tmux-navigator'

    -- surround objects with selected chars
    use 'tpope/vim-surround'

    -- Pairs of handy bracket mappings
    use 'tpope/vim-unimpaired'

    -- git integration
    use 'tpope/vim-fugitive'

    -- git. show git changes in signcolumn
    use 'mhinz/vim-signify'

    -- commenting
    use 'numToStr/Comment.nvim'

    -- visualize vim undo history
    use ('mbbill/undotree')

    -- file explorer
    use 'nvim-tree/nvim-tree.lua'

    -- Personal Wiki for Vim http://vimwiki.github.io/
    use 'vimwiki/vimwiki'

    -- trash shell integration
    use 'echuraev/translate-shell.vim'

    -- developer icons
    use 'nvim-tree/nvim-web-devicons'

    -- statusline
    use 'nvim-lualine/lualine.nvim'

    -- general purpose fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- recommended extension for impoving telescope performance
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'

    --  For luasnip users.
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    -- managing & installing lsp servers, linters & formatters
    use 'williamboman/mason.nvim'
    -- bridges gap b/w mason & lspconfig
    use 'williamboman/mason-lspconfig.nvim'

    -- lsp configuration
    use 'neovim/nvim-lspconfig'
    -- use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
    -- -- vs-code like icons for autocompletion
    -- use("onsails/lspkind.nvim") 
    use 'mfussenegger/nvim-jdtls'

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- configure formatters & linters
    use("jose-elias-alvarez/null-ls.nvim")
    -- bridges gap b/w mason & null-ls
    use("jayp0521/mason-null-ls.nvim")

    -- autoclose parens, brackets, quotes, etc...
    use("windwp/nvim-autopairs")
    -- autoclose tags
    use {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter"
    }

    -- show colored CSS color literals
    use 'ap/vim-css-color'

    -- autoadd parenthesis/brackets/braces
    use 'windwp/nvim-autopairs'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
