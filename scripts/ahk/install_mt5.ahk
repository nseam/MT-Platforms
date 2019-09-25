; AutoHotkey
; Installs MT4.
stdout := FileOpen("*", "w")
stdout.WriteLine("Starting mt_setup.exe...")
Run, "mt_setup.exe"
SetTitleMatchMode, RegEx
WinWait, 5 Setup
Send, !n
stdout.WriteLine("Awaiting installer to finish installation...")
Process, Wait, terminal64.exe, 5
Process, Close, terminal64.exe
WinWaitClose, ahk_exe terminal64.exe, 2
stdout.WriteLine("MT5 installed.")