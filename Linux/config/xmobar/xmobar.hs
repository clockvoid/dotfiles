import System.Directory (doesPathExist)
import Xmobar

myCommands :: [Runnable]
myCommands =
  [ Run StdinReader,
    Run $
      Cpu
        [ "-t",
          "<fn=1>\xf2db</fn> <total>%",
          "-L",
          "20",
          "-H",
          "70",
          "--normal",
          "green",
          "--high",
          "red"
        ]
        30,
    Run $
      Memory
        [ "-t",
          "<fn=1>\xf538</fn> <usedratio>%"
        ]
        30,
    Run $
      Battery
        [ "-t",
          "<acstatus>",
          "-L",
          "20",
          "-H",
          "70",
          "-h",
          "green",
          "-n",
          "green",
          "-l",
          "red",
          "--",
          "-o",
          "<left>%(<timeleft>)",
          "-O",
          "<fn=1>\xf0e7</fn><fn=1>\xf240</fn> <left>%",
          "-i",
          "<fn=1>\xf1e6</fn>",
          "--lowt",
          "20",
          "--hight",
          "70",
          "--lows",
          "<fn=1>\xf243</fn> ",
          "--mediums",
          "<fn=1>\xf242</fn> ",
          "--highs",
          "<fn=1>\xf240</fn> "
        ]
        60,
    Run $ Date "<fn=1>\xf073</fn> %F  <fn=1>\xf017</fn> %I:%M" "date" 60,
    Run $
      DiskU
        [("/", "<fn=1>\xf0a0</fn> <used>/<size>")]
        [ "-L",
          "70",
          "-H",
          "90",
          "-n",
          "yellow",
          "-h",
          "red"
        ]
        30,
    Run $
      Volume
        "default"
        "Master"
        [ "-t",
          "<status> <volume>%",
          "--suffix",
          "False",
          "--",
          "--onc",
          "gray",
          "--on",
          "",
          "--off",
          "<fn=1>\xf6a9</fn>",
          "--highv",
          "60",
          "--lowv",
          "1",
          "--highs",
          "<fn=1>\xf028</fn>",
          "--mediums",
          "<fn=1>\xf027</fn>",
          "--lows",
          "<fn=1>\xf026</fn>"
        ]
        30,
    Run $ Com "cat" ["/sys/firmware/acpi/platform_profile"] "profile" 30,
    Run $ Com "/home/clock/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 30
  ]

baseConfig :: Config
baseConfig =
  defaultConfig
    { font = "Terminus bold 10",
      additionalFonts = ["Font Awesome 7 Free solid 10"],
      bgColor = "black",
      fgColor = "grey",
      position = TopH 22,
      allDesktops = True,
      persistent = False,
      commands = myCommands
    }

isPrimaryScreen :: XPosition -> Bool
isPrimaryScreen xPosition = case xPosition of
  OnScreen screen _ -> screen == 0
  _ -> False

myConfig :: IO Config
myConfig = do
  config <- configFromArgs baseConfig
  let p = position config
  canGetPowerProfile <- doesPathExist "/sys/firmware/acpi/platform_profile"
  return
    config
      { template =
          concat $
            ["%StdinReader% }{ %cpu%  %memory%  %battery%"]
              <> ["-%profile%" | canGetPowerProfile]
              <> ["  <action=`pavucontrol` button=1>%default:Master%</action>  %disku%  %date%"]
              <> [" %trayerpad%" | isPrimaryScreen p]
      }

main :: IO ()
main = xmobar =<< myConfig
