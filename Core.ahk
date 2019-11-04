;;# -*- mode: ahk; ahk-indentation: 2 -*-

Speak(words){
  try
  {
    ComObjCreate("SAPI.SpVoice").Speak(words)
  }
}                               ;

WaitChar(callback, params){
  Input, Key, L1
  params.push(Key)
  callback.call(params)
}

KeyChordUntilEndChar(callback, params){

  Loop
  {
    Input, Key, L1
    params.Push(Key)
    If(key = "a" || key = "s" || key = Chr(27))
      break
    callback.call(params)
    params.Pop()
  }
}
