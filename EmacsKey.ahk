;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-

#singleinstance

Menu, Tray, Icon,emacs.png

global emacs_key_map := {}
emacs_key_map["^p"] := "{Up}"
emacs_key_map["^n"] := "{Down}"
emacs_key_map["^f"] := "{Right}"
emacs_key_map["^b"] := "{Left}"
emacs_key_map["^a"] := "{Home}"
emacs_key_map["^e"] := "{End}"
emacs_key_map["^d"] := "{Del}"
;emacs_key_map["^g"] := "{Esc}"
emacs_key_map["!b"] := "^{Left}"
emacs_key_map["!f"] := "^{Right}"
emacs_key_map["!d"] := "^{Del}"


blacklist := "i)^(emacs.exe|explorer.exe|windowsterminal.exe)$"

#IF EmacsKeySwitch()
EmacsKeySwitch()
{
  global blacklist
  global reverse_mode

  WinGet,procName,ProcessName , A

  switch := true
  if (procName ~= blacklist){
    switch := false
  }
  if(reverse_mode){
    switch := !switch
  }
  return switch
}
#IF

hotkey,If,EmacsKeySwitch()
for k,v in emacs_key_map{
hotkey,% "$" k, EmacsKeyPress
}
return

EmacsKeyPress:
  keystroke := substr(a_thishotkey,2)

  send % emacs_key_map[keystroke]
return

^!9::
reverse_mode := !reverse_mode

if(reverse_mode)
  trayTip, ReverseMode, ReverseMode, 1
return

^f12::
reload
return

;;; edit settings
;;; ﻿RegWrite REG_SZ, HKCR, AutoHotkeyScript\Shell\Edit\Command,, "C:\Users\li\scoop\apps\emacs\26.3\bin\emacsclientw.exe" -n -a runemacs.exe "`%1"
^f11::
edit
return

#Include app.ahk
#Include WindowsManager.ahk