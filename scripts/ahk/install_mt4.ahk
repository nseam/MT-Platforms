; AutoHotkey
; Installs MT4.
OutputDebug, %A_Now%: Starting mt4setup.exe...
Run, "mt4setup.exe"
SetTitleMatchMode, RegEx
WinWait, 4 Setup
Send, !n
Sleep, 2000
OutputDebug, %A_Now%: Accepting license...
Send, {Space}
Send, {Tab}{Enter}
OutputDebug, %A_Now%: Awaiting installer to finish installation...
Process, Wait, terminal.exe, 5
WinWaitActive, ahk_class MetaQuotes::MetaTrader::4.00
OutputDebug, %A_Now%: Closing installer...
Send, {Esc}, {Esc}, !fx, !{F4} ; File->Exit, Alt-F4
WinWaitClose, ahk_exe terminal.exe, 2
Process, Close, terminal.exe
OutputDebug, %A_Now%: MT4 installed.