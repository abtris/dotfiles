-- Non-plugin keymaps. Plugin-specific maps live in each plugin spec's `keys`.
-- LSP maps are NOT here: Neovim 0.11+ ships grn/gra/grr/gri/grt/gO/K built in.
local map = vim.keymap.set

-- Clear search highlight.
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics.
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Window navigation with Ctrl+hjkl.
map("n", "<C-h>", "<C-w><C-h>", { desc = "Go to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Go to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Go to upper window" })

-- Move selected lines up/down keeping indentation.
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep the cursor centered when jumping half-pages and through search results.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
