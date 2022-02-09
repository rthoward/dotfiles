local util = require("util")

vim.o.completeopt = "menuone,noselect"

require("compe").setup({
  enabled = true,
  autocomplete = true,
  preselect = "always", -- changed to "enable" to prevent auto select
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  -- documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, },

  source = {
    path = true,
    buffer = false,
    calc = false,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = false,
    luasnip = true,
    treesitter = false,
    emoji = false,
    spell = false,
    orgmode = true,
    -- neorg = true,
  },
})

util.inoremap("<C-Space>", "compe#complete()", { expr = true })
util.inoremap("<CR>", "compe#confirm('<CR>')", { expr = true })
util.inoremap("<C-e>", "compe#close('<C-e>')", { expr = true })

local function complete()
  return vim.fn["compe#confirm"]({ keys = "<cr>", select = true })
end

vim.cmd([[autocmd User CompeConfirmDone silent! lua vim.lsp.buf.signature_help()]])
