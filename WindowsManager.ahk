;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-
GetCurrentMonitor()
{
  SysGet, numberOfMonitors, MonitorCount
  WinGetPos, winX, winY, winWidth, winHeight, A
  winMidX := winX + winWidth / 2
  winMidY := winY + winHeight / 2
  Loop %numberOfMonitors%
  {
    SysGet, monArea, Monitor, %A_Index%
    if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop)
      return %A_Index%
  }
}

GetMonitorScreen(index){
  SysGet, monArea, Monitor, %index%
  return {left:monAreaLeft,top:monAreaTop,width:monAreaRight-monAreaLeft,height:monAreaBottom-monAreaTop}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 假设 montor 的索引大于 0
MoveWindowToGrid(No,monitorIndex = -1, RowCount:=2,ColumnCount:=2, WinTitle:="A",x_w=1,y_h=1){

  if(monitorIndex = -1)
    monitorIndex := GetCurrentMonitor()

  monitor := GetMonitorScreen(monitorIndex)

  WinGetPos,,,,h, ahk_class Shell_TrayWnd
  width := monitor.width/RowCount ;cell width
  height:= (monitor.height-h)/ColumnCount ;cell height

  row := floor((No-1) / RowCount) ; Grid row
  column := mod((No-1), RowCount) ; Grid column


  x := column * width + monitor.left		;offest x
  y := row * height + monitor.top		;offset y

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
^!1::
MoveWindowToGrid(10,1,8,8,"A",6,6)
return
^!2::
MoveWindowToGrid(10,2,8,8,"A",6,6)
return
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
MoveWindowToGrid(10,-1,8,8,"A",6,6)
return

$#6::
MoveWindowToGrid(1,-1,1,1)
return

$#7::

MoveWindowToGrid(4,-1,2,2,"ahk_exe emacs.exe")
MoveWindowToGrid(3,-1,2,2,"ahk_exe chrome.exe")
return