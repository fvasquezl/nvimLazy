return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPost",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"] = "<leader>A",
        ["Skip Region"] = "q",
        ["Remove Region"] = "Q",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }
      vim.g.VM_theme = "ocean"
      vim.g.VM_highlight_matches = "underline"
    end,
  },
}
