
;;# -*- mode: ahk; ahk-indentation: 2 -*-
#singleinstance
#include Input.ahk

; 获取 windows terminal 打开途径
; win + r, shell:AppsFolder
; 将图标拖到桌面，右键查看
; 注意： 带有中文的 ahk 文件要保存未 utf8-bom 形式，否则会有各种意想不到的错误
programs := {}

wow_path = "C:\\Program Files (x86)\\World of Warcraft\\_classic_\\WowClassic.exe"
chrome_path = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
explorer_path = "C:\\windows\explorer.exe"
programs["^!h"] := ["emacs.exe","ahk_exe X410.exe ahk_class X410_XAppWin", "Emacs.vbs",""]

; programs["^!u"] := ["WowClassic.exe","ahk_exe WowClassic.exe ahk_class GxWindowClass",wow_path,""]
programs["^!t"] := ["chrome.exe","ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1",chrome_path,""]
programs["^!s"] := ["Explorer.EXE","ahk_exe Explorer.EXE ahk_class CabinetWClass", explorer_path,""]
programs["^!n"] := ["WindowsTerminal.exe","ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "explorer.exe shell:Appsfolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",""]
;programs["^!i"] := ["devenv.exe","ahk_exe devenv.exe ahk_class HwndWrapper[DefaultDomain;;e224e650-3172-494c-bb8f-49edb9f395cb]","C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\Common7\\IDE\\devenv.exe",""]
programs["^!w"] := ["微信","ahk_exe WeChatStore.exe ahk_class WeChatMainWndForStore", "explorer.exe shell:Appsfolder\TencentWeChatLimited.forWindows10_sdtnhv12zgd7a!TencentWeChatLimited.forWindows10",""]
programs["^!g"] := ["XiamiPC.exe","ahk_exe XiamiPC.exe ahk_class XiamiHome","C:\\Program Files (x86)\\Xiami\\XiamiPC.exe",""]
programs["^!r"] := ["hh.exe","ahk_exe hh.exe ahk_class HH Parent","C:\\Windows\\hh.exe",""]
programs["^!m"] := ["nvim-qt.exe","ahk_exe nvim-qt.exe ahk_class Qt5QWindowIcon","C:\\Users\\li\\scoop\\apps\\neovim-nightly\\nightly-20190821\\bin\\nvim-qt.exe",""]
programs["^!c"] := ["anki.exe","ahk_exe anki.exe ahk_class Qt5QWindowIcon","C:\\Program Files\\Anki\\anki.exe",""]
programs["^!v"] := ["Kindle.exe","ahk_exe Kindle.exe ahk_class Qt5QWindowIcon","C:\\Program Files (x86)\\Amazon\\Kindle\\Kindle.exe",""]
programs["^!z"] :=["ApplicationFrameHost.exe","ahk_exe ApplicationFrameHost.exe ahk_class ApplicationFrameWindow","explorer.exe shell:Appsfolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App","便笺"]
;programs["!Space"] := ["everything","ahk_exe Everything.exe ahk_class EVERYTHING", "C:\\Program Files\\Everything\\Everything.exe",""]

tail := Func("CursorTail")
chinese := Func("Chinese")
showIndicator := Func("ShowIndicator")

SwitchApp(params){
  global programs
  key := "^!" . params[1]
  app := programs[key]
  OpenOrShowApp(app)
}

OpenOrShowApp(app){

  global lastAppWinTitle
  global showIndicator

  appTitle := app[4]
  winTitle := appTitle ? appTitle . " " . app[2]: app[2]
;  msgbox, %wintitle%
  appPath := app[3]

  if WinExist(winTitle) {
    winActivateBottom, % winTitle
  }else{
    Run %appPath%
  }

  showIndicator.call()
}

Init()
;{{{
Init(){
  global programs
  global tail

  for i,v in programs
  {
    Hotkey, IfWinNotActive,ahk_class Emacs
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
