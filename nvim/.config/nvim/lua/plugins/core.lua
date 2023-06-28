return {
  { "catppuccin/nvim", name = "catppuccin" },

  {
    "mcchrish/zenbones.nvim",
    name = "zenbones",
    dependencies = { "rktjmp/lush.nvim" },
  },

  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenbones",
    },

    {
      "neovim/nvim-lspconfig",
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          -- pyright will be automatically installed with mason and loaded with lspconfig
          pyright = {},
        },
      },
    },

    {
      "telescope.nvim",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },

    {
      "rcarriga/nvim-notify",
      opts = {
        render = "compact",
      },
    },
  },

  {
    "folke/noice.nvim",
    enabled = false,
  },
}
