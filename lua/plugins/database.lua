return {
  -- Dadbod: Universal database interface
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
  },

  -- Dadbod UI: Visual interface for databases
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Database Buffer" },
      { "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Database Buffer" },
      { "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
    init = function()
      -- Database UI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 40

      vim.g.db_ui_table_helpers = {
        mysql = {
          Count = "select count(*) from {table}",
          Explain = "EXPLAIN {last_query}",
        },
        sqlite = {
          Count = "select count(*) from {table}",
        },
        postgresql = {
          Count = "select count(*) from {table}",
          Explain = "EXPLAIN ANALYZE {last_query}",
        },
      }

      -- Auto-detect Laravel database connections from .env
      vim.g.db_ui_auto_execute_table_helpers = 1

      -- Icons
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾ ",
          buffers = "▾ ",
          saved_queries = "▾ ",
          schemas = "▾ ",
          schema = "▾ פּ",
          tables = "▾ 藺",
          table = "▾ ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ ",
          saved_queries = "▸ ",
          schemas = "▸ ",
          schema = "▸ פּ",
          tables = "▸ 藺",
          table = "▸ ",
        },
        saved_query = "",
        new_query = "璘",
        tables = "離",
        buffers = "﬘",
        add_connection = "",
        connection_ok = "✓",
        connection_error = "✕",
      }

      -- Saved queries directory
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"

      -- Execute query keymaps
      vim.g.db_ui_execute_on_save = 0
    end,
    config = function()
      -- Setup Laravel database connection from .env file
      local function setup_laravel_db()
        local env_file = vim.fn.getcwd() .. "/.env"
        if vim.fn.filereadable(env_file) == 1 then
          local db_connection = vim.fn.getenv("DB_CONNECTION") or "mysql"
          local db_host = vim.fn.getenv("DB_HOST") or "127.0.0.1"
          local db_port = vim.fn.getenv("DB_PORT") or "3306"
          local db_database = vim.fn.getenv("DB_DATABASE") or ""
          local db_username = vim.fn.getenv("DB_USERNAME") or "root"
          local db_password = vim.fn.getenv("DB_PASSWORD") or ""

          if db_database ~= "" then
            local connection_string = ""
            if db_connection == "mysql" then
              connection_string = string.format(
                "mysql://%s:%s@%s:%s/%s",
                db_username,
                db_password,
                db_host,
                db_port,
                db_database
              )
            elseif db_connection == "pgsql" then
              connection_string = string.format(
                "postgresql://%s:%s@%s:%s/%s",
                db_username,
                db_password,
                db_host,
                db_port,
                db_database
              )
            elseif db_connection == "sqlite" then
              local db_path = vim.fn.getenv("DB_DATABASE")
              connection_string = "sqlite:" .. db_path
            end

            if connection_string ~= "" then
              vim.g.dbs = vim.g.dbs or {}
              vim.g.dbs["Laravel_" .. db_database] = connection_string
            end
          end
        end
      end

      -- Try to setup Laravel database on startup
      setup_laravel_db()

      -- Auto-detect when entering a Laravel project
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          setup_laravel_db()
        end,
      })
    end,
  },

  -- Dadbod Completion: SQL autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "kristijanhusak/vim-dadbod-completion" },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "vim-dadbod-completion",
        priority = 700,
      })
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Setup dadbod completion for SQL files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end,
      })
    end,
  },

  -- SQLite support
  {
    "kkharji/sqlite.lua",
    lazy = true,
  },

  -- SQL formatter
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "sqlfluff",
      })
    end,
  },

  -- Conform: SQL formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
}
