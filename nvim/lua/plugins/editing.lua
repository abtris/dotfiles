-- mini.nvim editing modules. Comment/snippet plugins are omitted: Neovim ships
-- built-in gc/gcc commenting and vim.snippet.
return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup() -- richer text objects (a/i for functions, args, ...)
    require("mini.surround").setup() -- add/delete/replace surrounding pairs
    require("mini.pairs").setup() -- auto-close brackets and quotes
  end,
}
