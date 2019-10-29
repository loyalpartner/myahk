;; https://autohotkey.com/board/topic/77686-text-to-speech-examples-for-autohotkey-v11/
;; 中文语音乱码
;; 将相关文件保存为 utf8-bom
;; C-x Ret r mule-utf-8-dos
if A_Args.length() > 0
  Speak(A_Args[1])

Speak(words){
  ComObjCreate("SAPI.SpVoice").Speak(words)
}
