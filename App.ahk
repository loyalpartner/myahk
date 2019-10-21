;;# -*- mode: ahk; ahk-indentation: 2 -*-
#singleinstance
#include Input.ahk

; 获取 windows terminal 打开途径
; win + r, shell:AppsFolder
; 将图标拖到桌面，右键查看
programs := {}
programs["^!h"] := ["emacs.exe","ahk_exe emacs.exe ahk_class Emacs", "C:\\Program Files (x86)\\Emacs\\i686\\bin\\emacs.exe",""]
programs["^!t"] := ["chrome.exe","ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1", "C:\\Users\\li\\scoop\\apps\\googlechrome\\76.0.3809.132\\chrome.exe",""]
programs["^!s"] := ["Explorer.EXE","ahk_exe Explorer.EXE ahk_class CabinetWClass", "C:\\Windows\\explorer.exe",""]
programs["^!n"] := ["WindowsTerminal.exe","ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "explorer.exe shell:Appsfolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",""]
programs["^!w"] := ["微信","ahk_exe WeChatStore.exe ahk_class WeChatMainWndForStore", "explorer.exe shell:Appsfolder\TencentWeChatLimited.forWindows10_sdtnhv12zgd7a!","chinese"]
programs["^!g"] := ["虾米音乐","ahk_exe XiamiPC.exe ahk_class XiamiHome", "","chinese"]
programs["!Space"] := ["everything","ahk_exe Everything.exe ahk_class EVERYTHING", "C:\\Users\\li\\scoop\\apps\\emacs\\26.3\\bin\\emacs.exe",""]
;programs["^!q"] := ["qq", "ahk_exe QQ.exe ahk_class TXGuiFoundation", "", "chinese"]
;

Init()

Init(){
  global programs
  for i,v in programs
  {
    Hotkey, % i, OpenOrShowApp
  }
  return
OpenOrShowApp:
  app := programs[a_thishotkey]
  ;appName := app[1]
  appClass := app[2]
  appPath := app[3]
  appInputSource := app[4]

  DetectHiddenWindows, On
  WinGet, windowsCount, Count,  %appClass%

  ;msgbox % windowsCount
  if windowsCount = 1
  {
    winActivate, % appClass
  }

  if (windowsCount <= 0 )
  {
    Run %appPath%
    return
  }

  if (windowsCount > 1 ){
    winActivateBottom, % appClass
  }

  CusorTail()
  ChangeInput(appInputSource)
  return
}

; ^!h::
; send ^#1
; CusorTail()
; return
; ^!t::
; Send ^#2
; CusorTail()
; return
; ^!n::
; Send ^#3
; CusorTail()
; return
; ^!s::
; Send ^#4
; CusorTail()
; return
; ^!g::
; Send ^#5
; CusorTail()
; return
; ^!c::
; Send ^#6
; CusorTail()
; return
; ^!r::
; Send ^#7
; CusorTail()
; return
; ^!l::
; Send ^#8
; CusorTail()
; return
; !Space::
; Run "C:\Program Files\Everything\Everything.exe"
; CusorTail()
; return
