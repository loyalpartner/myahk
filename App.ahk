;;# -*- mode: ahk; ahk-indentation: 2 -*-
#singleinstance
#include Input.ahk

; 获取 windows terminal 打开途径
; win + r, shell:AppsFolder
; 将图标拖到桌面，右键查看
programs := {}
programs["^!h"] := ["emacs.exe","ahk_exe emacs.exe ahk_class Emacs", "C:\\Program Files (x86)\\Emacs\\i686\\bin\\emacs.exe","chinese"]
programs["^!t"] := ["chrome.exe","ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1", "C:\\Users\\li\\scoop\\apps\\googlechrome\\76.0.3809.132\\chrome.exe","chinese"]
programs["^!s"] := ["Explorer.EXE","ahk_exe Explorer.EXE ahk_class CabinetWClass", "C:\\Windows\\explorer.exe",""]
programs["^!n"] := ["WindowsTerminal.exe","ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "explorer.exe shell:Appsfolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",""]
programs["^!w"] := ["微信","ahk_exe WeChatStore.exe ahk_class WeChatMainWndForStore", "explorer.exe shell:Appsfolder\TencentWeChatLimited.forWindows10_sdtnhv12zgd7a!TencentWeChatLimited.forWindows10","chinese"]
programs["^!g"] := ["虾米音乐","ahk_exe XiamiPC.exe ahk_class XiamiHome", "","chinese"]
programs["^!r"] := ["hh.exe","ahk_exe hh.exe ahk_class HH Parent","C:\\Windows\\hh.exe",""]
programs["!Space"] := ["everything","ahk_exe Everything.exe ahk_class EVERYTHING", "C:\\Program Files\\Everything\\Everything.exe",""]


Init()
;{{{
Init(){
  global programs
  global tail

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

  tail := Func("CursorTail")
  tail.call()

  ;ChangeInput(appInputSource)
  Chinese()			; 激活输入法,至于输入法由小狼毫来选择
  return
}
;}}}

GetProgramInfo(){
  WinGet,processName,ProcessName,A
  WinGetClass, className, A
  WinGet,processPath,ProcessPath,A

  winTitle := Format("ahk_exe {1} ahk_class {2}", processName, className)

  result := Format("""{3}"",""{1}"",""{2}"",""""", winTitle, StrReplace(processPath, "\","\\"), processName)

  clipboard := result
  msgbox % result
}

; ^!h::
; send ^#1
; CursorTail()
; return
; ^!t::
; Send ^#2
; CursorTail()
; return
; ^!n::
; Send ^#3
; CursorTail()
; return
; ^!s::
; Send ^#4
; CursorTail()
; return
; ^!g::
; Send ^#5
; CursorTail()
; return
; ^!c::
; Send ^#6
; CursorTail()
; return
; ^!r::
; Send ^#7
; CursorTail()
; return
; ^!l::
; Send ^#8
; CursorTail()
; return
; !Space::
; Run "C:\Program Files\Everything\Everything.exe"
; CursorTail()
; return
