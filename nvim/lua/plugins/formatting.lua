-- conform.nvim: format on save. Go runs goimports (fix imports) then gofumpt
-- (stricter gofmt) as standalone binaries, decoupled from gopls.
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
    },
    format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  },
}
