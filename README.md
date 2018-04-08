# dotfiles
my using dotfiles including vimrc and xmonad.hs

## Description
僕が使ってるdotfilesです．`.vimrc`と`xmonad.hs`もここで管理してしまおうと考えています．

## Installation
`install.sh`を作りました👏

このスクリプトを使用するには，次のようにします．

```bash
sh install.sh
```

何も指定しなければ，ホームディレクトリにすべての`dotfiles`をインストールします．（これは潜在的に危険です！あなたの`dotfiles`を上書きしてしまう可能性があります．もしこのスクリプトを使うのであれば，注意して取り扱ってください．）

また，このスクリプトでは，`-c`オプションのあとにインストールする`dotfiles`の種類を指定することで，依存するファイルも含めてインストールする機能があります．今の所，
* vim
* neovim
* zsh
* tmux
* xresources
* xmonad
* fontconfig

に対応しています．

詳しくは，以下のようにしてヘルプをご覧ください．

```bash
sh install.sh --help
```

## Settings For
以下にこのdotfilesで設定しているソフトウェアを示します．
* GVim(`.vim`, `.vimrc`, `.gvimrc`)
* dein.vim(`.vim/plugins`)
* XMonad(`.xmonad`)
* maim(`.xmonad`)
* xdotool(`.xmonad`, maim)
* Xmobar(`.xmobarrc`)
* urxvt(`.Xresources`)
* xterm(`.Xresources`)
* tmux(`.tmux.conf`)
* zsh(`.zshrc`)
* Powerline(`.config/powerline/`)
* trayer(`.xprofile`) <- icon tray
* Feh(`.xprofile`) <- for wallpaper
* iBus(`.xprofile`)

## Environment
僕はこのdotfilesを以下の構成で使っています．`.xinitrc`や`.xprofile`，更には`.vimrc`などはこの環境に強く依存しているので，
他の環境で使う場合には修正が必要な可能性があります．
* Virtual Box
* Arch Linux
* LightDM
* XMonad
* Vim + Dein.vim

## Dependencies
NeovimでLanguageServerを使うための設定をしているので，そのための依存関係を一応記しておきます．（完全に自分のため）
* `typescript-language-server`
* `javascript-typescript-lanserver`
* `rls`（for rust）
* `Haskell-ide-Engine`
* `php-language-server`
* `clangd`

基本的にはAURに存在するか，`npm`でインストールすれば使えますが，`rls`などは少しだけ特殊です．詳しくは書くソフトウェアのGitHubをみて設定します．
