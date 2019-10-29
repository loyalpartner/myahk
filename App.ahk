;;# -*- mode: ahk; ahk-indentation: 2 -*-
#singleinstance
#include Input.ahk

; 获取 windows terminal 打开途径
; win + r, shell:AppsFolder
; 将图标拖到桌面，右键查看
; 注意： 带有中文的 ahk 文件要保存未 utf8-bom 形式，否则会有各种意想不到的错误
programs := {}
programs["^!h"] := ["emacs.exe","ahk_exe emacs.exe ahk_class Emacs", "C:\\Program Files (x86)\\Emacs\\i686\\bin\\emacs.exe",""]
programs["^!t"] := ["chrome.exe","ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1", "C:\\Users\\li\\scoop\\apps\\googlechrome\\76.0.3809.132\\chrome.exe",""]
programs["^!s"] := ["Explorer.EXE","ahk_exe Explorer.EXE ahk_class CabinetWClass", "C:\\Windows\\explorer.exe",""]
programs["^!n"] := ["WindowsTerminal.exe","ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "explorer.exe shell:Appsfolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",""]
programs["^!w"] := ["微信","ahk_exe WeChatStore.exe ahk_class WeChatMainWndForStore", "explorer.exe shell:Appsfolder\TencentWeChatLimited.forWindows10_sdtnhv12zgd7a!TencentWeChatLimited.forWindows10",""]
programs["^!g"] := ["虾米音乐","ahk_exe XiamiPC.exe ahk_class XiamiHome", "",""]
programs["^!r"] := ["hh.exe","ahk_exe hh.exe ahk_class HH Parent","C:\\Windows\\hh.exe",""]
programs["^!m"] := ["Nuts.exe","ahk_exe Nuts.exe ahk_class Qt5QWindowIcon","C:\\Program Files (x86)\\Nuts\\Nuts.exe",""]
programs["^!c"] := ["anki.exe","ahk_exe anki.exe ahk_class Qt5QWindowIcon","C:\\Program Files\\Anki\\anki.exe",""]
programs["^!v"] := ["Kindle.exe","ahk_exe Kindle.exe ahk_class Qt5QWindowIcon","C:\\Program Files (x86)\\Amazon\\Kindle\\Kindle.exe",""]
programs["^!z"] :=["ApplicationFrameHost.exe","ahk_exe ApplicationFrameHost.exe ahk_class ApplicationFrameWindow","C:\\Windows\\System32\\ApplicationFrameHost.exe","便笺"]
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
  appTitle := app[4]
  winTitle := appTitle . " " . app[2]
  appPath := app[3]
  ;appInputSource := app[4]

  DetectHiddenWindows, On
  WinGet, windowsCount, Count,  %winTitle%

  tail := Func("CursorTail")

  if (windowsCount <= 0 )
  {
    Run %appPath%
    return
  }

  if windowsCount = 1
  {
    ; hide and show window http://www.leporelo.eu/blog.aspx?id=hide-and-show-powershell-console-via-autohotkey
    IfWinNotActive, % winTitle
    {
      winShow, %winTitle%
      winActivate, %winTitle%
    }
    else
    {
      WinHide, %winTitle%
      WinActivate ahk_class Shell_TrayWnd
      return
    }
  }


  ;;; 如果有多个窗口，来回显示该窗口
  if (windowsCount > 1 )
  {
    winActivateBottom, % winTitle
  }

  tail.call("true")
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
