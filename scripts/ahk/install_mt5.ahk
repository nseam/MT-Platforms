; AutoHotkey
; Installs MT4.
stdout := FileOpen("*", "w")
stdout.WriteLine("Starting mt_setup.exe...")
Run, "mt_setup.exe"
SetTitleMatchMode, RegEx
WinWait, 5 Setup
Send, !n
stdout.WriteLine("Awaiting installer to finish installation (waiting up to 5min)...")
Process, Wait, terminal64.exe, 300
Process, Close, terminal64.exe
stdout.WriteLine("Awaiting terminal to close (waiting up to 10s)...")
WinWaitClose, ahk_exe terminal64.exe, 10
stdout.WriteLine("MT5 installed.")