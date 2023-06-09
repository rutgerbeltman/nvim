-- LSP settings.
local rutgerlsp = require "rutger.lsp"
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local mason_lspconfig = require 'mason-lspconfig'

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
   clangd = {},
   -- gopls = {},
   pyright = {},
   rust_analyzer = {},
   lua_ls = {
      Lua = {
         workspace = { checkThirdParty = false },
         telemetry = { enable = false },
      },
   },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
mason_lspconfig.setup {
   ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
   function(server_name)
      require('lspconfig')[server_name].setup {
         capabilities = rutgerlsp.capabilities,
         on_attach = rutgerlsp.on_attach,
         settings = servers[server_name],
      }
   end,
}

-- nvim-cmp setup
luasnip.config.setup {}

cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { 'i', 's' }),
   },
   sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   },
}
