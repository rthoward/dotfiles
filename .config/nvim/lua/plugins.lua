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

    use({
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey")
      end
    })

    use({
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      config = function()
        require("config.lsp")
      end,
    })

  use({"jose-elias-alvarez/null-ls.nvim"})
  use({"jose-elias-alvarez/nvim-lsp-ts-utils"})

    use({
      "hrsh7th/nvim-compe",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.compe")
      end,
      requires = {
        {
          "windwp/nvim-autopairs",
          config = function()
            require("config.autopairs")
          end,
        },
        {
          "RRethy/vim-illuminate",
          opt = true,
          event = "CursorHold",
          module = "illuminate",
          config = function()
            vim.g.Illuminate_delay = 1000
          end,
        },
      }
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
      opt = true,
      event = "BufRead",
      branch = '0.5-compat',
      run = ":TSUpdate",
      requires = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-textobjects" },
      config = [[require('config.treesitter')]],
    })

    use({"rktjmp/lush.nvim"})

    -- colorschemes
    use({
      --[[ "shaunsingh/nord.nvim",
      "shaunsingh/moonlight.nvim",
      { "marko-cerovac/material.nvim" }, ]] --
      "morhetz/gruvbox",
      "folke/tokyonight.nvim",
      "joshdick/onedark.vim",
      "sainnhe/sonokai",
      "mcchrish/zenbones.nvim",
      "iandwelker/rose-pine-vim",
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
        "nvim-telescope/telescope-symbols.nvim",
      },
    })

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
        {"nvim-lua/plenary.nvim"},
        {"sindrets/diffview.nvim"},
      },
      config = function()
        require("config.neogit")
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
        require("config.trouble")
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

    use({
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" }
    })

  end,
  config = config,
})

