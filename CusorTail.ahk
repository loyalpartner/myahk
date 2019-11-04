;;# -*- mode: ahk; ahk-indentation: 2 -*-
CreateGUI() {

        global
    Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
    Gui, Margin, 0, 0
    Gui, Color, Black
    Gui, Font, cWhite s50 bold, Arial
    Gui, Add, Text, vHotkeyText Center y20

    WinSet, Transparent, 200
}

ShowIndicator() {
    WinGetPos, x, y, width, height, A
    if !x
	throw

    text_w := (ActWin_W > A_ScreenWidth) ? A_ScreenWidth : ActWin_W
    GuiControl,     , HotkeyText, ^
    GuiControl, Move, HotkeyText, w100 Center


    gui_x := x + width/2 - 100
    gui_y := y + height/2 - 150
    Gui, Show, NoActivate x%gui_x% y%gui_y% h100 w100

    SetTimer HideGui, 500
}
CreateGUI()
HideGUI() {
    Gui, Hide
}


SetCursor(x, y) {
  ;;; 多显示器要移动两次才能正确移动到指定位置
  DllCall("SetCursorPos", int, x, int, y)
  DllCall("SetCursorPos", int, x, int, y)
}

CursorTail(speak:=false){
  HideGUI()
  sleep, 30

  WinGetPos, x, y, width , height,A
  monitor := MonitorDetect.Current
  x1 :=  x + width/3
  y1 :=  y+ height/3
  SetCursor(x1,y1)

  WinGet,nextProcessName, ProcessName, A
  nextProcessName := StrReplace(nextProcessName, ".exe" "")
  ShowIndicator()
  if speak = true
  {
    ;; 增加语音提示
    ;; 这里有个坑，直接调用语音接口会卡顿
    ;; 一开始是打算用线程实现，发现 ahk 是没有线程的
    ;; 接着用 settimer 实现了一个版本，依然卡
    ;; 最后选择另外开一个 ahk 文件，hacker 了这个问题
    Run  , % "Speaker.ahk " . nextProcessName
  }
}