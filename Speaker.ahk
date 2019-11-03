#NoTrayIcon
;; https://autohotkey.com/board/topic/77686-text-to-speech-examples-for-autohotkey-v11/
;; 中文语音乱码
;; 将相关文件保存为 utf8-bom
;; C-x Ret r cp65001
#Include Core.ahk

if A_Args.length() > 0
  Speak(A_Args[1])
