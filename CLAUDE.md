# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

LazyVim-based Neovim configuration for PHP/Laravel 12/Filament/Livewire 4/Tailwind/Blade development. Built on [LazyVim](https://lazyvim.github.io/) with lazy.nvim as the plugin manager. TokyoNight is the default colorscheme.

## Architecture

```
init.lua              -- Entry point, loads config.lazy
lua/config/
  lazy.lua            -- lazy.nvim bootstrap + LazyVim extras loading
  options.lua         -- PHP-specific vim options (PSR-12 indent, folding, wildignore)
  keymaps.lua         -- Laravel/PHP/Filament/Git/Database keymaps
  autocmds.lua        -- Laravel detection, Blade filetype, auto-format, .env handling
lua/plugins/
  php.lua             -- Intelephense LSP, Pint/php-cs-fixer formatting, PHPStan linting
  laravel.lua         -- laravel.nvim, phptools.nvim, PHP/Laravel LuaSnip snippets
  blade.lua           -- Blade filetype, blade-formatter, HTML LSP, Blade/Livewire snippets
  filament.lua        -- Filament PHP snippets (resources, forms, tables), Alpine.js snippets
  testing.lua         -- Neotest (Pest + PHPUnit), nvim-coverage, vim-test
  debugging.lua       -- nvim-dap + Xdebug (6 configs), dap-ui, persistent breakpoints
  database.lua        -- vim-dadbod + UI, Laravel .env auto-detection, SQL completion
  git.lua             -- Diffview, Neogit, git-conflict, gitsigns (inline blame), git-blame
```

## LazyVim Extras Loaded

- `lang.tailwind` — Tailwind CSS LSP + intellisense
- `lang.typescript` — TypeScript/JS (for Livewire/Alpine)
- `lang.json` — JSON support
- `coding.luasnip` — LuaSnip snippet engine
- `test.core` — Neotest framework
- `dap.core` — Debug Adapter Protocol
- `editor.illuminate` — Word illumination
- `ui.edgy` — Window management

## Formatting

Lua files are formatted with **stylua**: 2-space indent, 120 column width (configured in `stylua.toml`).

```sh
stylua lua/
```

## Adding Plugins

Create a new `.lua` file in `lua/plugins/` returning a lazy.nvim spec table. Every file in that directory is auto-discovered. To override a LazyVim default plugin, return a spec with the same plugin name and merge or replace its `opts`.

## Key Bindings Reference

- `<leader>a*` — Laravel Artisan commands
- `<leader>m*` — Database migrations
- `<leader>l*` — Laravel file navigation
- `<leader>L*` — Filament navigation
- `<leader>t*` — Testing (Neotest + vim-test + Artisan)
- `<leader>d*` — Debugging (DAP)
- `<leader>D*` — Database UI (Dadbod)
- `<leader>g*` — Git (Neogit, Diffview, blame, conflicts)
- `<leader>p*` — PHP helpers (tags, docblocks)
- `<leader>c*` — Composer
- `<leader>n*` — NPM
- `<leader>fF*` — Filament Telescope finders
- `<leader>fl*` — Laravel Telescope finders

## PHP/Laravel Settings

- **Indent**: 4 spaces (PSR-12)
- **PHP Version**: 8.3 (Intelephense)
- **Formatter**: Laravel Pint (primary), php-cs-fixer (fallback)
- **Linter**: PHPStan level 5
- **Test Runner**: Pest (primary), PHPUnit (fallback)
- **Debugger**: Xdebug 3 (port 9003), Docker/Sail path mappings

## Reference Config

`~/.config/nvim.bak/` contains the previous heavily-customized LazyVim config that this configuration was migrated from.
