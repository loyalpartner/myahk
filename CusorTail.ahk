;;# -*- mode: ahk; ahk-indentation: 2 -*-

SetCursor(x, y) {
  ;;; 多显示器要移动两次才能正确移动到指定位置
  DllCall("SetCursorPos", int, x, int, y)
  DllCall("SetCursorPos", int, x, int, y)
}

CursorTail(){

  sleep, 100
  WinGetPos, x, y, width , height,A
  monitor := MonitorDetect.Current
  x1 :=  x + 300
  y1 :=  y+ 300
  SetCursor(x1,y1)
}
