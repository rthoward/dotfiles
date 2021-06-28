local wk = require("which-key")

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
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
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

  m = {
    name = "major",
    s = {"<cmd>builtin.lsp_workspace_symbols<cr>", "search workspace symbols"},
    e = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "next error"},
    E = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "prev error"},
    a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "code action"},
    d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition"},
    f = {"<cmd>lua vim.lsp.buf.formatting()()<cr>", "formatting"},
    h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "hover"},
    r = {"<cmd>lua vim.lsp.buf.references()<cr>", "references"},
  },

  h = {
    name = "help",
    h = {"<cmd>Telescope help_tags<cr>", "help tags"},
  },

  g = {
    name = "git",
    g = {":Neogit<cr>", "git"}
  },

  b = {
    name = "buffers",
    b = {"<cmd>Telescope buffers<cr>", "Buffer search"},
    n = {":bnext<cr>", "Next"},
    p = {":bprev<cr>", "Previous"},
  },

  w = {
    name = "windows",
    j = {"<C-W><C-J>", "down"},
    k = {"<C-W><C-K>", "up"},
    l = {"<C-W><C-L>", "right"},
    h = {"<C-W><C-H>", "left"},
    [","] = {"<C-W>v", "split right"},
    ["."] = {"<C-W>s", "split down"},
    d = {":close<CR>", "delete window"}
  },

  f = {
    name = "files",
    t = {":NvimTreeToggle<cr>", "toggle tree"},
    c = {
      name = "config",
      e = {
        name = "edit config",
        w = {":e ~/.config/nvim/lua/config/whichkey.lua<cr>", "which-key"},
        p = {":e ~/.config/nvim/lua/plugins.lua<cr>", "plugins"},
      },
      r = {":source ~/.config/nvim/init.lua<cr>", "reload config"},
    },
    p = {
      name = "plugins",
      i = {":PackerInstall<cr>", "install"},
      u = {":PackerUpdate<cr>", "update"},
      c = {":PackerClean<cr>", "clean"},
      C = {":PackerCompile<cr>", "compile"},
    }
  },

  p = {
    name = "project",
    f = {"<cmd>Telescope find_files", "search for project file"},
    g = {"<cmd>Telescope live_grep", "grep in project"},
  }
}, { prefix = "<leader>" })
