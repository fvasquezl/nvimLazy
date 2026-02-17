return {
  -- Filament-specific snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

      ls.add_snippets("php", {
        -- Filament Resource
        s(
          "filament.resource",
          fmt(
            [[
<?php

namespace App\Filament\Resources;

use App\Filament\Resources\{}Resource\Pages;
use App\Models\{};
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class {}Resource extends Resource
{{
    protected static ?string $model = {}::class;

    protected static ?string $navigationIcon = 'heroicon-o-{}';

    public static function form(Form $form): Form
    {{
        return $form
            ->schema([
                {}
            ]);
    }}

    public static function table(Table $table): Table
    {{
        return $table
            ->columns([
                {}
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }}

    public static function getRelations(): array
    {{
        return [
            //
        ];
    }}

    public static function getPages(): array
    {{
        return [
            'index' => Pages\List{}::route('/'),
            'create' => Pages\Create{}::route('/create'),
            'edit' => Pages\Edit{}::route('/{{record}}/edit'),
        ];
    }}
}}
]],
            {
              i(1, "Model"),
              i(2, "Model"),
              i(3, "Model"),
              i(4, "Model"),
              i(5, "rectangle-stack"),
              i(6, "Forms\\Components\\TextInput::make('name')->required()"),
              i(7, "Tables\\Columns\\TextColumn::make('name')"),
              i(8, "Models"),
              i(9, "Models"),
              i(10, "Models"),
            }
          )
        ),

        -- Filament Form Components
        s(
          "filament.form.text",
          fmt("Forms\\Components\\TextInput::make('{}')\n    ->required()\n    ->maxLength(255),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.form.textarea",
          fmt("Forms\\Components\\Textarea::make('{}')\n    ->required()\n    ->columnSpanFull(),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.form.select",
          fmt("Forms\\Components\\Select::make('{}')\n    ->options({})\n    ->required(),", {
            i(1, "field"),
            i(2, "[]"),
          })
        ),
        s(
          "filament.form.toggle",
          fmt("Forms\\Components\\Toggle::make('{}')\n    ->required(),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.form.datepicker",
          fmt("Forms\\Components\\DatePicker::make('{}')\n    ->required(),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.form.repeater",
          fmt(
            [[
Forms\Components\Repeater::make('{}')
    ->schema([
        {}
    ])
    ->columns(2),
]],
            {
              i(1, "items"),
              i(2, "Forms\\Components\\TextInput::make('name')"),
            }
          )
        ),
        s(
          "filament.form.section",
          fmt(
            [[
Forms\Components\Section::make('{}')
    ->schema([
        {}
    ])
    ->columns(2),
]],
            {
              i(1, "Section Title"),
              i(2, "// components"),
            }
          )
        ),

        -- Filament Table Columns
        s(
          "filament.table.text",
          fmt("Tables\\Columns\\TextColumn::make('{}')\n    ->searchable()\n    ->sortable(),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.table.badge",
          fmt("Tables\\Columns\\BadgeColumn::make('{}')\n    ->colors({}),", {
            i(1, "status"),
            i(2, "['success' => 'active']"),
          })
        ),
        s(
          "filament.table.boolean",
          fmt("Tables\\Columns\\IconColumn::make('{}')\n    ->boolean(),", {
            i(1, "field"),
          })
        ),
        s(
          "filament.table.image",
          fmt("Tables\\Columns\\ImageColumn::make('{}')\n    ->circular(),", {
            i(1, "avatar"),
          })
        ),

        -- Filament Actions
        s(
          "filament.action",
          fmt(
            [[
Tables\Actions\Action::make('{}')
    ->icon('heroicon-o-{}')
    ->action(function ({} $record) {{
        {}
    }}),
]],
            {
              i(1, "action_name"),
              i(2, "check"),
              i(3, "Model"),
              i(4, "// action logic"),
            }
          )
        ),

        -- Filament Widget
        s(
          "filament.widget",
          fmt(
            [[
<?php

namespace App\Filament\Widgets;

use Filament\Widgets\{}Widget;

class {} extends {}Widget
{{
    protected static ?int $sort = {};

    protected function getData(): array
    {{
        return [
            {}
        ];
    }}
}}
]],
            {
              i(1, "Chart"),
              i(2, "WidgetName"),
              i(3, "Chart"),
              i(4, "1"),
              i(5, "// data"),
            }
          )
        ),

        -- Filament Page
        s(
          "filament.page",
          fmt(
            [[
<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;

class {} extends Page
{{
    protected static ?string $navigationIcon = 'heroicon-o-{}';

    protected static string $view = 'filament.pages.{}';

    {}
}}
]],
            {
              i(1, "PageName"),
              i(2, "document-text"),
              i(3, "page-name"),
              i(4, ""),
            }
          )
        ),

        -- Filament Relation Manager
        s(
          "filament.relation",
          fmt(
            [[
<?php

namespace App\Filament\Resources\{}Resource\RelationManagers;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class {}RelationManager extends RelationManager
{{
    protected static string $relationship = '{}';

    public function form(Form $form): Form
    {{
        return $form
            ->schema([
                {}
            ]);
    }}

    public function table(Table $table): Table
    {{
        return $table
            ->columns([
                {}
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }}
}}
]],
            {
              i(1, "Parent"),
              i(2, "Relation"),
              i(3, "relation"),
              i(4, "Forms\\Components\\TextInput::make('name')"),
              i(5, "Tables\\Columns\\TextColumn::make('name')"),
            }
          )
        ),

        -- Livewire component (for custom Filament components)
        s(
          "livewire.filament",
          fmt(
            [[
<?php

namespace App\Livewire;

use Livewire\Component;

class {} extends Component
{{
    {}

    public function render()
    {{
        return view('livewire.{}');
    }}
}}
]],
            {
              i(1, "ComponentName"),
              i(2, "public $property;"),
              i(3, "component-name"),
            }
          )
        ),
      })

      -- Alpine.js snippets for Blade
      ls.add_snippets("blade", {
        s(
          "alpine.data",
          fmt("x-data=\"{{ {} }}\"", {
            i(1, "{}"),
          })
        ),
        s("alpine.show", {
          t('x-show="'),
          i(1, "condition"),
          t('"'),
        }),
        s("alpine.if", {
          t('x-if="'),
          i(1, "condition"),
          t('"'),
        }),
        s("alpine.for", {
          t('x-for="'),
          i(1, "item in items"),
          t('"'),
        }),
        s("alpine.on", {
          t("x-on:"),
          i(1, "click"),
          t('="'),
          i(2, "handler"),
          t('"'),
        }),
        s("alpine.model", {
          t('x-model="'),
          i(1, "property"),
          t('"'),
        }),
      })
    end,
  },

  -- Telescope: Add Filament-specific searches
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      {
        "<leader>fFr",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() .. "/app/Filament/Resources" })
        end,
        desc = "Find Filament Resources",
      },
      {
        "<leader>fFp",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() .. "/app/Filament/Pages" })
        end,
        desc = "Find Filament Pages",
      },
      {
        "<leader>fFw",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() .. "/app/Filament/Widgets" })
        end,
        desc = "Find Filament Widgets",
      },
      {
        "<leader>fFc",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() .. "/app/Filament/Clusters" })
        end,
        desc = "Find Filament Clusters",
      },
    },
  },
}
