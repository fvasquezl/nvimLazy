return {
  -- Tree-sitter configuration for Blade (using HTML + CSS + JS parsers)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "html",
        "javascript",
        "css",
      })

      -- Enable blade file detection
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })
    end,
  },

  -- Mason: ensure blade-formatter is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "blade-formatter",
      })
    end,
  },

  -- Auto-close and auto-rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- LSP configuration for Blade files
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure blade files get HTML, CSS, and Tailwind LSP
      opts.servers = opts.servers or {}
      opts.servers.html = opts.servers.html or {}
      opts.servers.html.filetypes = { "html", "blade" }

      -- Add emmet support for blade files (h1 -> <h1></h1>)
      opts.servers.emmet_ls = {
        filetypes = { "html", "blade", "css", "typescriptreact", "javascriptreact" },
      }
    end,
  },

  -- Mason: ensure emmet-ls is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "emmet-ls",
      })
    end,
  },

  -- Conform: blade formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
      formatters = {
        ["blade-formatter"] = {
          command = "blade-formatter",
          args = { "--stdin" },
          stdin = true,
        },
      },
    },
  },

  -- Blade snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("blade", {
        -- Livewire 4 directives
        s("wire:model", {
          t('wire:model="'),
          i(1, "property"),
          t('"'),
        }),
        s("wire:model.live", {
          t('wire:model.live="'),
          i(1, "property"),
          t('"'),
        }),
        s("wire:model.blur", {
          t('wire:model.blur="'),
          i(1, "property"),
          t('"'),
        }),
        s("wire:model.debounce", {
          t('wire:model.live.debounce.'),
          i(1, "300"),
          t('ms="'),
          i(2, "property"),
          t('"'),
        }),
        s("wire:click", {
          t('wire:click="'),
          i(1, "method"),
          t('"'),
        }),
        s("wire:submit", {
          t('wire:submit="'),
          i(1, "save"),
          t('"'),
        }),
        s("wire:confirm", {
          t('wire:confirm="'),
          i(1, "Are you sure?"),
          t('"'),
        }),
        s("wire:navigate", {
          t("wire:navigate"),
        }),
        s("wire:loading", {
          t({ '<div wire:loading>', "\t" }),
          i(1, "Loading..."),
          t({ "", "</div>" }),
        }),
        s("wire:poll", {
          t("wire:poll."),
          i(1, "5"),
          t("s"),
        }),
        s("wire:offline", {
          t({ '<div wire:offline>', "\t" }),
          i(1, "You are offline."),
          t({ "", "</div>" }),
        }),
        s("wire:transition", {
          t("wire:transition"),
        }),
        s("wire:key", {
          t('wire:key="'),
          i(1, "unique-key"),
          t('"'),
        }),
        -- Livewire Blade tags
        s("livewire:component", {
          t("<livewire:"),
          i(1, "component-name"),
          t(" />"),
        }),
        s("@livewire", {
          t("@livewire('"),
          i(1, "component-name"),
          t("')"),
        }),
        s("@persist", {
          t("@persist('"),
          i(1, "key"),
          t({ "')", "\t" }),
          i(2),
          t({ "", "@endpersist" }),
        }),
        s("@teleport", {
          t("@teleport('"),
          i(1, "body"),
          t({ "')", "\t" }),
          i(2),
          t({ "", "@endteleport" }),
        }),
        -- Blade directives
        s("@if", {
          t("@if("),
          i(1, "condition"),
          t({ ")", "" }),
          t("\t"),
          i(2),
          t({ "", "@endif" }),
        }),
        s("@foreach", {
          t("@foreach("),
          i(1, "$items as $item"),
          t({ ")", "" }),
          t("\t"),
          i(2),
          t({ "", "@endforeach" }),
        }),
        s("@auth", {
          t({ "@auth", "\t" }),
          i(1),
          t({ "", "@endauth" }),
        }),
        s("@guest", {
          t({ "@guest", "\t" }),
          i(1),
          t({ "", "@endguest" }),
        }),
        s("@can", {
          t("@can('"),
          i(1, "permission"),
          t({ "')", "" }),
          t("\t"),
          i(2),
          t({ "", "@endcan" }),
        }),
        s("@section", {
          t("@section('"),
          i(1, "name"),
          t({ "')", "" }),
          t("\t"),
          i(2),
          t({ "", "@endsection" }),
        }),
      })
    end,
  },

  -- Additional Blade syntax support
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },
}
