;;# -*- mode: ahk; ahk-indentation: 2 -*-
#singleinstance
#include Input.ahk

; 获取 windows terminal 打开途径
; win + r, shell:AppsFolder
; 将图标拖到桌面，右键查看
; 注意： 带有中文的 ahk 文件要保存未 utf8-bom 形式，否则会有各种意想不到的错误
programs := {}
programs["^!h"] := ["emacs.exe","ahk_exe emacs.exe ahk_class Emacs", "C:\\Program Files (x86)\\Emacs\\i686\\bin\\emacs.exe",""]
programs["^!d"] := ["chrome.exe","ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1", "C:\\Users\\li\\scoop\\apps\\googlechrome\\76.0.3809.132\\chrome.exe",""]
programs["^!s"] := ["msedge.exe","ahk_exe msedge.exe ahk_class Chrome_WidgetWin_1","C:\\Program Files (x86)\\Microsoft\\Edge Beta\\Application\\msedge.exe",""]
programs["^!t"] := ["Explorer.EXE","ahk_exe Explorer.EXE ahk_class CabinetWClass", "C:\\Windows\\explorer.exe",""]
programs["^!n"] := ["WindowsTerminal.exe","ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "explorer.exe shell:Appsfolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",""]
programs["^!w"] := ["微信","ahk_exe WeChatStore.exe ahk_class WeChatMainWndForStore", "explorer.exe shell:Appsfolder\TencentWeChatLimited.forWindows10_sdtnhv12zgd7a!TencentWeChatLimited.forWindows10",""]
programs["^!g"] := ["XiamiPC.exe","ahk_exe XiamiPC.exe ahk_class XiamiHome","C:\\Program Files (x86)\\Xiami\\XiamiPC.exe",""]
programs["^!r"] := ["hh.exe","ahk_exe hh.exe ahk_class HH Parent","C:\\Windows\\hh.exe",""]
programs["^!m"] := ["Nuts.exe","ahk_exe Nuts.exe ahk_class Qt5QWindowIcon","C:\\Program Files (x86)\\Nuts\\Nuts.exe",""]
programs["^!c"] := ["anki.exe","ahk_exe anki.exe ahk_class Qt5QWindowIcon","C:\\Program Files\\Anki\\anki.exe",""]
programs["^!v"] := ["Kindle.exe","ahk_exe Kindle.exe ahk_class Qt5QWindowIcon","C:\\Program Files (x86)\\Amazon\\Kindle\\Kindle.exe",""]
programs["^!z"] :=["ApplicationFrameHost.exe","ahk_exe ApplicationFrameHost.exe ahk_class ApplicationFrameWindow","explorer.exe shell:Appsfolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App","便笺"]
programs["!Space"] := ["everything","ahk_exe Everything.exe ahk_class EVERYTHING", "C:\\Program Files\\Everything\\Everything.exe",""]

tail := Func("CursorTail")
chinese := Func("Chinese")
showIndicator := Func("ShowIndicator")

SwitchApp(params){
  global programs
  key := "^!" . params[1]
  app := programs[key]
  OpenOrShowApp(app)
}

ShowApp(winTitle){
  global tail, chinese, showIndicator
  OutputDebug, % "Show window "  winTitle
  ; 理想情况应该是调用 WinActivate ，激活窗口
  ; 可是虾米音乐显示不出来
  winShow, %winTitle%
  winActivate, %winTitle%
  showIndicator.call()
  tail.call("true")
  chinese.call()
}

ShowOrHideApp(winTitle){
  global lastAppWinTitle
    ; hide and show window http://www.leporelo.eu/blog.aspx?id=hide-and-show-powershell-console-via-autohotkey
    IfWinNotActive, % winTitle
    {
      lastAppWinTitle :=   GetWintitleActive()
      ShowApp(winTitle)
    }
    else
    {
      OutputDebug, % "Hide window "  winTitle
      WinHide, %winTitle%
      ;WinActivate ahk_class Shell_TrayWnd
      ;OutputDebug, % "lastAppWinTitle " lastAppWinTitle
      ShowApp(lastAppWinTitle)
    }
}

IsSameApp(appTitle1, appTitle2){
  StringGetPos, pos, % appTitle2, % appTitle1
  return pos >=0
}

OpenOrShowApp(app){

  global lastAppWinTitle

  appTitle := app[4]
  winTitle := appTitle ? appTitle . " " . app[2]: app[2]
  appPath := app[3]
  ;appInputSource := app[4]

  OutputDebug, "start open or show app"
  DetectHiddenWindows, On
  WinGet, windowsCount, Count,  %winTitle%
  OutputDebug, % winTitle " match " windowsCount

  if (windowsCount <= 0 )
  {
    Run %appPath%
    return
  }

  if (windowsCount = 1)
  {
    ShowOrHideApp(winTitle)
    return
  }

  lastAppWinTitle := GetWintitleActive()

  OutputDebug, % "OpenOrShowApp => lastAppWinTitle:=" lastAppWinTitle " winTitle:=" winTitle
  ;;; 从其他程序切回来，返回上次的窗口
  ;;; 否则在该程序多个窗口，来回显示该窗口
  ;;; 微软的一些程序像（便笺）要构造特别的 winTitle
  ;;; 这里不能直接比较 lastAppWinTitle 和 winTitle 的值
  if(!IsSameApp(winTitle, lastAppWinTitle))
  {
    OutputDebug, % "OpenOrShowApp => show next app which has multiple window by winTitle"
    ShowApp(winTitle)
  }
  else
  {
    OutputDebug, % "OpenOrShowApp => show next window "
    winActivateBottom, % winTitle
  }

  ;;; 在同个程序里切换不语音提示
  ;tail.call("true")
  ;chinese.call()			; 激活输入法,至于输入法由小狼毫来选择

}

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
  OpenOrShowApp(app)
  return
}
;}}}

GetWintitleActive(){
  WinGet,processName,ProcessName,A
  WinGetClass, className, A
  WinGet,processPath,ProcessPath,A
  winTitle := Format("ahk_exe {1} ahk_class {2}", processName, className)
  return winTitle
}

GetProgramInfo(){
  OutputDebug, "Start get programinf"
  WinGet,processName,ProcessName,A
  WinGetClass, className, A
  WinGet,processPath,ProcessPath,A
  winTitle := Format("ahk_exe {1} ahk_class {2}", processName, className)
  OutputDebug, %winTitle%
  result := Format("""{3}"",""{1}"",""{2}"",""""", winTitle, StrReplace(processPath, "\","\\"), processName)

  clipboard := result
  msgbox % result
}
