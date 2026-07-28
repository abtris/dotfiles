-- catppuccin-mocha, to match the theme used everywhere else in these dotfiles.
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before UI plugins so it is the startup theme
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        telescope = { enabled = true },
        gitsigns = true,
        which_key = true,
        mason = true,
        blink_cmp = true,
        dap = true,
        dap_ui = true,
      },
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
