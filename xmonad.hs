{-# LANGUAGE ScopedTypeVariables #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe, unsafeSpawn)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO
import XMonad.Layout.IndependentScreens
import XMonad.Actions.WindowGo (runOrRaise)

myStartupHook :: X ()
myStartupHook = do
  unsafeSpawn myTerminal -- This will become ranger after .zshrc runs
  unsafeSpawn myTerminal
  runOrRaise "emacs" (className =? "Emacs")
  runOrRaise "google-chrome-stable" (className =? "Google-chrome")
  unsafeSpawn "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

myModMask            = mod4Mask                        -- Sets modkey to super/windows key
myTerminal           = "tabbed -r 2 st -w '' -e tmux"  -- Sets default terminal
myTextEditor         = "emacs"                         -- Sets default text editor
myBorderWidth        = 2                               -- Sets border width for windows
myNormalBorderColor  = "#4a4a4a"
myFocusedBorderColor = "#7fff00"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
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
        [ ("<Print>", spawn "scrot")
--        , ("C-<Print>", spawn "sleep 0.1; scrot -s") --Esto no funciona. Tampoco sé para qué es.
--        , ("M-j", spawn "xdotool key Down")
--        , ("M-k", spawn "xdotool key Up")
--        , ("M-l", spawn "xdotool key Right")
--        , ("M-h", spawn "xdotool key Left")
        ]
--        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
