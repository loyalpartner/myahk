
;;# -*- mode: ahk; ahk-indentation: 2;  -*-
#singleinstance force

Menu, Tray, Icon,emacs.png

;;; 注意 autohotey 变量的声明必须在热键定义之前
;;; 要不然会失效
;;; TODO 改名
#Include Core.ahk
#Include CusorTail.ahk
#Include Grid.ahk
#Include TopMost.ahk
#Include WindowsManager.ahk
;#Include Input.ahk

wm := New Grid(1,3)
wm2x4 := New Grid(2,4)

currentMonitor := MonitorDetect.Current
winposinfo := {}
;#Include EmacsKey.ahk
#Include App.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 重置配置和编辑配置文件 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!]:: reload

;;; edit settings
;;; ﻿RegWrite REG_SZ, HKCR, AutoHotkeyScript\Shell\Edit\Command,, "C:\Users\li\scoop\apps\emacs\26.3\bin\emacsclientw.exe" -n -a runemacs.exe "`%1"
^!f11:: edit

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
#!1:: wm.MoveToMonitor(MonitorDetect.Prev,1)
#!2:: wm.MoveToMonitor(MonitorDetect.Next,1)

;#a:: KeyChordUntilEndChar(Func("ControlWindow"), [wm2x4])
;#o:: WaitChar(Func("ControlWindow"), [wm2x4])

#1:: wm.MoveTo(1)
#2:: wm.MoveTo(2)
#3:: wm.MoveTo(3)
#4:: wm.MoveTo(4)
#5:: wm.Middle()
#6:: wm.FullScreen()
$#7:: wm2x4.MoveTo(7)
$#8:: wm2x4.MoveTo(8)

$^!,:: ToggleTopMost()
$^!.:: TempTransparent()
$#':: CloseWindow()
^!8:: GetProgramInfo()

#IfWinActive,ahk_class Chrome_WidgetWin_1
^n:: Send {Down} return
^p:: Send {up} return
#IfWinActive

#If,WinActive("ahk_class X410_XAppWin")
AppsKey::RControl
~AppsKey & 1:: wm.MoveTo(1) return
~AppsKey & 2:: wm.MoveTo(2) return
~AppsKey & 3:: wm.MoveTo(3) return
~AppsKey & 4:: wm.MoveTo(4) return
~AppsKey & 5:: wm.Middle() return
~AppsKey & 6:: wm.FullScreen() return
#If

#If, !WinActive("ahk_class Emacs")
AppsKey::RWin
#IF

;#Include EmacsKey.ahk
