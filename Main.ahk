;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-

#singleinstance force

Menu, Tray, Icon,emacs.png

;;; 注意 autohotey 变量的声明必须在热键定义之前
;;; 要不然会失效
#Include Grid.ahk
wm := New Grid()
#Include EmacsKey.ahk
#Include App.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 重置配置和编辑配置文件 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^f12::
reload
return

;;; edit settings
;;; ﻿RegWrite REG_SZ, HKCR, AutoHotkeyScript\Shell\Edit\Command,, "C:\Users\li\scoop\apps\emacs\26.3\bin\emacsclientw.exe" -n -a runemacs.exe "`%1"
^f11::
edit
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; windows move
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;
; |---+---| ;
; | 1 | 2 | ;
; |---+---| ;
; | 3 | 4 | ;
; |---+---| ;
;;;;;;;;;;;;;
#!1::
wm.MoveToMonitor(new Monitor(1),1)
wm.Middle()
return
#!2::
wm.MoveToMonitor(new Monitor(2),1)
wm.Middle()
return
#1::
wm.MoveTo(1)
return
#2::
wm.MoveTo(2)
return
#3::
wm.MoveTo(3)
return
#4::
wm.MoveTo(4)
return

$#5::
wm.Middle()
return

$#6::
wm.FullScreen()
return

$#7::

wm.MoveAppTo(1,"ahk_exe WindowsTerminal.exe")
wm.MoveAppTo(2,"ahk_exe Explorer.EXE ahk_class CabinetWClass")
wm.MoveAppTo(3,"ahk_exe chrome.exe")
wm.MoveAppTo(4,"ahk_exe emacs.exe")

return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; EmacsMode switch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!9::
reverse_mode := !reverse_mode
if(reverse_mode)
  trayTip, ReverseMode, ReverseMode, 1
return


;#Include EmacsKey.ahk