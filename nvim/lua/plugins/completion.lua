-- blink.cmp: the current default completion engine (Rust fuzzy matcher).
-- Pinned to 1.* so lazy downloads a prebuilt binary (no cargo needed). v2 has
-- breaking changes in progress.
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
