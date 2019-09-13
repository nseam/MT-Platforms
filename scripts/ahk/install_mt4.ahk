; AutoHotkey
; Installs MT4.
Run, "mt4setup.exe"
SetTitleMatchMode, RegEx
WinWait, 4 Setup
Send, !n
Sleep, 2000
Send, {Space}
Send, {Tab}{Enter}
Process, Wait, terminal.exe, 5
WinWaitActive, ahk_class MetaQuotes::MetaTrader::4.00
Send, {Esc}, {Esc}, !fx, !{F4} ; File->Exit, Alt-F4
WinWaitClose, ahk_exe terminal.exe, 2
Process, Close, terminal.exe