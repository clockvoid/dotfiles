import System.IO
import XMonad
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
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
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
      title =? "Welcome to Android Studio" --> doFloat,
      title =? "Welcome to IntelliJ IDEA" --> doFloat,
      title =? "win0" --> doFloat,
      title =? "splash" --> doFloat
    ]

manageWindowWorkspacePosition :: ManageHook
manageWindowWorkspacePosition =
  composeAll
    []

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
    ("M-S-l", spawn "XSECURELOCK_SAVER=saver_blank XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_PAM_SERVICE='lightdm' xsecurelock"),
    ("M-m", spawn (configPath ++ "set_monitor.sh")),
    ("<XF86MonBrightnessDown>", spawn "light -Us 'sysfs/backlight/intel_backlight' 5"),
    ("<XF86MonBrightnessUp>", spawn "light -As 'sysfs/backlight/intel_backlight' 5"),
    ("<XF86AudioRaiseVolume>", spawn (configPath ++ "volume_up.sh")),
    ("<XF86AudioLowerVolume>", spawn (configPath ++ "volume_down.sh")),
    ("<XF86AudioMute>", spawn (configPath ++ "toggle_mute.sh")),
    ("<XF86AudioMicMute>", spawn (configPath ++ "toggle_mic_mute.sh"))
  ]

disabledKeys :: [[Char]]
disabledKeys =
  [ "C-,"
  ]

startup :: X ()
startup = do
  setWMName "LG3D"
  spawn (configPath ++ "set_wallpaper.sh")
  spawn "pkill -x -USR1 picom"
  spawn "nm-applet"
  spawn "blueman-applet"
  spawn "start-pulseaudio-x11"
  spawn "fcitx5"

main :: IO ()
main = do
  let baseConfig = desktopConfig
  screens <- countScreens
  statusBars <-
    mapM
      ( \i ->
          spawnPipe $
            "~/.local/bin/xmobar -x "
              ++ show i
              ++ " "
              ++ configPath
              ++ if i == 0 then "xmobar.config" else "xmobar_notrayer.config"
      )
      [0 :: Int .. screens - 1]
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
            <+> manageWindowWorkspacePosition
            <+> manageHook baseConfig,
        layoutHook =
          avoidStruts $
            toggleLayouts (noBorders Full) $
              smartBorders $
                layoutHook baseConfig,
        logHook = do
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
            <+> updatePointer (0.5, 0.5) (0, 0),
        startupHook = startup
      }
      `additionalKeysP` keyMaps
      `removeKeysP` disabledKeys
