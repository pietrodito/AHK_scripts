; pietrodio@gmail.com 

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2 ; Matches anywhere in the window title
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

#IfWinActive, Firefox
^m::Send {Enter}
return  

#IfWinActive, Firefox
^p::Send {Up}
return  

#IfWinActive, Firefox
^n::Send {Down}
return  
