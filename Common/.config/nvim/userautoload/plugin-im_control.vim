if executable('xvkbd')

    call system('xvkbd -text "\[Muhenkan]" > /dev/null 2>&1 & ')

    " 「日本語入力固定モード」の動作モード
    let IM_CtrlMode = 1
    let IMState = 2
    " 「日本語入力固定モード」切替キー
    inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>

    " IBus 1.5以降
    function! IMCtrl(cmd)
        let cmd = a:cmd
        let type = &filetype
        if cmd == 'On' && (type == 'tex' || type == 'markdown')
            call system('xvkbd -text "\[Henkan]" > /dev/null 2>&1 & ')
        elseif cmd == 'Off'
            call system('xvkbd -text "\[Muhenkan]" > /dev/null 2>&1 & ')
        endif
        return ''
    endfunction

    augroup LeaveVim
        autocmd!
        autocmd VimLeave * call system('xvkbd -text "\[Muhenkan]" > /dev/null 2>&1 & ') 
    augroup END

endif

if has('mac')
"
"    " 「日本語入力固定モード」切替キー
"    inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
"
"    if has('gui_running')
"        let IM_CtrlMode = 4
"    else
"        let IM_CtrlMode = 1
"        let IMState = 2
"
"        function! IMCtrl(cmd)
"            let cmd = a:cmd
"            let type = &filetype
"            if cmd == 'On' && (type == 'tex' || type == 'markdown')
"                let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
"            elseif cmd == 'Off'
"                let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
"            elseif cmd == 'Toggle'
"                let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
"            endif
"            return ''
"        endfunction
"    endif
"
"    " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
"    let IM_CtrlMacVimKaoriya = 0
"    " ctrl+jで日本語入力固定モードをOnOff
"    inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
"
endif
