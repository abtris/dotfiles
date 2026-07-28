-- Autocommands.
local augroup = vim.api.nvim_create_augroup

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Go uses real tabs (gofmt). Override the 2-space soft-tab default.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("go-tabs", { clear = true }),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Buffer-local LSP behavior: enable inlay hints where supported. Buffer keymaps
-- are mostly unnecessary because 0.11+ ships defaults (grn/gra/grr/gri/grt/gO/K),
-- so we add only go-to-definition, which is not a default.
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, { buffer = args.buf, desc = "Toggle inlay hints" })
    end
  end,
})
