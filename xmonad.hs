import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , normalBorderColor  = "#4a4a4a"
        , focusedBorderColor = "#7fff00"
        } `additionalKeysP`
        [ ("C-<Print>", spawn "sleep 0.1; scrot -s") --Esto no funciona. Tampoco sé para qué es.
        , ("<Print>", spawn "scrot")
--        , ("M-j", spawn "xdotool key Down")
--        , ("M-k", spawn "xdotool key Up")
--        , ("M-l", spawn "xdotool key Right")
--        , ("M-h", spawn "xdotool key Left")
        ]
--        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")

