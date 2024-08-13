return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "Shatur/neovim-ayu", name = "ayu", priority = 1000 },

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
      colorscheme = "ayu-mirage",
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.servers["elixirls"] = {
        cmd = { "/Users/richard/.elixir_ls_bin/release/language_server.sh" },
      }

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

  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    })

    -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
    -- add `org` to ignore_install
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      ignore_install = { "org" },
    })
  end,

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },

  {
    "akinsho/org-bullets.nvim",
  },

  { "Olical/aniseed" },
  { "Olical/conjure" },
}
