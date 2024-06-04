@ECHO OFF

xcopy .\Windows\settings.json %UserProfile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

xcopy .\Common\ideavimrc %UserProfile%\.ideavimrc

rmdir /S %UserProfile%\AppData\Local\nvim
if not exist "%UserProfile%\AppData\Local\nvim" (
  mkdir %UserProfile%\AppData\Local\nvim
  xcopy /e .\Common\config\nvim %UserProfile%\AppData\Local\nvim
  mkdir %UserProfile%\AppData\Local\nvim\lua\env
  xcopy /e .\Windows\AppData\Local\nvim\lua\env %UserProfile%\AppData\Local\nvim\lua\env
)

rmdir /S %APPDATA%\alacritty
if not exist "%APPDATA%\alacritty" (
  mkdir %APPDATA%\alacritty
  xcopy /e .\Common\config\alacritty %APPDATA%\alacritty
  xcopy .\Windows\AppData\Roaming\alacritty\env.toml %APPDATA%\alacritty
)
