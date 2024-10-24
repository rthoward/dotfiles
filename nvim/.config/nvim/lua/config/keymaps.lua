-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")

wk.add({
  { "<leader>gg", "<cmd>Neogit<cr>", desc = "NeoGit" },
  { "<leader>gG", "<cmd>Neogit kind=split<cr>", desc = "NeoGit split" },

  { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
})
