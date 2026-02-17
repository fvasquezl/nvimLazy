return {
  -- Treesitter configuration for PHP
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php", "phpdoc" })
      end
    end,
  },

  -- Mason: ensure PHP tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "intelephense",
        "phpstan",
        "php-cs-fixer",
      })
    end,
  },

  -- LSP configuration for PHP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
              },
              format = {
                enable = false, -- Use Laravel Pint instead
              },
              environment = {
                phpVersion = "8.3",
              },
              completion = {
                fullyQualifyGlobalConstantsAndFunctions = true,
                insertUseDeclaration = true,
                triggerParameterHints = true,
              },
              diagnostics = {
                enable = true,
              },
              stubs = {
                -- Common Laravel and PHP stubs
                "apache",
                "bcmath",
                "Core",
                "curl",
                "date",
                "dom",
                "fileinfo",
                "filter",
                "gd",
                "hash",
                "json",
                "libxml",
                "mbstring",
                "mysqli",
                "mysqlnd",
                "openssl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "redis",
                "Reflection",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "standard",
                "tokenizer",
                "xml",
                "xmlreader",
                "xmlwriter",
                "zip",
                "zlib",
              },
            },
          },
        },
      },
    },
  },

  -- Conform: formatters configuration
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },
      },
      formatters = {
        pint = {
          command = function()
            local pint_path = vim.fn.getcwd() .. "/vendor/bin/pint"
            if vim.fn.filereadable(pint_path) == 1 then
              return pint_path
            end
            return "pint"
          end,
          args = { "$FILENAME" },
          stdin = false,
        },
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    },
  },

  -- Nvim-lint: linters configuration
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpstan" },
      },
      linters = {
        phpstan = {
          cmd = "phpstan",
          args = {
            "analyse",
            "--error-format=json",
            "--no-progress",
            "--level=5",
            "--memory-limit=2G",
          },
        },
      },
    },
  },
}
