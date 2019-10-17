;;# -*- mode: ahk; ahk-indentation: 2 -*-
SetCursor(x,y) { ;if mouse is larger than primary width then add that width to x position
  mousegetpos,mx,my
  DllCall("SetCursorPos", int, x + (mx > A_ScreenWidth ? A_ScreenWidth : 0), int, y)
}

MouseFollow(){
  WinGetPos, x, y, width , height,A

  x1 := x + width * 0.3
  y1 := y+height*0.3
  SetCursor(x1,y1)
}
