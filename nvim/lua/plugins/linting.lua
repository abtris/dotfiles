-- nvim-lint: linters that run alongside the LSP. golangci-lint for Go,
-- markdownlint-cli2 for Markdown.
--
-- The autocmd only runs linters whose executable is actually present, so a
-- missing tool degrades to "no linting" instead of throwing an error on every
-- save (which is what happened when this pointed at `markdownlint`, a binary
-- that was not installed).
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      go = { "golangcilint" },
      markdown = { "markdownlint-cli2" },
    }

    local function runnable_linters()
      local names = lint.linters_by_ft[vim.bo.filetype] or {}
      local ok = {}
      for _, name in ipairs(names) do
        local linter = lint.linters[name]
        local cmd = linter and (type(linter.cmd) == "function" and linter.cmd() or linter.cmd)
        if cmd and vim.fn.executable(cmd) == 1 then
          table.insert(ok, name)
        end
      end
      return ok
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        local names = runnable_linters()
        if #names > 0 then
          lint.try_lint(names)
        end
      end,
    })
  end,
}
