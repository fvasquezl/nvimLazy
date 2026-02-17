-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- PHP-specific settings
opt.tabstop = 4 -- PHP PSR-12 standard uses 4 spaces
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Folding configuration for PHP classes/methods
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Don't fold by default
opt.foldlevel = 99

-- Better search for PHP files
opt.path:append("**") -- Search recursively
opt.wildignore:append({ "*/vendor/*", "*/node_modules/*", "*/storage/*", "*/public/storage/*" })

-- File encodings (common for Laravel projects)
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8,ucs-bom,latin1"

-- Enable persistent undo for PHP files
opt.undofile = true
opt.undolevels = 10000

-- Better completion experience
opt.completeopt = "menu,menuone,noselect"

-- Show hidden files (for .env, .gitignore, etc.)
opt.hidden = true

-- Better display for messages
opt.cmdheight = 1

-- Don't pass messages to |ins-completion-menu|
opt.shortmess:append("c")

-- Always show the signcolumn (for git signs, diagnostics, etc.)
opt.signcolumn = "yes"

-- Update time for CursorHold events (affects git signs, diagnostics)
opt.updatetime = 250

-- Timeout for key sequences
opt.timeoutlen = 300

-- Better split behavior
opt.splitbelow = true
opt.splitright = true

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Cursor line highlighting
opt.cursorline = true

-- Auto-save when focus is lost or buffer is left
opt.autowriteall = true

-- Scrolling context
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Wrap settings for Blade files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "blade", "php" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.textwidth = 120
  end,
})
