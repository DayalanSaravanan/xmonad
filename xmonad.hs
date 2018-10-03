import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/ndayalan/.xmobarrc"

    xmonad $ defaultConfig
        {handleEventHook = handleEventHook defaultConfig <+> docksEventHook
	, manageHook = manageDocks <+> manageHook defaultConfig 
        , layoutHook = avoidStruts $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#dcdcdc" "" . shorten 20
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, focusedBorderColor = "#050606"
	, normalBorderColor = "#050606"
	, startupHook = myStartupHook
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

myStartupHook = do
		spawn "feh --bg-scale /home/ndayalan/Pictures/121317.png"
