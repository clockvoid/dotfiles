" START: define filetypes ------------------------------------------------
augroup DefineFileTypes
	autocmd!
	autocmd BufRead,BufNewFile .xmobarrc setfiletype haskell
	autocmd BufRead,BufNewFile *.hs setlocal filetype=haskell
	autocmd BufRead,BufNewFile *.rb setlocal filetype=ruby
	autocmd BufRead,BufNewFile *.py setlocal filetype=python
	autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript
augroup END
" END: define filetypes --------------------------------------------------

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:plugins_dir = has('nvim') ? expand('~/.config/nvim/plugins') :
                                  \ expand('~/.vim/plugins')

  call dein#load_toml(s:plugins_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:plugins_dir . '/dein.lazy.toml', {'lazy': 1})

  if dein#check_install()
    call dein#install()
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
runtime! userautoload/*.vim
