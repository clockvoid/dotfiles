# Mac用の設定ファイル

## 初期設定
Git Repositoryのルートディレクトリにある`install.sh`を

```shell
bash install.sh -c mac-utils
```

として実行すると，brewと普段使用しているアプリケーションがすべてインストールされます．

## iterm2の設定
`Darwin/iterm2`ディレクトリにiterm2で使用することができるHybridというカラーテーマが入っています．
このカラーテーマを`Preferences | Profiles | Default | Colors | Color Presets | Import`からインポートして使用します．

以下にそれ以外に普段使用しているデフォルト値と違う設定を記載します

| 設定 | 値 |
| --- | --- |
| `Preferences | Profiles | Default | Terminal | Scrollback lines` | `0` |
| `Preferences | Keys | Hotkey | Hotkey` | `^i` |
| `Preferences | Kyes | Key Bindings` | `⌘k`をignore |
