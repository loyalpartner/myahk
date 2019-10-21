;# -*- mode: ahk; ahk-indentation: 2 -*-
;
; 关于输入法切换，可参考
; https://gist.github.com/loyalpartner/63d88a6aea0fdb1fcbe05747733dc7ae
en := DllCall("LoadKeyboardLayout", "Str", "00000409", "Int", 1)
zh := DllCall("LoadKeyboardLayout", "Str", "00000804", "Int", 1)

Chinese(){
  DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str, "00000804", UInt, 1))
}

English(){
  DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str, "00000409", UInt, 1))
}

ChangeInput(source="english"){
  if(source = "chinese")
    Chinese()
  else
    English()
}
