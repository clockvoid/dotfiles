## 新しく作ったLet's Noteでの構成

- ファイルエクスプローラ
  - Thunar
- ターミナルエミュレータ
  - Alacritty
- ブラウザ
  - Chromium
- 画面輝度
  - xbacklight
- マルチスクリーン
  - arandr
    - xrandrというxorgのプロジェクトのGUIクライアント

## Let's note特有の問題
- スピーカーから音が出ない
  - ALSAの設定とPulseAudioの設定が必要
  - ALSAでは，RealTekのサウンドカードをデフォルトに設定する必要がある
    - asoundconfというアプリケーションを使って設定を変更する
    - https://x.momo86.net/?p=23
  - PulseAudioでは，アナログスピーカーの音量調整の方法の設定を変更する
    - https://gtrt7.com/blog/linux/ubuntu1710-on-letsnote#i-4
