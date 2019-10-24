;;# -*- mode: ahk; ahk-indentation: 2;  -*-
#singleinstance force

Menu, Tray, Icon,emacs.png

;;; 注意 autohotey 变量的声明必须在热键定义之前
;;; 要不然会失效
;;; TODO 改名
#Include CusorTail.ahk
#Include Grid.ahk
#Include TopMost.ahk
;#Include Input.ahk

wm := New Grid()
currentMonitor := MonitorDetect.Current
winposinfo := {}
;#Include EmacsKey.ahk
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
CursorTail()
return
#!2::
wm.MoveToMonitor(new Monitor(2),1)
wm.Middle()
CursorTail()
return
#1::
wm.MoveTo(1)
CursorTail()
return
#2::
wm.MoveTo(2)
CursorTail()
return
#3::
wm.MoveTo(3)
CursorTail()
return
#4::
wm.MoveTo(4)
CursorTail()
return

$#5::
wm.Middle()
CursorTail()
return

$#6::
wm.FullScreen()
CursorTail()
return

$#7::
wm.MoveAppTo(1,"ahk_exe WindowsTerminal.exe")
wm.MoveAppTo(2,"ahk_exe Explorer.EXE ahk_class CabinetWClass")
wm.MoveAppTo(3,"ahk_exe chrome.exe")
wm.MoveAppTo(4,"ahk_exe emacs.exe")
return

$^!,::
ToggleTopMost()
return

; 透明度
; 有时候相看其他窗口的文字，可是又被挡住了，
; 这时候可以临时透明当前窗口查看被挡住的信息
$^!.::
TempTransparent()
return

$#'::
CloseWindow()
return

F7::
GetProgramInfo()
return

#IfWinActive,ahk_exe everything.exe
^1::
Send {AppsKey}
return
#IfWinActive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; EmacsMode switch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!9::
reverse_mode := !reverse_mode
if(reverse_mode)
  trayTip, ReverseMode, ReverseMode, 1
return

;#Include EmacsKey.ahk