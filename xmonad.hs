import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = mod4Mask     -- Rebind Mod to the Windows key
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "darkgreen" "" . shorten 20
                        }
        , normalBorderColor  = "#4a4a4a"
        , focusedBorderColor = "#7fff00"
        , terminal = "gnome-terminal"
        } `additionalKeysP`
        [ ("<Print>", spawn "scrot")
--        , ("C-<Print>", spawn "sleep 0.1; scrot -s") --Esto no funciona. Tampoco sé para qué es.
--        , ("M-j", spawn "xdotool key Down")
--        , ("M-k", spawn "xdotool key Up")
--        , ("M-l", spawn "xdotool key Right")
--        , ("M-h", spawn "xdotool key Left")
        ]
--        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")

