{-# LANGUAGE ScopedTypeVariables #-}

import           System.IO
import           XMonad
import           XMonad.Actions.WindowGo          (runOrRaise)
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.MouseResizableTile
import           XMonad.Layout.Spacing
import           XMonad.Util.Brightness
import           XMonad.Util.EZConfig             (additionalKeysP)
import           XMonad.Util.Run                  (spawnPipe, unsafeSpawn)
-- import XMonad.Wallpaper --For some reason, doesnt find it

myStartupHook :: X ()
myStartupHook = do
  unsafeSpawn "feh --bg-scale ~/Pictures/wallpaper.png &"
  unsafeSpawn myTerminal -- I have to manualy remove this terminal because Dropbox starts there and won't stop printing msgs
  runOrRaise "emacs" (className =? "Emacs")
  runOrRaise "spotify" (className =? "Spotify")
  runOrRaise "nautilus" (className =? "Nautilus")
  runOrRaise "firefox" (className =? "Firefox")
  unsafeSpawn "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

myModMask            = mod4Mask                        -- Sets modkey to super/windows key
myTerminal           = "gnome-terminal"
-- myTerminal           = "tabbed -r 2 st -w '' -e tmux"  -- Sets default terminal
-- myTerminal           = "st -e tmux"  -- Sets default terminal
-- myTerminal           = "urxvt"  -- Sets default terminal
-- myTerminal           = "tabbed urxvt -embed"  -- Sets default terminal
myTextEditor         = "emacs"                         -- Sets default text editor
myBorderWidth        = 2                               -- Sets border width for windows
myNormalBorderColor  = "#4a4a4a"
myFocusedBorderColor = "#7fff00"

mySpacing = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts . mySpacing $ layoutHook defaultConfig
          --smartSpacing 20 $ Tall 1 (3/100) (1/2)
          --avoidStruts $ layoutHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "darkgreen" "" . shorten 20
                        }
        , startupHook        = myStartupHook
        , modMask            = myModMask     -- Rebind Mod to the Windows key
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , terminal           = myTerminal
        } `additionalKeysP`
        [ ("<Print>", spawn "scrot -e \'mv $f ~/Pictures/Screenshots\'")
        , ("M-u", decrease) -- decrease brightness
        , ("M-i", increase) -- increase brightness
        , ("M-y", setBrightness 100) -- set to minimum brightness
        , ("M-j", spawn "amixer -q sset Master 2%-")
        , ("M-k", spawn "amixer -q sset Master 2%+")
        , ("M-m", spawn "amixer set Master toggle")
        -- , ("C-<Print>", spawn "scrot -u -e \'mv $f ~/Pictures/Screenshots\'")
        -- , ("M-j", spawn "xdotool key Down") --Don't work and dont know why :(
        -- , ("M-k", spawn "xdotool key Up")
        -- , ("M-l", spawn "xdotool key Right")
        -- , ("M-h", spawn "xdotool key Left")
        ]
--        , ((mod4mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
