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
    , className =? "Eom" --> doCenterFloat
    , className =? "Vidalia" --> doCenterFloat
    , className =? "Mikutter.rb" <&&> title =? "Preferences" --> doCenterFloat
    , appName =? "crx_nckgahadagoaajjgafhacjanaoiihapd" --> doCenterFloat
    , isFullscreen --> doFloat
    , isDialog --> doCenterFloat
    ]

-- settings for new shortcut keys
myKeys = [ ("M-p", spawn "dmenu_run -fn 'Monospace:pixelsize=15'")
         , ("<Print>", spawn "screenshot.sh")
         , ("M-<Print>", spawn "screenshot_focused_window.sh")
         , ("C-<Print>", spawn "screenshot_select.sh")
         , ("M-e", spawn "caja")
         , ("M-m", spawn "mikutter")
         ] 

-- settings for default terminal emulator
myTerminal = "urxvt"

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
    xmproc <- spawnPipe "/usr/bin/xmobar"
    xmonad $ fullscreenSupport $ baseConfig
        { terminal  = myTerminal
        , borderWidth = myBorderWidth
        , focusedBorderColor = myForcusedBorderColor
        , normalBorderColor = myNomalBorderColor
        , manageHook = manageDocks <+> myManageShift <+> myManageHook <+> manageHook baseConfig
        , layoutHook = avoidStruts $ layoutHook baseConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }

        }

        `additionalKeysP` myKeys
        
