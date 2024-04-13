@echo on

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy ByPass -File "%~dp0Update-NtUserDatTimestamp"

"%~dp0DelProf2.exe" /d:90 /l

PAUSE