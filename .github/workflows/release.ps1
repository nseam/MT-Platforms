Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
scoop update
Invoke-WebRequest -Uri https://github.com/Lexikos/AutoHotkey_L/releases/download/v1.1.30.03/AutoHotkey_1.1.30.03_setup.exe -OutFile AHK_setup.exe

If ($env:TARGET_VERSION -eq 4) {
  echo "Downloading MetaTrader 4..."
  wget "https://web.archive.org/web/20160112133258if_/https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4setup.exe?utm_campaign=www.metatrader4.com" -OutFile mt_setup.exe
}
ElseIf ($env:TARGET_VERSION -eq 5) {
  echo "Downloading MetaTrader 5..."
  wget "https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe" -OutFile mt_setup.exe
}
Else {
  echo "Unknown MetaTrader version specified. The TARGET_VERSION value in matrix needs to be 4 or 5."
  $host.SetShouldExit(1)
}

set MT_SETUP_VERSION (Get-Item 'mt_setup.exe').VersionInfo.FileVersion
./AHK_setup.exe /S /D=C:\Program Files\AutoHotkey
set "REPODIR=%cd%"
type "scripts\ahk\install_mt${env:TARGET_VERSION}.ahk"
& "C:\Program Files\AutoHotkey\AutoHotkey.exe" /ErrorStdOut "scripts\ahk\install_mt${env:TARGET_VERSION}.ahk" 2>&1 | more

If ($env:TARGET_VERSION -eq 4) {
  set MT_VERSION (Get-Item 'C:\Program Files (x86)\MetaTrader 4\terminal.exe').VersionInfo.FileVersion
  set ME_VERSION (Get-Item 'C:\Program Files (x86)\MetaTrader 4\metaeditor.exe').VersionInfo.FileVersion
}
ElseIf ($env:TARGET_VERSION -eq 5) {
  set MT_VERSION (Get-Item 'C:\Program Files\MetaTrader 5\terminal64.exe').VersionInfo.FileVersion
  set ME_VERSION (Get-Item 'C:\Program Files\MetaTrader 5\metaeditor64.exe').VersionInfo.FileVersion
}
Else {
  echo "Error: Unsupported platform version!"
}

echo "MetaTrader terminal version is $MT_VERSION"

If ($env:TARGET_VERSION -eq 4) {
  Reg export "HKCU\Software\MetaQuotes Software\MetaTrader 4" "C:\\Program Files (x86)\\MetaTrader 4\\registry.reg"
}
ElseIf ($env:TARGET_VERSION -eq 5) {
  Reg export "HKCU\Software\MetaQuotes Software\MetaTrader 5" "C:\\Program Files\\MetaTrader 5\\registry.reg"
}
Else {
  echo "Error: Unsupported platform version!"
}

set MT_ZIP "mt-${MT_VERSION}.zip"

If ($env:TARGET_VERSION -eq 4) {
  7z a ${MT_ZIP} "C:\\Program Files (x86)\\MetaTrader 4"
}
ElseIf ($env:TARGET_VERSION -eq 5) {
  7z a ${MT_ZIP} "C:\\Program Files\\MetaTrader 5"
}
Else {
  echo "Error: Unsupported platform version!"
}


dir *.zip

$env:MT_VERSION=$MT_VERSION
$env:ME_VERSION=$ME_VERSION

echo "Releasing MetaTrader Setup $MT_SETUP_VERSION..."