import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Types
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen
import System.IO

baseConfig = desktopConfig

-- settings of defalut workspace for some applications
myManageShift = composeAll
  [ className =? "Mikutter.rb" --> doShift "9"
  ]

-- settings of Window management
myManageHook = composeAll
  [ className =? "Gimp" --> doFloat
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
  , isFullscreen --> doFloat
  , isDialog --> doCenterFloat
  , title =? "Nice Window" --> doCenterFloat
  , title =? "Cell Automaton" --> doCenterFloat
  , className =? "feh" --> doCenterFloat
  , appName =? "Emoji Choice" --> doCenterFloat
  ]

screenshotPath :: String
screenshotPath = " /media/sf_D_DRIVE/screenshot"

-- settings for new shortcut keys
myKeys = [ ("M-p", spawn "dmenu_run -fn 'monospace-11'")
         , ("<Print>", spawn ("~/.xmonad/screenshot.sh" ++ screenshotPath))
         , ("M-<Print>", spawn ("~/.xmonad/screenshot_focused_window.sh" ++ screenshotPath))
         , ("C-<Print>", spawn ("~/.xmonad/screenshot_select.sh" ++ screenshotPath))
         , ("M-e", spawn "pcmanfm")
         , ("M-m", spawn "mikutter")
         , ("M-n", spawn "nvim-wrapper")
         , ("M-g", spawn "gvim")
         , ("C-S-<Esc>", spawn "gnome-system-monitor")
         , ("M-x", spawn "terminator -e zsh")
         ] 

-- settings for default terminal emulator
-- myTerminal = "xterm -e zsh -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME\""
myTerminal = "terminator -x zsh -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME\""

-- settings for mod key
myModMask = mod4Mask

-- settings for border
myBorderWidth = 1
myForcusedBorderColor = "#808080"
myNomalBorderColor = "#1C1C1C"

-- main function
main = do
  {-
   - xmproc: constant that is xmobar spawnPipe
   - xmonad function is a Monad takes Default as an argument.
   - Ofcorse, fullscreenSupport is Default that takes Default and is enable fullscreen application like Google Chrome work well.
   - baseConfig is XConfig and it defines as desktopConfig.
   - desktopConfig is XConfig that configures xmonad to ignore and leave room for dock type windows like panels and trays, adds the default key binding to toggle panel visibility, and activates basic EWMH supprt.
   - XConfig is constructor of data XConfig l.
   - XConfig has some field value. there are details in http://xmonad.org/xmonad-docs/xmonad/XMonad-Core.html#t:XConfig.
   - additionalKeysP :: XConfig l -> [(String, X ())] -> XConfig l
   - additionalKeysP takes XConfig and touple list and output edited XConfig.
   - additionalKeysP can add some key bindings.
   -}
  xmproc <- spawnPipe "~/.local/bin/xmobar"
  xmonad $ baseConfig
    { terminal  = myTerminal
    , borderWidth = myBorderWidth
    , focusedBorderColor = myForcusedBorderColor
    , normalBorderColor = myNomalBorderColor
    , manageHook = manageDocks <+> myManageShift <+> myManageHook <+> manageHook baseConfig
    , layoutHook = avoidStruts $ layoutHook baseConfig
    --, modMask = myModMask
    , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "green" "" . shorten 50 . \s -> "Main: " ++ s
                    , ppLayout = \s -> "<" ++ s ++ ">"
                    , ppSep = " | "
                    }
    }
    
    `additionalKeysP` myKeys
