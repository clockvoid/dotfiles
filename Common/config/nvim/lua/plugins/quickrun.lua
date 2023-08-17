return {
    {
        'thinca/vim-quickrun',
        config = function ()
            vim.cmd([[
            let g:quickrun_config = {
                \ "_": {
                    \       "outputter/buffer/opener" : '%{winwidth(0) * 2 < winheight(0) * 5 ? "new" : "botright vnew"}',
                    \		"outputter/error/success" : "buffer",
                    \		"outputter/error/error" : "quickfix"
                    \	}
                    \}

            let g:quickrun_config['html'] = {
                \   'outputter/buffer/opener' : '',
                \	'command' : 'google-chrome-stable',
                \	'exec' : '%c %s',
                \}
            ]])
        end
    }
}
