local function hook_source()
  vim.g.quickrun_config = {
    _ = {
      ['outputter/buffer/opener'] = '%{winwidth(0) * 2 < winheight(0) * 5 ? "new" : "botright vnew"}',
      ['outputter/buffer/success'] = 'buffer',
      ['outputter/buffer/error'] = 'quickfix'
    },

    html = {
      ['outputter/buffer/opener'] = '',
      ['command'] = 'google-chrome-stable',
      ['exec'] = '%c %s'
    }
  }
end

return {
  {
    'thinca/vim-quickrun',
    config = hook_source
  }
}
