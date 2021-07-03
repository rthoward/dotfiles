local wk = require("which-key")

vim.o.timeoutlen = 300

-- Toggle terminal off on <Esc>
vim.cmd([[
	tnoremap <Esc> <C-\><C-n>
]])


wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created spelling = {
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator windows = true, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  }
})

wk.register({
  ["<space>"] = {"<cmd>Telescope find_files<cr>", "search"},

  t = {":ToggleTerm<cr>", "toggle terminal"},

  m = {
    name = "major",
    e = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "next error"},
    E = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "prev error"},
    a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "code action"},
    d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition"},
    f = {"<cmd>lua vim.lsp.buf.formatting()()<cr>", "formatting"},
    h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "hover"},
    r = {"<cmd>lua vim.lsp.buf.references()<cr>", "references"},

    x = {
      name = "+errors",
      x = { "<cmd>TroubleToggle<cr>", "Trouble" },
      w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
      d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
      l = { "<cmd>lopen<cr>", "Open Location List" },
      q = { "<cmd>copen<cr>", "Open Quickfix List" },
    },
  },

  h = {
    name = "help",
    d = "edit dotfiles",
    h = {"<cmd>Telescope help_tags<cr>", "help tags"},
    p = {
      name = "+packer",
      p = { "<cmd>PackerSync<cr>", "Sync" },
      s = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
    },
    r = {":source ~/.config/nvim/init.lua<cr>", "reload config"},
  },

  g = {
    name = "git",
    g = {":Neogit<cr>", "git"},
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
  },

  b = {
    name = "buffers",
    ["b"] = { "<cmd>:e #<cr>", "other buffer" },
    ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "previous buffer" },
    ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "previous buffer" },
    ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "next buffer" },
    ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "next buffer" },
    ["d"] = { "<cmd>:bd<CR>", "delete buffer" },
    ["g"] = { "<cmd>:BufferLinePick<CR>", "goto buffer" },
  },

  ["w"] = {
    name = "windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    [","] = {"<C-W>v", "split-window-right"},
    ["."] = {"<C-W>s", "split-window-down"},
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { ":resize +5", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { ":resize -5", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },

  f = {
    name = "files",
    t = {":NvimTreeToggle<cr>", "toggle tree"},
  },

  ["/"] = {"<cmd>Telescope live_grep<cr>", "grep"},

  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",
  ["0"] = "which_key_ignore",

  ["0-9"] = "select buffer",

}, { prefix = "<leader>" })
