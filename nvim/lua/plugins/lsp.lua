-- LSP via the native Neovim 0.11+/0.12 API: vim.lsp.config sets per-server
-- options and mason-lspconfig's automatic_enable calls vim.lsp.enable for us.
-- require('lspconfig').xxx.setup{} is legacy and intentionally unused.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = true },
      virtual_text = { spacing = 2 },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
    })

    -- Completion capabilities from blink apply to every server.
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
          diagnostics = { globals = { "vim" } },
          telemetry = { enable = false },
        },
      },
    })

    -- gopls tuned for serious Go work: static analysis, inlay hints, codelenses.
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
          completeUnimported = true,
          semanticTokens = true,
          directoryFilters = { "-**/node_modules", "-.git" },
          analyses = {
            unusedparams = true,
            shadow = true,
            nilness = true,
            unusedwrite = true,
            useany = true,
          },
          codelenses = {
            gc_details = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            generate = true,
            run_govulncheck = true,
          },
          hints = {
            parameterNames = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    -- Language servers (auto-enabled by mason-lspconfig once installed).
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "gopls" },
      automatic_enable = true,
    })

    -- Non-LSP tools used by conform/nvim-lint/dap.
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",
        "goimports",
        "gofumpt",
        "golangci-lint",
        "delve",
        "markdownlint-cli2",
      },
    })
  end,
}
