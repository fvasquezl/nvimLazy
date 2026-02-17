-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ========================================
-- Laravel/PHP Autocommands
-- ========================================

local laravel_group = augroup("LaravelConfig", { clear = true })

-- Detect Laravel projects
autocmd({ "BufRead", "BufNewFile" }, {
  group = laravel_group,
  pattern = { "artisan", "*.php" },
  callback = function()
    -- Check if we're in a Laravel project by looking for artisan file
    local artisan_path = vim.fn.getcwd() .. "/artisan"
    if vim.fn.filereadable(artisan_path) == 1 then
      vim.b.is_laravel_project = true
      vim.g.is_laravel_project = true
    end
  end,
})

-- Auto-format PHP files on save
autocmd("BufWritePre", {
  group = laravel_group,
  pattern = "*.php",
  callback = function()
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = false, lsp_fallback = true, timeout_ms = 2000 })
    end
  end,
})

-- PHP-specific settings
autocmd("FileType", {
  group = laravel_group,
  pattern = "php",
  callback = function()
    vim.opt_local.commentstring = "// %s"
    vim.opt_local.iskeyword:append("$") -- Include $ in keyword for PHP variables
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- ========================================
-- Blade Template Autocommands
-- ========================================

local blade_group = augroup("BladeConfig", { clear = true })

-- Blade file detection
autocmd({ "BufRead", "BufNewFile" }, {
  group = blade_group,
  pattern = "*.blade.php",
  callback = function()
    vim.bo.filetype = "blade"
  end,
})

-- Blade-specific settings
autocmd("FileType", {
  group = blade_group,
  pattern = "blade",
  callback = function()
    vim.opt_local.commentstring = "{{-- %s --}}"
    vim.opt_local.indentexpr = ""
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.spell = false
  end,
})

-- Auto-format Blade files on save
autocmd("BufWritePre", {
  group = blade_group,
  pattern = "*.blade.php",
  callback = function()
    local blade_formatter = vim.fn.getcwd() .. "/node_modules/.bin/blade-formatter"
    if vim.fn.filereadable(blade_formatter) == 1 or vim.fn.executable("blade-formatter") == 1 then
      require("conform").format({ async = false, lsp_fallback = true })
    end
  end,
})

-- ========================================
-- Composer & JSON Autocommands
-- ========================================

local composer_group = augroup("ComposerConfig", { clear = true })

-- Auto-reload LSP when composer.json is saved
autocmd("BufWritePost", {
  group = composer_group,
  pattern = "composer.json",
  callback = function()
    vim.notify("composer.json saved. Run 'composer dump-autoload' if needed.", vim.log.levels.INFO)
  end,
})

-- ========================================
-- .env File Autocommands
-- ========================================

local env_group = augroup("EnvConfig", { clear = true })

-- Treat .env files as shell files for syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  group = env_group,
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Warn when editing .env
autocmd("BufRead", {
  group = env_group,
  pattern = ".env",
  callback = function()
    vim.notify("Editing .env file. Be careful with sensitive data!", vim.log.levels.WARN)
  end,
})

-- ========================================
-- Test File Autocommands
-- ========================================

local test_group = augroup("TestConfig", { clear = true })

-- Detect test files and set appropriate settings
autocmd({ "BufRead", "BufNewFile" }, {
  group = test_group,
  pattern = { "*Test.php", "*_test.php", "tests/**/*.php" },
  callback = function()
    vim.b.is_test_file = true
  end,
})

-- ========================================
-- Remove Trailing Whitespace
-- ========================================

local whitespace_group = augroup("RemoveTrailingWhitespace", { clear = true })

-- Remove trailing whitespace on save for PHP files
autocmd("BufWritePre", {
  group = whitespace_group,
  pattern = { "*.php", "*.blade.php", "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- ========================================
-- Laravel Project Detection
-- ========================================

local project_group = augroup("ProjectDetection", { clear = true })

-- Detect Laravel project on startup
autocmd("VimEnter", {
  group = project_group,
  callback = function()
    local artisan_path = vim.fn.getcwd() .. "/artisan"
    if vim.fn.filereadable(artisan_path) == 1 then
      vim.g.is_laravel_project = true
      vim.notify("Laravel project detected!", vim.log.levels.INFO)
    end
  end,
})

-- ========================================
-- Git Commit Message
-- ========================================

local git_group = augroup("GitConfig", { clear = true })

-- Set textwidth for git commit messages
autocmd("FileType", {
  group = git_group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.spell = true
  end,
})

-- ========================================
-- Markdown Files
-- ========================================

local markdown_group = augroup("MarkdownConfig", { clear = true })

-- Markdown settings
autocmd("FileType", {
  group = markdown_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- ========================================
-- Terminal Buffer Settings
-- ========================================

local terminal_group = augroup("TerminalConfig", { clear = true })

-- Disable line numbers in terminal buffers
autocmd("TermOpen", {
  group = terminal_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
