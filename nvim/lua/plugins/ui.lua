-- Statusline, keymap hints, and the icon provider.
return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Let plugins that ask for nvim-web-devicons transparently use mini.icons.
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        section_separators = "",
        component_separators = "|",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
