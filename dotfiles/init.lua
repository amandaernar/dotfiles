vim.g.mapleader = ' '
vim.g.maplocalleaader = ' '
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 5
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width = 36 },
                filters = { dotfiles = true },
                sort_by = "case_sensitive",
                update_focused_file = { enable = true },
            })
            vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>")
        end,
    },
    
    {
        'goolord/alpha-nvim',
        config = function ()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end,
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    {
      'numToStr/Comment.nvim',
      lazy = false,
      config = function() 
        require('Comment').setup()
      end
    },

    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup {
          options = { theme = 'gruvbox_dark' }
      }
    end
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>f", builtin.find_files)
            vim.keymap.set("n", "<Leader>r", builtin.live_grep)
            vim.keymap.set("n", "<Leader>b", builtin.buffers)
            vim.keymap.set("n", "<Leader>h", builtin.help_tags)
        end,
    },

     {
       "titembaatar/sarnai.nvim",
       lazy = false,
       priority = 1000,
       opts = {
         style = "khavar", 
         transparent = false 
       },
     },

    { 

      "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
          local configs = require("nvim-treesitter.configs")

          configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "go", "cpp", "javascript", "html" },
          sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
    end
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("colorscheme sarnai")
  end,
})
