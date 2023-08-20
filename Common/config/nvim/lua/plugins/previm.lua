local function hook_source()
    if vim.fn.has('mac') == 1 then
        vim.g.previm_open_cmd = 'open -a "Google Chrome"'
    elseif string.match(vim.fn.system('uname'), 'Linux') then
        vim.g.previm_open_cmd = 'google-chrome-stable'
    end
end

return {
    {
        'kannokanno/previm',
        config = hook_source,
        ft = { 'markdown' },
    }
}
