return {
  -- Mason: ensure PHP debug adapter is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "php-debug-adapter",
      })
    end,
  },

  -- nvim-dap: Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "php-debug-adapter" })
        end,
      },
    },
    opts = function()
      local dap = require("dap")

      -- PHP Debug Adapter configuration
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
        },
      }

      -- PHP Debug configurations
      dap.configurations.php = {
        {
          name = "Listen for Xdebug",
          type = "php",
          request = "launch",
          port = 9003, -- Xdebug 3 default port
          log = false,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}", -- For Docker/Sail
          },
        },
        {
          name = "Listen for Xdebug (Legacy Port 9000)",
          type = "php",
          request = "launch",
          port = 9000, -- Xdebug 2 default port
          log = false,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
        {
          name = "Launch currently open script",
          type = "php",
          request = "launch",
          program = "${file}",
          cwd = "${fileDirname}",
          port = 9003,
          runtimeArgs = {
            "-dxdebug.start_with_request=yes",
            "-dxdebug.mode=debug",
            "-dxdebug.client_port=9003",
          },
        },
        {
          name = "Run Artisan Command",
          type = "php",
          request = "launch",
          program = "${workspaceFolder}/artisan",
          cwd = "${workspaceFolder}",
          args = function()
            return vim.fn.split(vim.fn.input("Artisan command: "), " ")
          end,
          port = 9003,
          runtimeArgs = {
            "-dxdebug.start_with_request=yes",
            "-dxdebug.mode=debug",
            "-dxdebug.client_port=9003",
          },
        },
        {
          name = "Run PHPUnit Test",
          type = "php",
          request = "launch",
          program = "${workspaceFolder}/vendor/bin/phpunit",
          cwd = "${workspaceFolder}",
          args = { "${file}" },
          port = 9003,
          runtimeArgs = {
            "-dxdebug.start_with_request=yes",
            "-dxdebug.mode=debug",
            "-dxdebug.client_port=9003",
          },
        },
        {
          name = "Run Pest Test",
          type = "php",
          request = "launch",
          program = "${workspaceFolder}/vendor/bin/pest",
          cwd = "${workspaceFolder}",
          args = { "${file}" },
          port = 9003,
          runtimeArgs = {
            "-dxdebug.start_with_request=yes",
            "-dxdebug.mode=debug",
            "-dxdebug.client_port=9003",
          },
        },
      }
    end,
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },

  -- nvim-dap-ui: UI for nvim-dap (included in LazyVim extras)
  {
    "rcarriga/nvim-dap-ui",
    optional = true,
    opts = {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      },
    },
  },

  -- nvim-dap-virtual-text: Show variable values as virtual text
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      filter_references_pattern = "<module",
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    },
  },

  -- Persistent breakpoints
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
    },
    keys = {
      { "<leader>dbs", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle Breakpoint (Persistent)" },
      { "<leader>dbc", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Clear All Breakpoints" },
      { "<leader>dbl", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, desc = "Conditional Breakpoint" },
    },
  },
}
