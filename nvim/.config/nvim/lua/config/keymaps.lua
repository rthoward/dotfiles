-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")

wk.register({
  ["<leader>w"] = {
    ["w"] = { "<C-W>p", "Other window" },
    ["d"] = { "<C-W>c", "Delete window" },
    [","] = { "<C-W>v", "Split window right" },
    ["."] = { "<C-W>s", "Split window down" },
    ["2"] = { "<C-W>v", "Double column layout" },
    ["h"] = { "<C-W>h", "Window left" },
    ["j"] = { "<C-W>j", "Window below" },
    ["l"] = { "<C-W>l", "Window right" },
    ["k"] = { "<C-W>k", "Window up" },
    ["H"] = { "<C-W>5<", "Expand window left" },
    ["J"] = { ":resize +5", "Expand window below" },
    ["L"] = { "<C-W>5>", "Expand window right" },
    ["K"] = { ":resize -5", "Expand window up" },
    ["="] = { "<C-W>=", "Balance window" },
    ["s"] = { "<C-W>s", "Split window below" },
    ["v"] = { "<C-W>v", "Split window right" },
  },
  ["<leader>b"] = {
    ["p"] = { ":bp<CR>", "Previous" },
  },
  ["<leader>g"] = {
    ["g"] = { "<cmd>Neogit<cr>", "NeoGit" },
    ["G"] = { "<cmd>Neogit kind=split<cr>", "NeoGit split" },
  },
  ["<leader>t"] = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
})
