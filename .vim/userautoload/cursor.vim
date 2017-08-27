"if &term =~ "xterm\\|rxvt"
"  " use an orange cursor in insert mode
"  let &t_SI = "\<Esc>]12;orange\x7"
"  " use a red cursor otherwise
"  let &t_EI = "\<Esc>]12;red\x7"
"  silent !echo -ne "\033]12;red\007"
"  " reset cursor when vim exits
"  autocmd VimLeave * silent !echo -ne "\033]112\007"
"  " use \003]12;gray\007 for gnome-terminal
"endif


"if &term =~ "^screen"
"	if exists('$TMUX')
"	  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"	  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"	else
"	  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"	  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"	endif
"elseif &term =~ "xterm\\|rxvt"
"  " solid underscore
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
"endif

