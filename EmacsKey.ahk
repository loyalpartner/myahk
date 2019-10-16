;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-

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


global blacklist := "i)^(emacs.exe|explorer.exe|windowsterminal.exe)$"


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
