;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-
#SingleInstance

global actionMap := {}
actionMap["c"] := "Up"
actionMap["t"] := "Down"
actionMap["h"] := "Left"
actionMap["n"] := "Right"
actionMap["u"] := "Middle"
actionMap["e"] := "FullScreen"
actionMap["g"] := "PrevMonitor"
actionMap["r"] := "NextMonitor"

ControlWindow(params)
{
  global actionMap

  wm := params[1]
  char := params[2]
  action := actionMap[char]
  ; msgbox % action " -" actionMap["c"]
  if (action)
  {
    OutputDebug, % action
    ObjBindMethod(wm, action).call()
    CursorTail()
  }
  else
  {
    wm.MoveTo(char)
    CursorTail()
 }
}
