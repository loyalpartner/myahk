;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-
#SingleInstance


ControlWindow(params)
{
  wm := params[1]
  char := params[2]

  if(char="n")
  {
    wm.Right()
    CursorTail()
  }
  else if (char="h")
  {
    wm.Left()
    CursorTail()
  }
  else if (char="c")
  {
    wm.Up()
    CursorTail()
  }
  else if (char="t")
  {
    wm.Down()
    CursorTail()
  }
  else if (char="u")
  {
    wm.Middle()
    CursorTail()
  }
  else if (char="e")
  {
    wm.FullScreen()
    CursorTail()
  }
  else{
    wm.MoveTo(char)
    CursorTail()
 }
}
