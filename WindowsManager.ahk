;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MoveWindowToGrid(No, RowCount:=2,ColumnCount:=2, WinTitle:="A",x_w=1,y_h=1){
  WinGetPos,,,,h, ahk_class Shell_TrayWnd
  width := A_ScreenWidth/RowCount ;cell width
  height:= (A_ScreenHeight-h)/ColumnCount ;cell height

  row := floor((No-1) / RowCount) ; Grid row
  column := mod((No-1), RowCount) ; Grid column


  x := column * width		;offest x
  y := row * height		;offset y

  win_width := width * x_w	;set window width
  win_height := height * y_h	;set window height
  WinMove,% WinTitle,,x,y,win_width,win_height
}

;;;;;;;;;;;;;
; |---+---| ;
; | 1 | 2 | ;
; |---+---| ;
; | 3 | 4 | ;
; |---+---| ;
;;;;;;;;;;;;;
$#1::
MoveWindowToGrid(1)
return

$#2::
MoveWindowToGrid(2)
return

$#3::
MoveWindowToGrid(3)
return

$#4::
MoveWindowToGrid(4)
return

$#5::
MoveWindowToGrid(10,8,8,"A",6,6)
return

$#6::
MoveWindowToGrid(1,1,1)
return

$#7::

MoveWindowToGrid(4,2,2,"ahk_exe emacs.exe")
MoveWindowToGrid(3,2,2,"ahk_exe chrome.exe")
return