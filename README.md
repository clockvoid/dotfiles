# dotfiles
my using dotfiles including vimrc and xmonad.hs

## Description
This is dotfiles I am using. I manage `.vimrc`, `xmonad.hs`, and so on.

## Installation
I make `install.sh`!

To use this script, you can type:

```bash
sh install.sh
```

If you run this script with no options, it will install all of these `dotfiles` to home directory. (This is potentially dangerous becauses your own `dotfiles` will be overwritten with these `dotfiles`. When use this script, you have to be careful!)

Additionaly, this script supprts `-c` option to specify installing `dotfiles`.
Now, it supports these applicatons:
* vim
* neovim
* zsh
* tmux
* xresources
* xmonad
* fontconfig

For more ditailes, you can see help as follows:

```bash
sh install.sh --help
```

## Settings For
This script supports these applicatos:
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
* trayer(`.xprofile`) ← icon tray
* Feh(`.xprofile`) ← for wallpaper
* iBus(`.xprofile`)

## Environment
I use these `dotfiles` in the environment as follows.
If you use these `dotfiles` in different environment, you have to change detailes.
* Virtual Box
* Arch Linux
* LightDM
* XMonad
* Vim + Dein.vim

## Dependencies
These `dotfiles` contain LanguageServer settings in Neovim. There are some dependencies for these settings.
* `javascript-typescript-lanserver`
* `rls`（for rust）
* `Haskell-ide-Engine`
* `php-language-server`
* `clangd` (see https://kurokoji.hatenablog.com/entry/2018/08/16/220524 )
* `pyls`
* `kotlin-language-server` (https://github.com/fwcd/kotlin-language-server/)

You can get almost all of these applicatons in AUR, but some one is not.
Finally, you have to see GitHub README on each softwares.
