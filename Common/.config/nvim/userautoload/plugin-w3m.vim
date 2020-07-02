
let g:w3m#external_browser = 'chrome'
let g:w3m#homepage = "https://www.google.co.jp"
let g:w3m#search_engine = 'https://www.google.co.jp/search?ie=' . &encoding . '&q=%s'
let g:w3m#search_engine_list = [
            \{'name': 'android', 'url': 'https://cs.android.com/search?q=%s&sq='},
            \{'name': 'github', 'url': 'https://github.com/search?q=%s'},
            \{'name': 'hoogle', 'url': 'https://hoogle.haskell.org/?hoogle=%s&scope=set:stackage'},
            \{'name': 'dictionary', 'url': 'https://www.sanseido.biz/User/Dic/Index.aspx?TWords=%s&st=0&DORDER=&DailyEJ=checkbox&DailyJE=checkbox'},
            \]
let g:w3m#hit_a_hint_key = 'f'
let g:w3m#lang = 'en_US'

function! s:custom_keymap()
    nmap <buffer>H <Plug>(w3m-back)
    nmap <buffer>L <Plug>(w3m-forward)
endfunction

augroup w3m
    au BufWinEnter w3m* silent! call s:custom_keymap()
augroup END
