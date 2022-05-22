
function! plugin#previm#hook_add() abort
    if has("mac")
        let g:previm_open_cmd = 'open -a "Google Chrome"'
    elseif has("unix")
        let uname = system("uname -s")
        if uname == "Linux"
            let g:previm_open_cmd = 'google-chrome-stable'
        endif
    endif
endfunction
