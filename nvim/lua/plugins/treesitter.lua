-- nvim-treesitter `main` branch. Required for Neovim 0.12 (the frozen `master`
-- branch does not support 0.12). The API differs from master: install parsers
-- explicitly and start highlighting via a FileType autocmd; there is no
-- `configs.setup{}`, `ensure_installed`, or built-in highlight module.
local parsers = {
  "bash",
  "c",
  "diff",
  "dockerfile",
  "go",
  "gomod",
  "gowork",
  "gosum",
  "hcl",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "terraform",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        -- Only start where a parser is actually installed for this filetype.
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and pcall(vim.treesitter.start, args.buf, lang) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
