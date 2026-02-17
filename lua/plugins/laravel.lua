return {
  -- Laravel.nvim: comprehensive Laravel integration
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related" },
      { "<leader>lt", ":Laravel make test<cr>", desc = "Laravel Make Test" },
    },
    event = { "VeryLazy" },
    config = function()
      require("laravel").setup({
        lsp_server = "intelephense",
        features = {
          null_ls = {
            enable = false, -- Using conform.nvim instead
          },
          route_info = {
            enable = true,
            position = "right",
            middlewares = true,
            method = true,
            uri = true,
          },
        },
      })

      -- Register Telescope extension safely
      pcall(function()
        require("telescope").load_extension("laravel")
      end)
    end,
  },

  -- PHP Tools: additional PHP utilities
  {
    "ccaglak/phptools.nvim",
    keys = {
      { "<leader>lc", ":PhpTools create<cr>", desc = "PHP Create Class" },
      { "<leader>ln", ":PhpTools namespace<cr>", desc = "PHP Add Namespace" },
      { "<leader>lg", ":PhpTools getset<cr>", desc = "PHP Generate Getters/Setters" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("phptools").setup({
        ui = true,
        custom_toggles = {
          ["config"] = "config/",
          ["routes"] = "routes/",
          ["database"] = "database/",
        },
      })
    end,
  },

  -- Laravel Snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

      ls.add_snippets("php", {
        -- Route snippets
        s(
          "route.get",
          fmt("Route::get('{}', [{}::class, '{}']);", {
            i(1, "/path"),
            i(2, "Controller"),
            i(3, "method"),
          })
        ),
        s(
          "route.post",
          fmt("Route::post('{}', [{}::class, '{}']);", {
            i(1, "/path"),
            i(2, "Controller"),
            i(3, "method"),
          })
        ),
        s(
          "route.resource",
          fmt("Route::resource('{}', {}::class);", {
            i(1, "resource"),
            i(2, "Controller"),
          })
        ),

        -- Controller method
        s(
          "controller",
          fmt(
            [[
public function {}(Request $request)
{{
    {}
}}
]],
            {
              i(1, "method"),
              i(2, "// method body"),
            }
          )
        ),

        -- Model snippets
        s(
          "model",
          fmt(
            [[
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class {} extends Model
{{
    use HasFactory;

    protected $fillable = [
        {}
    ];
}}
]],
            {
              i(1, "ModelName"),
              i(2, "'column'"),
            }
          )
        ),

        -- Migration snippets
        s(
          "migration.table",
          fmt(
            [[
Schema::table('{}', function (Blueprint $table) {{
    {}
}});
]],
            {
              i(1, "table_name"),
              i(2, "$table->string('column');"),
            }
          )
        ),
        s(
          "migration.create",
          fmt(
            [[
Schema::create('{}', function (Blueprint $table) {{
    $table->id();
    {}
    $table->timestamps();
}});
]],
            {
              i(1, "table_name"),
              i(2, "$table->string('column');"),
            }
          )
        ),

        -- Request validation
        s(
          "validate",
          fmt(
            [[
$validated = $request->validate([
    {} => ['required', {}],
]);
]],
            {
              i(1, "'field'"),
              i(2, "'string'"),
            }
          )
        ),

        -- Eloquent relationships
        s(
          "belongsTo",
          fmt(
            [[
public function {}(): BelongsTo
{{
    return $this->belongsTo({}::class);
}}
]],
            {
              i(1, "relation"),
              i(2, "Model"),
            }
          )
        ),
        s(
          "hasMany",
          fmt(
            [[
public function {}(): HasMany
{{
    return $this->hasMany({}::class);
}}
]],
            {
              i(1, "relation"),
              i(2, "Model"),
            }
          )
        ),

        -- Livewire component
        s(
          "livewire",
          fmt(
            [[
<?php

namespace App\Livewire;

use Livewire\Component;

class {} extends Component
{{
    public function render()
    {{
        return view('livewire.{}');
    }}
}}
]],
            {
              i(1, "ComponentName"),
              i(2, "component-name"),
            }
          )
        ),

        -- Factory
        s(
          "factory",
          fmt(
            [[
public function definition(): array
{{
    return [
        {} => fake()->{}(),
    ];
}}
]],
            {
              i(1, "'field'"),
              i(2, "word"),
            }
          )
        ),

        -- Test case
        s(
          "test",
          fmt(
            [[
public function test_{}(): void
{{
    {}

    $this->assertTrue(true);
}}
]],
            {
              i(1, "feature_name"),
              i(2, "// Arrange & Act"),
            }
          )
        ),
        s(
          "pest.test",
          fmt(
            [[
test('{}', function () {{
    {}

    expect(true)->toBeTrue();
}});
]],
            {
              i(1, "feature name"),
              i(2, "// Arrange & Act"),
            }
          )
        ),
      })
    end,
  },

  -- Telescope integration for Laravel
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fla", "<cmd>Telescope laravel artisan<cr>", desc = "Laravel Artisan Commands" },
      { "<leader>flr", "<cmd>Telescope laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>flc", "<cmd>Telescope laravel configs<cr>", desc = "Laravel Configs" },
    },
  },
}
