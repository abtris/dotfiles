-- Editor options. Set before plugins load.
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false -- statusline shows the mode
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split" -- live preview of :substitute
opt.cursorline = true
opt.scrolloff = 8
opt.termguicolors = true
opt.confirm = true -- prompt instead of failing on unsaved changes

-- Two-space soft tabs by default; Go overrides to real tabs (see autocmds.lua).
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Sync with the system clipboard, but schedule it so startup stays fast.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
