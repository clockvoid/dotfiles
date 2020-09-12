# dotfiles for Windows
WindowsではAutoHotKeyを用いてキーバインドをMacに近しいものに変える必要がある．
これを行うためのファイルがmac.ahkとなる．
AutoHotKeyをChocolateyでインストールし，mac.ahkをコンパイルし，startupにショートカットを置くとよい．

# bashrc
WindowsではSymbolic linkに直接アクセスできなさそうなので，コピーしなくてはならない

# settings.json
Windows Terminal用の設定．
`C:/Users/<user>/AppData/Local/Packages/Microsoft.WindowsTerminal_<randomString>/LocalState`
にコピーして使用する．
