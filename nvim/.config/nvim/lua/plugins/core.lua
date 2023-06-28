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
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.servers["lua_ls"] = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { globals = { "vim" } },
          },
        },
      }
    end,
  },

  {
    "akinsho/nvim-toggleterm.lua",
    name = "toggleterm",
    opts = {
      direction = "vertical",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      insert_mappings = false,
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

  {
    "folke/noice.nvim",
    enabled = false,
  },

  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      })
      opts.mapping["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    end,
  },

  { "Olical/aniseed" },
  { "Olical/conjure" },
}
