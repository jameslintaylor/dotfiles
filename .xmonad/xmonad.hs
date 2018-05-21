import System.IO
import System.Exit
import Data.Ratio ((%))

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Place

import XMonad.Actions.FloatKeys

import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import qualified XMonad.StackSet as W
import qualified Data.Map as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

    -- close focused window
    , ((modm .|. mod1Mask, xK_0), kill)

    -- Rotate through the available layout algorithms
    , ((modm .|. mod1Mask, xK_space), sendMessage NextLayout)

    -- Rotate BSP
    , ((modm, xK_r), sendMessage Rotate) 

    -- Resizing Nodes in BSP
    , ((modm, xK_Left), sendMessage (ExpandTowards L))
    , ((modm, xK_Up), sendMessage (ExpandTowards U))
    , ((modm, xK_Right), sendMessage (ExpandTowards R))
    , ((modm, xK_Down), sendMessage (ExpandTowards D))
    
    -- Swap children in BSP
    , ((modm, xK_space), sendMessage Swap)
    
    -- Select Parent in BSP
    , ((modm, xK_a), sendMessage FocusParent)

    --  Reset the layouts on the current workspace to default
    , ((modm, xK_equal), setLayout $ XMonad.layoutHook conf)

    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)

    -- Move focus to the next window
    , ((modm, xK_j), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_k), windows W.focusUp)

    -- Swap the focused window and the master window
    , ((modm .|. mod1Mask, xK_m), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm, xK_t), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. mod1Mask, xK_t), windows W.swapUp)

    -- Shrink the master area
    , ((modm, xK_h), sendMessage Shrink)

    -- Expand the master area
    , ((modm, xK_l), sendMessage Expand)

    -- Increment the number of windows in the master area
    , ((modm,xK_period), sendMessage (IncMasterN 1))

    -- Decrement the number of windows in the master area
    , ((modm, xK_comma), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm .|. mod1Mask, xK_b), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. mod1Mask, xK_r), spawn "xmonad --recompile; xmonad --restart")
    ]

    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++

    -- floating windows
    [ ((modm .|. mod1Mask, xK_minus), withFocused (keysResizeWindow (-10, -10) (1%2, 1%2)))
    -- Center window
    , ((modm .|. mod1Mask, xK_c), withFocused (keysMoveWindowTo (1440, 900) (1%2, 1%2)))
    -- Push window back into tiling
    , ((modm .|. mod1Mask, xK_s), withFocused $ windows . W.sink)
    ]

    ++

    -- rofi
    [ ((modm, xK_x), spawn "rofi -combi-modi window,run,ssh -show combi")
    , ((modm, xK_w), spawn "rofi -show window")
    , ((modm, xK_s), spawn "rofi -show ssh")
    , ((modm, xK_p), spawn "rofi-pass")
    ]

myManageHook :: ManageHook
myManageHook = composeAll $
    [ title =? "pinentry-gtk-2" --> doFloat
    , title =? "Helm" --> (placeHook $ fixed (0.5, 0.5)) <+> doFloat
    ]

myLayoutHook = avoidStruts $ smartBorders $ (bsp ||| full)
  where	bsp = renamed [Replace "bsp"] $ smartSpacingWithEdge 4 emptyBSP 
    	full = renamed [Replace "full"] Full

myHandleEventHook = docksEventHook <+> ewmhDesktopsEventHook

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad . docks . ewmh $ def
    { terminal = "urxvt -e tmux"
    , modMask = mod4Mask
    , focusFollowsMouse = False
    , borderWidth = 5
    , normalBorderColor = "#26a"
    , focusedBorderColor = "#f40"

    -- key bindings
    , keys = myKeys

    -- hooks, layout
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , handleEventHook = myHandleEventHook

    -- xmobar stuff
    , logHook = dynamicLogWithPP $ xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppCurrent = xmobarColor "#152" ""
      , ppLayout = xmobarColor "#152" ""
      , ppTitle = xmobarColor "#ccc" "" . shorten 20
      , ppSep = " "
      }
    }
