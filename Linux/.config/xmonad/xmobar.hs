import Xmobar

config :: Config
config = defaultConfig
  { font = "xft:Terminus:size=10:style=Bold:antialias=true, xft:Source Han Sans Mono JP:size=10:style=Bold:antialias=true"
  , bgColor = "black"
  , fgColor = "grey"
  }

main :: IO ()
main = configFromArgs config >>= xmobar
