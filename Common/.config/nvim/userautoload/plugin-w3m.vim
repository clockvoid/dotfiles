let g:w3m#command = '/usr/local/bin/w3m'

let g:w3m#external_browser = 'chrome'
let g:w3m#homepage = "http://www.google.co.jp/"
let g:w3m#hit_a_hint_key = 'f'
let g:w3m#lang = 'en_US'
"let g:w3m#set_hover_on
"let g:w3m#hover_set_on = -1 
" a value less than or equal to 0 will turn it off

" set delay time until highlighting
"let g:w3m#hover_delay_time = 100

function! s:custom_keymap()
    nmap <buffer>H <Plug>(w3m-back)
    nmap <buffer>L <Plug>(w3m-forward)
endfunction

augroup w3m
    au BufWinEnter w3m* silent! call s:custom_keymap()
augroup END
