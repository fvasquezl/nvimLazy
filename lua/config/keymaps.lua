-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ========================================
-- Laravel & PHP Keymaps
-- ========================================

-- Laravel Artisan Commands
map("n", "<leader>aa", ":Laravel artisan<cr>", { desc = "Artisan Command Palette" })
map("n", "<leader>am", ":!php artisan make:", { desc = "Artisan Make..." })
map("n", "<leader>ar", ":Laravel routes<cr>", { desc = "Show Routes" })
map("n", "<leader>ac", ":!php artisan config:cache<cr>", { desc = "Cache Config" })
map("n", "<leader>aR", ":!php artisan route:cache<cr>", { desc = "Cache Routes" })
map("n", "<leader>av", ":!php artisan view:cache<cr>", { desc = "Cache Views" })
map("n", "<leader>ao", ":!php artisan optimize<cr>", { desc = "Optimize Application" })
map(
  "n",
  "<leader>ax",
  ":!php artisan config:clear && php artisan route:clear && php artisan view:clear && php artisan cache:clear<cr>",
  { desc = "Clear All Caches" }
)

-- Laravel Migrations
map("n", "<leader>mm", ":!php artisan migrate<cr>", { desc = "Run Migrations" })
map("n", "<leader>mf", ":!php artisan migrate:fresh<cr>", { desc = "Fresh Migrations" })
map("n", "<leader>ms", ":!php artisan migrate:fresh --seed<cr>", { desc = "Fresh + Seed" })
map("n", "<leader>mr", ":!php artisan migrate:rollback<cr>", { desc = "Rollback Migration" })
map("n", "<leader>mR", ":!php artisan migrate:reset<cr>", { desc = "Reset Migrations" })

-- Laravel Tinker
map("n", "<leader>at", ":terminal php artisan tinker<cr>", { desc = "Open Tinker" })

-- Quick file navigation for Laravel
map("n", "<leader>lv", ":e resources/views/", { desc = "Open View" })
map("n", "<leader>lc", ":e app/Http/Controllers/", { desc = "Open Controller" })
map("n", "<leader>lM", ":e app/Models/", { desc = "Open Model" })
map("n", "<leader>lm", ":e database/migrations/", { desc = "Open Migration" })
map("n", "<leader>lf", ":e database/factories/", { desc = "Open Factory" })
map("n", "<leader>ls", ":e database/seeders/", { desc = "Open Seeder" })
map("n", "<leader>lR", ":e routes/", { desc = "Open Routes" })
map("n", "<leader>le", ":e .env<cr>", { desc = "Open .env" })

-- Filament specific navigation
map("n", "<leader>Lr", ":e app/Filament/Resources/", { desc = "Filament Resources" })
map("n", "<leader>Lp", ":e app/Filament/Pages/", { desc = "Filament Pages" })
map("n", "<leader>Lw", ":e app/Filament/Widgets/", { desc = "Filament Widgets" })
map("n", "<leader>Lc", ":e app/Filament/Clusters/", { desc = "Filament Clusters" })

-- Testing shortcuts (in addition to Neotest keymaps)
map("n", "<leader>tp", ":!php artisan test<cr>", { desc = "Run All Tests (Artisan)" })
map("n", "<leader>tP", ":!php artisan test --parallel<cr>", { desc = "Run Tests Parallel" })
map("n", "<leader>tu", ":!vendor/bin/phpunit<cr>", { desc = "Run PHPUnit" })
map("n", "<leader>te", ":!vendor/bin/pest<cr>", { desc = "Run Pest" })

-- Composer shortcuts
map("n", "<leader>ci", ":!composer install<cr>", { desc = "Composer Install" })
map("n", "<leader>cu", ":!composer update<cr>", { desc = "Composer Update" })
map("n", "<leader>cd", ":!composer dump-autoload<cr>", { desc = "Dump Autoload" })

-- NPM/Yarn shortcuts
map("n", "<leader>ni", ":!npm install<cr>", { desc = "NPM Install" })
map("n", "<leader>nd", ":!npm run dev<cr>", { desc = "NPM Dev" })
map("n", "<leader>nb", ":!npm run build<cr>", { desc = "NPM Build" })

-- ========================================
-- Laravel View Navigation
-- ========================================

-- Go to Blade view file from view('...'), @extends('...'), @include('...'), etc.
map("n", "gf", function()
  local line = vim.api.nvim_get_current_line()
  local view_name = line:match("[view%(route%(@extends%(@include%(@livewire%(]%s*['\"]([%w%.%-_/]+)['\"]")
    or line:match("<livewire:([%w%.%-_/]+)")
  if view_name then
    -- Convert dot notation to path
    local path = view_name:gsub("%.", "/")
    local file = vim.fn.getcwd() .. "/resources/views/" .. path .. ".blade.php"
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("edit " .. file)
      return
    end
  end
  -- Fallback to default gf
  vim.cmd("normal! gF")
end, { desc = "Go to file / Blade view" })

-- ========================================
-- PHP Development Keymaps
-- ========================================

-- Quick PHP documentation lookup
map("n", "K", function()
  local word = vim.fn.expand("<cword>")
  if vim.bo.filetype == "php" then
    vim.cmd("!open https://www.php.net/" .. word)
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Hover/PHP Docs" })

-- Insert PHP tags
map("n", "<leader>pp", "i<?php<cr><cr>", { desc = "Insert PHP Opening Tag" })
map("n", "<leader>pe", "i<?php echo  ?><esc>hhi", { desc = "Insert PHP Echo" })
map("n", "<leader>pd", "idebug()<esc>", { desc = "Insert Debug Statement" })

-- Generate PHP DocBlock
map("n", "<leader>pD", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("function") then
    vim.cmd("normal! O/**")
    vim.cmd("normal! o * ")
    vim.cmd("normal! o */")
    vim.cmd("normal! kA")
  end
end, { desc = "Generate DocBlock" })

-- ========================================
-- Database Keymaps
-- ========================================

-- Database UI (vim-dadbod-ui)
map("n", "<leader>Du", ":DBUIToggle<cr>", { desc = "Toggle DB UI" })
map("n", "<leader>Df", ":DBUIFindBuffer<cr>", { desc = "Find DB Buffer" })
map("n", "<leader>Dr", ":DBUIRenameBuffer<cr>", { desc = "Rename DB Buffer" })
map("n", "<leader>Dq", ":DBUILastQueryInfo<cr>", { desc = "Last Query Info" })

-- ========================================
-- Git Keymaps (Additional to LazyVim defaults)
-- ========================================

-- Git blame
map("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = "Toggle Git Blame" })
map("n", "<leader>gB", ":GitBlameCopySHA<cr>", { desc = "Copy Commit SHA" })

-- Git conflicts
map("n", "<leader>gco", ":GitConflictChooseOurs<cr>", { desc = "Choose Ours" })
map("n", "<leader>gct", ":GitConflictChooseTheirs<cr>", { desc = "Choose Theirs" })
map("n", "<leader>gcb", ":GitConflictChooseBoth<cr>", { desc = "Choose Both" })
map("n", "<leader>gc0", ":GitConflictChooseNone<cr>", { desc = "Choose None" })
map("n", "]x", ":GitConflictNextConflict<cr>", { desc = "Next Conflict" })
map("n", "[x", ":GitConflictPrevConflict<cr>", { desc = "Previous Conflict" })

-- ========================================
-- Better Window Navigation
-- ========================================

-- Navigate between splits with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<cr>", { desc = "Decrease Height" })
map("n", "<C-Down>", ":resize +2<cr>", { desc = "Increase Height" })
map("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease Width" })
map("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase Width" })

-- ========================================
-- Better Indenting
-- ========================================

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- ========================================
-- Move Lines Up/Down
-- ========================================

map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Duplicate line/selection down
map("n", "<leader>j", ":t.<cr>", { desc = "Duplicate Line Down" })
map("v", "<leader>j", ":t'><cr>gv", { desc = "Duplicate Selection Down" })

-- ========================================
-- Quick Save
-- ========================================

map("n", "<C-s>", ":w<cr>", { desc = "Save File" })
map("i", "<C-s>", "<esc>:w<cr>", { desc = "Save File" })

-- ========================================
-- Better Search
-- ========================================

-- Clear search highlighting
map("n", "<leader>h", ":nohlsearch<cr>", { desc = "Clear Highlight" })

-- ========================================
-- Terminal
-- ========================================

-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
