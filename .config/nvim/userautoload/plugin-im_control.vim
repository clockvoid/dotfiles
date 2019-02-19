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
