" Neovim-qt Guifont command
"command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "\<args\>") | let g:Guifont="<args>"
Guifont DejaVu Sans Mono for Powerline:h12

call rpcnotify(1, 'Gui', 'Font', 'DejaVu Sans Mono for Powerline 12')

"let g:Guifont="DejaVu Sans Mono for Powerline:h12"
