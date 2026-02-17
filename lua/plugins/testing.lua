return {
  -- Neotest with PHP/Pest/PHPUnit support
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- PHP test adapters
      "V13Axel/neotest-pest",
      "olimorris/neotest-phpunit",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- Pest adapter (primary for Laravel)
      table.insert(
        opts.adapters,
        require("neotest-pest")({
          pest_cmd = function()
            return "php artisan test"
          end,
          sail_enabled = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/vendor/bin/sail") == 1
          end,
          sail_project_path = "/var/www/html",
          parallel = 16,
          compact = false,
        })
      )

      -- PHPUnit adapter (fallback)
      table.insert(
        opts.adapters,
        require("neotest-phpunit")({
          phpunit_cmd = function()
            if vim.fn.filereadable(vim.fn.getcwd() .. "/artisan") == 1 then
              return "php artisan test"
            end
            return "vendor/bin/phpunit"
          end,
          filter_dirs = { "vendor" },
        })
      )

      -- Configure discovery and execution
      opts.discovery = {
        enabled = true,
        concurrent = 1,
      }

      opts.running = {
        concurrent = true,
      }

      opts.summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
          watch = "w",
        },
      }

      opts.output = {
        enabled = true,
        open_on_run = false,
      }

      opts.output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      }

      opts.quickfix = {
        enabled = true,
        open = false,
      }

      opts.status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      }

      opts.icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "✖",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "✔",
        running = "⟳",
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        skipped = "ᐅ",
        unknown = "?",
        watching = "👁",
      }

      return opts
    end,
  },

  -- Coverage display
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageLoadLcov",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageSummary",
    },
    keys = {
      { "<leader>tc", "<cmd>Coverage<cr>", desc = "Toggle Coverage" },
      { "<leader>tC", "<cmd>CoverageSummary<cr>", desc = "Coverage Summary" },
    },
    config = function()
      require("coverage").setup({
        auto_reload = true,
        lang = {
          php = {
            coverage_file = "coverage/clover.xml",
          },
        },
        signs = {
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
          partial = { hl = "CoveragePartial", text = "▎" },
        },
        summary = {
          min_coverage = 80.0,
        },
      })
    end,
  },

  -- Vim Test (alternative/complement to Neotest)
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>t.", "<cmd>TestNearest<cr>", desc = "Test Nearest (vim-test)" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File (vim-test)" },
      { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test Suite (vim-test)" },
      { "<leader>tL", "<cmd>TestLast<cr>", desc = "Test Last (vim-test)" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test Visit (vim-test)" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1

      -- Laravel/Pest configuration
      vim.g["test#php#pest#executable"] = "php artisan test"
      vim.g["test#php#phpunit#executable"] = "php artisan test"
    end,
  },
}
