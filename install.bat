@ECHO OFF

xcopy .\Windows\settings.json %UserProfile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

xcopy .\Common\ideavimrc %UserProfile%\.ideavimrc

rmdir /S %UserProfile%\AppData\Local\nvim
xcopy /e /v .\Common\config\nvim %UserProfile%\AppData\Local\nvim
xcopy /e /v .\Windows\AppData\Local\nvim\lua\env %UserProfile%\AppData\Local\nvim\lua\env
