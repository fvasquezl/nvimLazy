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

        -- Livewire 4 Components
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
        s(
          "livewire.full",
          fmt(
            [[
<?php

namespace App\Livewire;

use Livewire\Attributes\Validate;
use Livewire\Component;

class {} extends Component
{{
    #[Validate('{}')]
    public {} ${} = {};

    public function mount(): void
    {{
        {}
    }}

    public function {}(): void
    {{
        $this->validate();
        {}
    }}

    public function render()
    {{
        return view('livewire.{}');
    }}
}}
]],
            {
              i(1, "ComponentName"),
              i(2, "required"),
              i(3, "string"),
              i(4, "name"),
              i(5, "''"),
              i(6, "//"),
              i(7, "save"),
              i(8, "//"),
              i(9, "component-name"),
            }
          )
        ),
        s(
          "livewire.form",
          fmt(
            [[
<?php

namespace App\Livewire\Forms;

use Livewire\Attributes\Validate;
use Livewire\Form;

class {} extends Form
{{
    #[Validate('required')]
    public string ${} = '';

    #[Validate('required')]
    public string ${} = '';

    public function store(): void
    {{
        $this->validate();
        {}
    }}
}}
]],
            {
              i(1, "ContactForm"),
              i(2, "name"),
              i(3, "email"),
              i(4, "// Model::create($this->all());"),
            }
          )
        ),
        s(
          "livewire.table",
          fmt(
            [[
<?php

namespace App\Livewire;

use Livewire\Attributes\Url;
use Livewire\Component;
use Livewire\WithPagination;

class {} extends Component
{{
    use WithPagination;

    #[Url]
    public string $search = '';

    public string $sortBy = '{}';
    public string $sortDirection = 'asc';

    public function updatedSearch(): void
    {{
        $this->resetPage();
    }}

    public function sort(string $column): void
    {{
        $this->sortDirection = $this->sortBy === $column && $this->sortDirection === 'asc' ? 'desc' : 'asc';
        $this->sortBy = $column;
    }}

    public function render()
    {{
        return view('livewire.{}', [
            '{}' => {}::query()
                ->when($this->search, fn ($q) => $q->where('{}', 'like', "%{{$this->search}}%"))
                ->orderBy($this->sortBy, $this->sortDirection)
                ->paginate(10),
        ]);
    }}
}}
]],
            {
              i(1, "UserTable"),
              i(2, "created_at"),
              i(3, "user-table"),
              i(4, "users"),
              i(5, "App\\Models\\User"),
              i(6, "name"),
            }
          )
        ),

        -- Livewire 4 Attributes
        s("lw.validate", {
          t("#[Validate('"),
          i(1, "required"),
          t("')]"),
        }),
        s("lw.url", {
          t("#[Url]"),
        }),
        s("lw.locked", {
          t("#[Locked]"),
        }),
        s("lw.reactive", {
          t("#[Reactive]"),
        }),
        s("lw.modelable", {
          t("#[Modelable]"),
        }),
        s("lw.computed", {
          t("#[Computed]"),
        }),
        s("lw.lazy", {
          t("#[Lazy]"),
        }),
        s(
          "lw.on",
          fmt(
            [[
#[On('{}')]
public function {}(): void
{{
    {}
}}
]],
            {
              i(1, "event-name"),
              i(2, "handleEvent"),
              i(3, "//"),
            }
          )
        ),

        -- Livewire 4 Methods
        s(
          "lw.dispatch",
          fmt("$this->dispatch('{}'{});", {
            i(1, "event-name"),
            i(2, ""),
          })
        ),
        s(
          "lw.mount",
          fmt(
            [[
public function mount({}): void
{{
    {}
}}
]],
            {
              i(1, ""),
              i(2, "//"),
            }
          )
        ),
        s(
          "lw.updated",
          fmt(
            [[
public function updated{}(): void
{{
    {}
}}
]],
            {
              i(1, "Property"),
              i(2, "//"),
            }
          )
        ),
        s("lw.redirect", {
          t("$this->redirect(route('"),
          i(1, "route.name"),
          t("'), navigate: true);"),
        }),
        s("lw.reset", {
          t("$this->reset('"),
          i(1, "property"),
          t("');"),
        }),
        s(
          "lw.js",
          fmt("$this->js('{}');", {
            i(1, "alert('Hello')"),
          })
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

        -- Eloquent Query Builder
        s(
          "where",
          fmt("->where('{}', {})", {
            i(1, "column"),
            i(2, "$value"),
          })
        ),
        s(
          "orWhere",
          fmt("->orWhere('{}', {})", {
            i(1, "column"),
            i(2, "$value"),
          })
        ),
        s(
          "whereIn",
          fmt("->whereIn('{}', [{}])", {
            i(1, "column"),
            i(2, ""),
          })
        ),
        s(
          "whereNotNull",
          fmt("->whereNotNull('{}')", {
            i(1, "column"),
          })
        ),
        s(
          "whereNull",
          fmt("->whereNull('{}')", {
            i(1, "column"),
          })
        ),
        s(
          "whereBetween",
          fmt("->whereBetween('{}', [{}, {}])", {
            i(1, "column"),
            i(2, "$start"),
            i(3, "$end"),
          })
        ),
        s(
          "whereHas",
          fmt(
            [[
->whereHas('{}', function ($query) {{
    $query->{};
}})
]],
            {
              i(1, "relation"),
              i(2, "where('column', $value)"),
            }
          )
        ),
        s(
          "orderBy",
          fmt("->orderBy('{}', '{}')", {
            i(1, "column"),
            i(2, "asc"),
          })
        ),
        s(
          "latest",
          fmt("->latest('{}')", {
            i(1, "created_at"),
          })
        ),
        s(
          "groupBy",
          fmt("->groupBy('{}')", {
            i(1, "column"),
          })
        ),
        s(
          "with",
          fmt("->with('{}')", {
            i(1, "relation"),
          })
        ),
        s(
          "withCount",
          fmt("->withCount('{}')", {
            i(1, "relation"),
          })
        ),
        s(
          "paginate",
          fmt("->paginate({})", {
            i(1, "15"),
          })
        ),
        s(
          "scope",
          fmt(
            [[
public function scope{}(Builder $query{}): Builder
{{
    return $query->{};
}}
]],
            {
              i(1, "Active"),
              i(2, ""),
              i(3, "where('active', true)"),
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
