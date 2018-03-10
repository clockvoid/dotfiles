" START: settings for QuickRun
" For QuickRun
let g:quickrun_config = {
\	"_": {
\		"runner" : "vimproc",
\		"runner/vimproc/updatetime" : 40,
\       "outputter/buffer/split" : ":botright 5sp", 
\       "outputter/buffer/close_on_empty" : 1,
\       "outputter/browser/name" : "google-chrome-stable",
\		"outputter/error/success" : "buffer",
\		"outputter/error/error" : "quickfix"
\	}
\}

let g:quickrun_config['html'] = {
\	'command' : 'open',
\	'exec' : '%c %s',
\	'outputter' : 'browser'
\}

let g:quickrun_config['c'] = {
\	'command': 'gcc',
\	'cmdopt': '-lm'
\}

let g:quickrun_config['phpunit'] = {
\   'outputter/buffer/split' : 'vertical 35',
\   'command' : 'phpunit',
\   'cmdopt' : '--colors=auto',
\   'exec' : '%c %o %s'
\}
" END: settings for QuickRun
