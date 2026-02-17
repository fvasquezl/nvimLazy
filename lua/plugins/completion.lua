return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          -- Don't auto-select the first item
          selection = { preselect = false, auto_insert = false },
        },
      },
      keymap = {
        -- CR only confirms if an item was explicitly selected
        ["<CR>"] = { "accept", "fallback" },
      },
    },
  },
}
