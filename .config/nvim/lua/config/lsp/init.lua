local lspconfig = require("lspconfig")

if vim.lsp.setup then
  vim.lsp.setup({
    floating_preview = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
    diagnostics = {
      signs = { error = " ", warning = " ", hint = " ", information = " " },
      display = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
    },
    completion = {
      kind = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = "了 ",
        EnumMember = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = "ƒ ",
        Module = " ",
        Property = " ",
        Snippet = "﬌ ",
        Struct = " ",
        Text = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      },
    },
  })
else
  require("config.lsp.diagnostics")
  require("config.lsp.kind").setup()
end

local function on_attach(client, bufnr)
  --[[ require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.completion").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client) ]]

  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')

  require("lsp_signature").on_attach()

  -- TypeScript specific stuff
  --[[ if client.name == "typescript" or client.name == "tsserver" then
    require("config.lsp.ts-utils").setup(client)
  end ]]
end

--[[ local lua_cmd = {
  "/Users/folke/projects/lua-language-server/bin/macOS/lua-language-server",
  "-E",
  "-e",
  "LANG=en",
  "/Users/folke/projects/lua-language-server/main.lua",
}
lua_cmd = { "lua-language-server" } ]]

local servers = {
  pyright = {},
  tsserver = {},
  solargraph = {},
  -- cssls = { cmd = { "css-languageserver", "--stdio" } },
  -- tailwindcss = {},
  --[[ sumneko_lua = require("lua-dev").setup({
    lspconfig = { cmd = lua_cmd },
  }), ]]
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 300,
    },
    handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
           -- Disable virtual_text
           virtual_text = false
         }
       ),
     }
  }, config))
  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    vim.notify(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end
