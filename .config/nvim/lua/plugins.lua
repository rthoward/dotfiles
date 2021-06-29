local util = require("util")

local config = {
  profile = {
    enable = true,
    threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

return require("packer").startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim", opt = true })

    use({ "kyazdani42/nvim-tree.lua" })

    use({
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey")
      end
    })

    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp")
      end,
    })

    use({
      "hrsh7th/nvim-compe",
      config = function()
        require("config.compe")
      end,
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
    })

    use({
      "b3nj5m1n/kommentary",
      opt = true,
      wants = "nvim-ts-context-commentstring",
      keys = { "gc", "gcc" },
      config = function()
        require("config.comments")
      end,
      requires = "JoosepAlviste/nvim-ts-context-commentstring",
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-textobjects" },
      config = [[require('config.treesitter')]],
    })

    use({
      "shaunsingh/nord.nvim",
      "shaunsingh/moonlight.nvim",
      "joshdick/onedark.vim",
      { "marko-cerovac/material.nvim" },
      "folke/tokyonight.nvim",
      "sainnhe/sonokai",
      "morhetz/gruvbox",
    })

    -- Theme: icons
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    })

    -- Dashboard
    use({ "glepnir/dashboard-nvim", config = [[require('config.dashboard')]] })

    use({
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.bufferline")
      end,
    })

    use({ "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" })

    -- Fuzzy finder
    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("config.telescope")
      end,
      cmd = { "Telescope" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
      },
    })

    -- Indent Guides and rainbow brackets
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      branch = "lua",
      config = function()
        require("config.blankline")
      end,
    })

    -- Smooth Scrolling
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("config.scroll")
      end,
    })

    -- Git Gutter
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns")
      end,
    })

    use({
      "TimUntersberger/neogit",
      cmd = "Neogit",
      requires = { 
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("config.neogit")
      end,
    })

    use({
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
      config = function()
        require("config.diffview")
      end,
    })

    use({ "npxbr/glow.nvim", cmd = "Glow" })

    use({
      "plasticboy/vim-markdown",
      opt = true,
      requires = "godlygeek/tabular",
      ft = "markdown",
      config = function()
        require("config.markdown")
      end,
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = { "markdown" },
      cmd = "MarkdownPreview",
    })

    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

    use({
      "ray-x/lsp_signature.nvim",
    })

    use({
      "akinsho/nvim-toggleterm.lua",
      opt = true,
      cmd = { "ToggleTerm", "TermExec" },
      config = function()
        require("config.toggleterm")
      end
    })

     use({
      "folke/trouble.nvim",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup({ auto_open = false })
      end,
    })

    use({
      "hoob3rt/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine")
      end,
      wants = "nvim-web-devicons",
    })

  end,
  config = config,
})

