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

  -- LSP configuration for Blade files
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure blade files get HTML, CSS, and Tailwind LSP
      opts.servers = opts.servers or {}
      opts.servers.html = opts.servers.html or {}
      opts.servers.html.filetypes = { "html", "blade" }

      -- Add emmet support for blade files
      if opts.servers.emmet_ls then
        opts.servers.emmet_ls.filetypes = vim.list_extend(opts.servers.emmet_ls.filetypes or {}, { "blade" })
      end
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
        -- Livewire directives
        s("wire:model", {
          t('wire:model="'),
          i(1, "property"),
          t('"'),
        }),
        s("wire:click", {
          t('wire:click="'),
          i(1, "method"),
          t('"'),
        }),
        s("wire:submit", {
          t('wire:submit.prevent="'),
          i(1, "submit"),
          t('"'),
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
