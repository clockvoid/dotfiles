vim.lsp.set_log_level('ERROR')
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-M-l>', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'L', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<C-M-b>', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<F6>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist<CR>', opts)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
    )
  end,
})

local function hook_lspconfig_loaded()
  require('mason').setup()
  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } }
          }
        }
      }
    end
  }
  require('lspconfig').hls.setup {
    filetypes = { 'haskell' },
    cmd = { 'haskell-language-server-wrapper', '--lsp' }
  }
  require('lspconfig').sourcekit.setup {
    filetypes = { 'swift' },
    cmd = { 'sourcekit-lsp' }
  }
  require('lspconfig').dartls.setup {
    filetyles = { 'dart' },
    cmd = { 'dart', 'language-server', '--client-id', 'neovim.lsp' }
  }
end

local function hook_cmp_loaded()
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-f>'] = cmp.mapping.scroll_docs(-4),
      ['<C-b>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'vsnip' },
      { name = 'path' },
    }, {
      { name = 'buffer' },
    }),
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' }
    })
  })
end

return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'mason-org/mason-registry' },
  {
    'neovim/nvim-lspconfig',
    config = hook_lspconfig_loaded,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'mason-org/mason-registry',
    }
  },

  { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/cmp-buffer',   dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/cmp-path',     dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/cmp-cmdline',  dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/cmp-vsnip',    dependencies = { 'hrsh7th/vim-vsnip', 'hrsh7th/nvim-cmp', } },
  { 'petertriho/cmp-git',   dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/nvim-cmp',     config = hook_cmp_loaded, },
  {
    'hrsh7th/vim-vsnip',
    config = function()
      vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/vsnip')
      vim.cmd([[
imap <expr> <C-k> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-k>'
imap <expr> <C-S-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-S-k>'
smap <expr> <C-S-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-[rev)' : '<C-S-k>'
    ]])
    end
  },

  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_disable_lsp = 1
      vim.g.ale_comletion_enabled = 0
      vim.g.ale_completion_autoimport = 0
      vim.g.ale_echo_cursor = 0
      vim.g.ale_use_neovim_diagnostics_api = 1
      vim.g.ale_linters = {
        markdown = {},
        tex = { 'textlint' },
        javascript = { 'eslint' },
        go = { 'staticcheck' },
        haskell = {},
        rust = {},
      }
    end,
  },

  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end,
  }
}
