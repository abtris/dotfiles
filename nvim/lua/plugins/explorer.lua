-- oil.nvim: edit the filesystem like a buffer. `-` opens the parent directory.
return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
  },
  opts = {
    view_options = { show_hidden = true },
  },
}
