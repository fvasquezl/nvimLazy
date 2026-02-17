return {
  -- Diffview: Advanced diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      { "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diff with Main" },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      use_icons = true,
      watch_index = true,
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      commit_log_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
      },
    },
  },

  -- Neogit: Magit-like Git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Git Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git Push" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Neogit Split" },
    },
    opts = {
      disable_hint = false,
      disable_context_highlighting = false,
      disable_signs = false,
      graph_style = "unicode",
      git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
      },
      telescope_sorter = function()
        local has_fzf, fzf = pcall(function()
          return require("telescope").extensions.fzf
        end)
        if has_fzf and fzf then
          return fzf.native_fzf_sorter()
        end
        return nil
      end,
      remember_settings = true,
      use_per_project_settings = true,
      ignored_settings = {},
      auto_refresh = true,
      sort_branches = "-committerdate",
      kind = "tab",
      disable_line_numbers = true,
      console_timeout = 2000,
      auto_show_console = true,
      notification_icon = "󰊢",
      status = {
        recent_commit_count = 10,
      },
      commit_editor = {
        kind = "auto",
        show_staged_diff = true,
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1,
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "auto",
      },
      tag_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
      sections = {
        untracked = {
          folded = false,
        },
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
        stashes = {
          folded = true,
        },
        unpulled = {
          folded = true,
        },
        unmerged = {
          folded = false,
        },
        recent = {
          folded = true,
        },
      },
      mappings = {
        status = {
          ["q"] = "Close",
          ["I"] = "InitRepo",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
          ["<tab>"] = "Toggle",
          ["x"] = "Discard",
          ["s"] = "Stage",
          ["S"] = "StageUnstaged",
          ["<c-s>"] = "StageAll",
          ["u"] = "Unstage",
          ["U"] = "UnstageStaged",
          ["d"] = "DiffAtFile",
          ["$"] = "CommandHistory",
          ["<c-r>"] = "RefreshBuffer",
          ["<enter>"] = "GoToFile",
          ["<c-v>"] = "VSplitOpen",
          ["<c-x>"] = "SplitOpen",
          ["<c-t>"] = "TabOpen",
          ["{"] = "GoToPreviousHunkHeader",
          ["}"] = "GoToNextHunkHeader",
        },
      },
    },
  },

  -- Git Conflict: Better conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours (Conflict)" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs (Conflict)" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both (Conflict)" },
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None (Conflict)" },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
      { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "List Conflicts" },
    },
  },

  -- GitSigns: Enhanced configuration (already included in LazyVim)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },

  -- Git Blame: Inline git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = {
      enabled = true,
      message_template = " <author> • <date> • <summary>",
      date_format = "%Y-%m-%d %H:%M",
      virtual_text_column = 80,
    },
    keys = {
      { "<leader>gtb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
      { "<leader>gto", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open Commit URL" },
      { "<leader>gtc", "<cmd>GitBlameCopySHA<cr>", desc = "Copy Commit SHA" },
    },
  },
}
