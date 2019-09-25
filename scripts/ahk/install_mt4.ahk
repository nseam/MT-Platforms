; AutoHotkey
; Installs MT4.
stdout := FileOpen("*", "w")
stdout.WriteLine("Starting mt_setup.exe...")
Run, "mt_setup.exe"
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
Process, Close, terminal.exe
WinWaitClose, ahk_exe terminal.exe, 2
stdout.WriteLine("MT4 installed.")