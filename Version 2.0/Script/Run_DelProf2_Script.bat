@echo off

START /WAIT C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy ByPass -File "%~dp0Update-NtUserDatTimestamp.ps1" | ECHO > nul

"%~dp0DelProf2.exe" /d:90 /q

EXIT
