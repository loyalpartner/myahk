;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-

WaitKeyNo(wm, type := "2x2")
{
  global grid := wm
  Loop, 8
  {
    k := Chr(A_Index + 48)
    Hotkey % k, MoveTo
    Hotkey % k, On
  }
  Run  , % "Speaker.ahk " . type
return
MoveTo:
  grid.MoveTo(a_thishotkey)
  CursorTail()
  Loop, 8
  {
    k := Chr(A_Index + 48)
    Hotkey % k, off
  }
  return
}