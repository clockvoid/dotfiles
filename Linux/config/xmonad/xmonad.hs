import Data.Map.Internal (fromList, union)
import System.IO
import XMonad
import XMonad.Actions.Search
import XMonad.Actions.UpdatePointer
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Maximize ()
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Grid
import XMonad.Prompt
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Types ()

manageWindowSizeForDev :: ManageHook
manageWindowSizeForDev =
  composeAll
    [ appName =? "com.clockvoid" --> doCenterFloat,
      title =? "Nice Window" --> doCenterFloat,
      title =? "Cell Automaton" --> doCenterFloat
    ]

manageWindowSize :: ManageHook
manageWindowSize =
  composeAll
    [ isFullscreen --> doFullFloat,
      isDialog --> doCenterFloat,
      className =? "Evolution-alarm-notify" --> doCenterFloat,
      title =? "Picture in picture" --> doFloat,
      title =? "Picture-in-Picture" --> doFloat,
      (className =? "jetbrains-studio" <&&> title =? "Device Manager") --> doFloat,
      (className =? "jetbrains-studio" <&&> title =? "Welcome to Android Studio") --> doFloat,
      (className =? "jetbrains-idea-ce" <&&> title =? "Welcome to IntelliJ IDEA") --> doFloat,
      (className =? "jatbrains-studio" <||> className =? "jetbrains-idea-ce") <&&> title =? "splash" --> doFloat
    ]

configPath :: [Char]
configPath = "~/.config/xmonad/"

keyMaps :: [([Char], X ())]
keyMaps =
  [ ("M-p", spawn "dmenu_run -fn 'monospace-11'"),
    ("M-S-p", spawn "passmenu -fn 'monospace-11'"),
    ("<Print>", spawn (configPath ++ "screenshot.sh")),
    ("C-<Print>", spawn (configPath ++ "screenshot.sh selectedarea")),
    ("M-<Print>", spawn (configPath ++ "screenshot.sh focusedwindow")),
    ("S-<Print>", spawn (configPath ++ "screenshot.sh clipboard")),
    ("C-S-<Print>", spawn (configPath ++ "screenshot.sh selectedareaclipboard")),
    ("M-S-<Print>", spawn (configPath ++ "screenshot.sh focusedwindowclipboard")),
    ("M-s", spawn "systemctl suspend"),
    ("M-m", spawn (configPath ++ "set_monitor.sh")),
    ("<XF86Display>", spawn (configPath ++ "set_monitor.sh")),
    ("<XF86MonBrightnessDown>", spawn "light -Us 'sysfs/backlight/intel_backlight' 5"),
    ("<XF86MonBrightnessUp>", spawn "light -As 'sysfs/backlight/intel_backlight' 5"),
    ("<XF86AudioRaiseVolume>", spawn (configPath ++ "volume_up.sh")),
    ("<XF86AudioLowerVolume>", spawn (configPath ++ "volume_down.sh")),
    ("<XF86AudioMute>", spawn (configPath ++ "toggle_mute.sh")),
    ("<XF86AudioMicMute>", spawn (configPath ++ "toggle_mic_mute.sh")),
    ("M-z", sendMessage $ JumpToLayout "Tall"),
    ("M-x", sendMessage $ JumpToLayout "Grid"),
    ("M-c", sendMessage $ JumpToLayout "Mirror Tall"),
    ("M-v", sendMessage $ JumpToLayout "Full")
  ]
    ++ [("M-f M-" ++ k, promptSearchBrowser searchConfig "firefox" f) | (k, f) <- searchList]

searchConfig :: XPConfig
searchConfig =
  def
    { promptBorderWidth = 0,
      promptKeymap =
        fromList
          [ (,) (controlMask, xK_h) (deleteString Prev),
            (,) (controlMask, xK_c) quit
          ]
          `union` emacsLikeXPKeymap
    }

appleDeveloper :: SearchEngine
appleDeveloper = searchEngine "apple" "https://developer.apple.com/search/?q="

androidDeveloper :: SearchEngine
androidDeveloper = searchEngine "android" "https://developer.android.com/s/results?q="

kotlinDocs :: SearchEngine
kotlinDocs = searchEngine "kotlin" "https://kotlinlang.org/docs/home.html?s=full&q="

searchList :: [(String, SearchEngine)]
searchList =
  [ ("a", androidDeveloper),
    ("g", google),
    ("y", youtube),
    ("h", hoogle),
    ("s", stackage),
    ("w", wikipedia),
    ("p", arXiv),
    ("k", kotlinDocs),
    ("r", appleDeveloper)
  ]

startup :: X ()
startup = do
  setWMName "LG3D"
  spawn "pkill -x -USR1 picom"
  spawn (configPath ++ "set_wallpaper.sh")
  spawnOnce "hook_window_focus.sh"
  spawnOnce "nm-applet"
  spawnOnce "blueman-applet"
  spawnOnce "start-pulseaudio-x11"
  spawnOnce "fcitx5"
  spawnOnce "picom"
  spawnOnce "lxqt-policykit-agent"
  spawnOnce "xremap ~/.config/xremap/config.yml --watch"
  spawnOnce "volctl"
  spawnOnce
    "trayer --edge top --align right \
    \--widthtype percent --heighttype pixel \
    \--SetDockType true --SetPartialStrut false \
    \--expand false \
    \--width 8 --height 23 \
    \--transparent true --alpha 0 --tint 0x000000 \
    \--monitor primary"

launchXmobarOn :: (MonadIO m) => Int -> m Handle
launchXmobarOn monitor =
  spawnPipe $
    "~/.local/bin/xmobar -x "
      ++ show monitor
      ++ " "
      ++ configPath
      ++ if monitor == 0 then "xmobar.config" else "xmobar_notrayer.config"

xmobarHook :: (Foldable t) => t Handle -> X ()
xmobarHook statusBars = do
  mapM_
    ( \xmproc ->
        dynamicLogWithPP
          xmobarPP
            { ppOutput = hPutStrLn xmproc,
              ppTitle = xmobarColor "orange" "" . shorten 100,
              ppLayout = \s -> "<" ++ s ++ ">",
              ppSep = " | "
            }
    )
    statusBars
    <+> updatePointer (0.5, 0.5) (0, 0)

main :: IO ()
main = do
  let baseConfig = desktopConfig
  nScreens <- countScreens
  statusBars <- mapM launchXmobarOn [0 .. nScreens - 1]
  xmonad . docks . ewmhFullscreen . ewmh $
    def
      { terminal = "alacritty -e zsh -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux\"",
        borderWidth = 2,
        focusedBorderColor = "#ff5733",
        normalBorderColor = "#1D1F21",
        modMask = mod4Mask,
        manageHook =
          manageDocks
            <+> manageWindowSizeForDev
            <+> manageWindowSize
            <+> manageHook baseConfig,
        layoutHook = avoidStruts . toggleLayouts (noBorders Full) . smartBorders $ Tall 1 (3/100) (1/2) ||| Grid ||| Mirror (Tall 1 (3/100) (13/20)) ||| Full,
        logHook = xmobarHook statusBars,
        startupHook = startup
      }
      `additionalKeysP` keyMaps
      `removeKeysP` []
