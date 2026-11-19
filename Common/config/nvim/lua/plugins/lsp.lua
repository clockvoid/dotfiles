vim.lsp.log.set_level('ERROR')
-- keymaps; see also: keymap.lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', function()
      local win_width = vim.api.nvim_win_get_width(0)
      local win_height = vim.api.nvim_win_get_height(0)
      vim.lsp.buf.hover({ max_width = win_width, max_height = win_height, border = 'rounded' })
    end, opts)
    vim.keymap.set('n', '<C-M-b>', vim.lsp.buf.implementation, opts)
    -- With xterm style sequence, S-F6 turned into F18
    vim.keymap.set('n', '<F18>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<M-CR>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<C-M-l>', vim.lsp.buf.format, opts)
    -- With xterm style sequence, M-F7 turned into F55
    vim.keymap.set('n', '<F55>', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<M-F7>', vim.lsp.buf.references, opts)
  end,
})

local function hook_lspconfig_loaded()
  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  })
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } }
      }
    }
  })
  require('mason').setup({
    ui = {
      border = 'rounded',
      backdrop = 100,
    }
  })

  vim.lsp.config['hls'] = {
    filetypes = { 'haskell' },
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    root_marks = { 'stack.yaml', 'cabal.project' },
  }
  vim.lsp.config['sourcekit'] = {
    filetypes = { 'swift' },
    cmd = { 'sourcekit-lsp' }
  }
  vim.lsp.config['dartls'] = {
    filetyles = { 'dart' },
    cmd = { 'fvm', 'dart', 'language-server', '--client-id', 'neovim.lsp' }
  }
  vim.lsp.enable({ 'hls', 'sourcekit', 'dartls' })
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
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-y>'] = cmp.mapping.scroll_docs(-4),
      ['<C-e>'] = cmp.mapping.scroll_docs(4),
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'vsnip' },
      { name = 'path' },
    }, {
      { name = 'buffer', max_item_count = 3, },
    }),
    window = {
      completion = cmp.config.window.bordered {
        border = 'none',
        winhighlight = "Normal:BlinkCmpMenu,CursorLine:BlinkCmpDocCursorLine",
      },
      documentation = cmp.config.window.bordered {
        border = 'rounded',
      },
    },
    formatting = {
      format = function(_, vim_item)
        vim_item.menu = ""
        return vim_item
      end
    }
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      {
        name = 'spell',
        option = {
          keep_all_entries = true,
          preselect_correct_word = false,
        },
        max_item_count = 5,
      },
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype({ 'markdown', 'tex' }, {
    sources = cmp.config.sources({
      { name = 'vsnip' },
      { name = 'path' },
    }, {
      {
        name = 'spell',
        option = {
          keep_all_entries = true,
          preselect_correct_word = false,
        },
        max_item_count = 5,
      },
      {
        name = 'buffer',
        max_item_count = 5,
      },
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
      { name = 'cmdline' },
    })
  })
end

return {
  { 'mason-org/mason.nvim' },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
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
  { 'f3fora/cmp-spell',     dependencies = { 'hrsh7th/nvim-cmp', } },
  { 'hrsh7th/nvim-cmp',     config = hook_cmp_loaded, },
  {
    'hrsh7th/vim-vsnip',
    config = function()
      vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/vsnip')
      vim.cmd('imap <expr> <C-k> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-k>"')
      vim.cmd('smap <expr> <C-k> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-k>"')
      vim.cmd('imap <expr> <C-S-k> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-S-k>"')
      vim.cmd('smap <expr> <C-S-k> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-[rev)" : "<C-S-k>"')
    end
  },

  {
    'dense-analysis/ale',
    config = function()
      require("ale").setup({
        use_neovim_diagnostics_api = true,
        linters = {
          javascript = { 'eslint' },
          typescript = { 'eslint' },
          go = { 'staticcheck' },
          markdown = { 'textlint' },
          tex = { 'textlint' }
        },
        fixers = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
        },
        linters_explicit = true,
        disable_lsp = true,
        completion_enabled = false,
        completion_autoimport = false,
        echo_cursor = false,
      })
    end,
  },
}
