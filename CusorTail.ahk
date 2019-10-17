;;# -*- mode: ahk; ahk-indentation: 2 -*-


log(str){
  ToolTip, %str%,500,500
  SetTimer, RemoveToolTip, -5000
  return

RemoveToolTip:
  ToolTip
  return
}


SetCursor(x,y) {
  ;;; 多显示器要移动两次才能正确移动到指定位置
  DllCall("SetCursorPos", int, x , int, y)
  DllCall("SetCursorPos", int, x , int, y)
}

CusorTail(){
  sleep,1000
  WinGetPos, x, y, width , height,A
  monitor := MonitorDetect.Current
  x1 :=  x + 300
  y1 :=  y+ 300
  SetCursor(x1,y1)
}

; ^1::
; CusorTail()
; return