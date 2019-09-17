; AutoHotkey
; Installs MT4.
stdout := FileOpen("*", "w")
stdout.WriteLine("Starting mt4setup.exe...")
Run, "mt4setup.exe"
SetTitleMatchMode, RegEx
WinWait, 4 Setup
Send, !n
Sleep, 2000
stdout.WriteLine("Accepting license...")
Send, {Space}
Send, {Tab}{Enter}
Sleep, 5000
WinActivate, 4 Setup
stdout.WriteLine("Awaiting installer to finish installation...")
Process, Wait, terminal.exe, 5
WinWaitActive, ahk_class MetaQuotes::MetaTrader::4.00
stdout.WriteLine("Closing installer...")
Send, {Esc}, {Esc}, !fx, !{F4} ; File->Exit, Alt-F4
WinWaitClose, ahk_exe terminal.exe, 2
Process, Close, terminal.exe
stdout.WriteLine("MT4 installed.")