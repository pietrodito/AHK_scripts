#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#^Esc::
  WinGet, TransLevel, Transparent, A
  If (TransLevel = OFF) {
    WinSet, Transparent, 200, A
  } Else {
    WinSet, Transparent, OFF, A
  }
return
