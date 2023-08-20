local function hook_post_source()
    if vim.fn.has('mac') == 1 then
        vim.opt.rtp:append('/usr/local/opt/fzf')
    end

    vim.g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-x'] = 'split',
        ['ctrl-v'] = 'vsplit'
    }

    vim.g.fzf_layout = {
        down = '~30%'
    }

    vim.g.fzf_colors = {
        fg      = { 'fg', 'Normal' },
        bg      = { 'bg', 'Normal' },
        hl      = { 'fg', 'Comment' },
        ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
        ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
        ['hl+'] = { 'fg', 'Statement' },
        info    = { 'fg', 'PreProc' },
        border  = { 'fg', 'Ignore' },
        prompt  = { 'fg', 'Conditional' },
        pointer = { 'fg', 'Exception' },
        marker  = { 'fg', 'Keyword' },
        spinner = { 'fg', 'Label' },
        header  = { 'fg', 'Comment' }
    }

    vim.g.fzf_history_dir = '~/.local/share/fzf-history'
    vim.api.nvim_set_keymap('n', '<C-f>', ':Files<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', { noremap = true })
end

return {
    {
        'junegunn/fzf',
        build = 'bash ./install --all'
    },
    {
        'junegunn/fzf.vim',
        config = hook_post_source(),
        dependencies = { 'junegunn/fzf' }
    },
}
