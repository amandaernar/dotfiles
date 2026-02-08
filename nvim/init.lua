vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', ':PeekOpen<CR>', { desc = 'open markdown preview' })
vim.keymap.set('n', '<leader>q', ':PeekClose<CR>', { desc = 'Close Markdown Preview' })

vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
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
    'nvim-tree/nvim-tree.lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 36 },
        filters = { dotfiles = true },
        sort_by = "case_sensitive",
        update_focused_file = { enable = true },
      })
      vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    end,
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('user.alpha')
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
    "nvim-lua/plenary.nvim",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<Leader>g", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<Leader>b", builtin.buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<Leader>h", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<Leader>o", builtin.oldfiles, { desc = "Open recent files" })
    end,
  },

	{
	  'EdenEast/nightfox.nvim',
	  lazy = false,
	  priority = 1000,
	  config = function()
	    require('nightfox').setup({
	      options = {
        transparent = true, 
        styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic",
      }
    }
	    })

	    vim.cmd("colorscheme nordfox")

	    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
	    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
	  end,
	},

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      local peek = require('peek')
      
      peek.setup({
        app = 'browser',
        filetype = { 'markdown' },
      })

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

})

vim.g.peek_browser = 'brave'
vim.api.nvim_create_autocmd("BufWipeout", {
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = true })
    if #bufs == 0 then
      require("alpha").start()
    end
  end,
})
