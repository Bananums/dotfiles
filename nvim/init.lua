-- Setting leader kay before anything
vim.g.mapleader = " "
vim.g.maplovaleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- enable full color selection
vim.opt.termguicolors = true

require("config.remap");
require("config.options");
require("config.lazy");

