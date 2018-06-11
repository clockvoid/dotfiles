if executable('ibus')

	call system('ibus engine "xkb:jp::jpn" &')

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
	    let res = system('ibus engine "mozc-jp" &')
      elseif cmd == 'Off'
	    let res = system('ibus engine "xkb:jp::jpn" &')
	  endif
	  return ''
	endfunction

	augroup LeaveVim
		autocmd!
		autocmd VimLeave * call system('ibus engine "xkb:jp::jpn" &') 
	augroup END

endif
