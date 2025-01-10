-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.g.maplocalleader = ","
opt.relativenumber = false

function get_system_theme()
  local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light"')
  local result = handle:read("*a")
  handle:close()
  return result:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace
end

if get_system_theme() == "Light" then
  vim.o.background = "light"
else
  vim.o.background = "dark"
end
