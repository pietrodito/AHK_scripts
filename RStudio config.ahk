#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetTitleMatchMode, 2 ; Matches anywhere in the window title
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive, RStudio
^j::Send ^{Enter}^[
^m::Send {Enter}
!1::Send ^1
!2::Send ^2
return  
