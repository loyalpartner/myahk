;;# -*- mode: ahk; ahk-indentation: 2 -*-


ToggleTopMost(){
  WinSet, AlwaysOnTop, Toggle, A
}

TempTransparent(time=-5000){
  #Persistent
  WinSet, Transparent, 190, A
  SetTimer, RestoreTransparent, % time
  return
RestoreTransparent:
  WinSet, Transparent, 250, A
  return
}

CloseWindow(){
  WinClose, A
}