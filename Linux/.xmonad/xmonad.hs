import           System.IO
import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Layout.IndependentScreens
import           XMonad.Actions.CycleWS
import           XMonad.Actions.UpdatePointer
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Maximize()
import           XMonad.Layout.NoBorders
import           XMonad.Layout.ToggleLayouts
import           XMonad.Util.EZConfig
import           XMonad.Util.Run(spawnPipe)
import           XMonad.Util.Types()

myManageShift = composeAll
  [ className =? "Mikutter.rb" --> doShift "9"
  ]

-- settings of Window management
myManageHook = composeAll
  [ isFullscreen --> doFullFloat
  , isDialog --> doCenterFloat
  , className =? "Gimp" --> doFloat
  , className =? "Vncviewer" --> doFloat
  , className =? "Caja" --> doCenterFloat
  , className =? "Pcmanfm" --> doCenterFloat
  , className =? "Engrampa" --> doCenterFloat
  , className =? "Eom" --> doCenterFloat
  , className =? "Vidalia" --> doCenterFloat
  , className =? "Mikutter.rb" <&&> title =? "Preferences" --> doCenterFloat
  , appName =? "crx_nckgahadagoaajjgafhacjanaoiihapd" --> doCenterFloat
  , appName =? "OpenGL Sample" --> doCenterFloat
  , className =? "Gnome-system-monitor" --> doCenterFloat
  , className =? "Evolution-alarm-notify" --> doCenterFloat
  , title =? "Nice Window" --> doCenterFloat
  , title =? "Cell Automaton" --> doCenterFloat
  , title =? "Picture in picture" --> doFloat
  , appName =? "Emoji Choice" --> doCenterFloat
  , title =? "Android Emulator - Pixel_5_API_30:5554" --> doFloat
  , title =? "Emulator" --> doFloat
  ]

screenshotPath :: String
screenshotPath = " ~/Pictures/screenshot"

-- settings for new shortcut keys
myKeys :: [([Char], X ())]
myKeys = [ ("M-p", spawn "dmenu_run -fn 'monospace-11'")
         , ("M-S-p", spawn "passmenu -fn 'monospace-11'")
         , ("<Print>", spawn ("~/.xmonad/screenshot.sh" ++ screenshotPath))
         , ("M1-<Print>", spawn ("~/.xmonad/screenshot_focused_window.sh" ++ screenshotPath))
         , ("C-<Print>", spawn ("~/.xmonad/screenshot_select.sh" ++ screenshotPath))
         , ("M-C-k", nextScreen)
         , ("M-C-j", prevScreen)
         , ("M-m", spawn "mikutter")
         , ("M-n", spawn "nvim-wrapper")
         , ("M-g", spawn "gvim")
         , ("M-s", spawn "systemctl suspend")
         , ("C-S-<Esc>", spawn "gnome-system-monitor")
         , ("M-<Space>", sendMessage ToggleLayout)
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -5")
         , ("<XF86MonBrightnessUp>", spawn "xbacklight +5")
         , ("<XF86AudioRaiseVolume>", spawn "~/.xmonad/volume_up.sh")
         , ("<XF86AudioLowerVolume>", spawn "~/.xmonad/volume_down.sh")
         , ("<XF86AudioMute>", spawn "~/.xmonad/toggle_mute.sh")
         , ("M-i", spawn "sleep 0.1 && xdotool key Muhenkan")
         , ("M-o", spawn "sleep 0.1 && xdotool key Henkan")
         ]

-- settings for key disablation
disabledKeys :: [[Char]]
disabledKeys = [ "C-,"
               ]

myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  spawn "~/.xmonad/set_wallpaper.sh"
  spawn "~/.xmonad/set_monitor.sh"
  spawn "~/.xmonad/set_keyboard.sh"

-- main function
main :: IO ()
main = do
  let baseConfig = desktopConfig
  n <- countScreens
  hs <- mapM (\i ->
    spawnPipe $
      "~/.local/bin/xmobar -x "
      ++ show i
      ++ if i == 0
            then " ~/.xmonad/xmobarrc"
            else " ~/.xmonad/xmobarrc_notrayer"
    ) [0 :: Int .. n - 1]
  xmonad $ docks $ (ewmhFullscreen . ewmh) $ def
    { terminal = "alacritty -e zsh -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux\""
    , borderWidth = 3 
    , focusedBorderColor = "#ff5733"
    , normalBorderColor = "#1D1F21"
    , modMask = mod4Mask
    , manageHook = manageDocks <+>
        myManageShift <+>
        myManageHook <+>
        manageHook baseConfig
    , layoutHook = avoidStruts $
        toggleLayouts (noBorders Full) $
        smartBorders $
        layoutHook baseConfig
    , logHook = mapM_ (\xmproc ->
        dynamicLogWithPP xmobarPP
          { ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor "green" "" . shorten 50
          , ppLayout = \s -> "<" ++ s ++ ">"
          , ppSep = " | "
          }
        ) hs <+>
        updatePointer (0.5, 0.5) (0, 0)
    , startupHook = myStartupHook
    }
    `additionalKeysP` myKeys
    `removeKeysP` disabledKeys

