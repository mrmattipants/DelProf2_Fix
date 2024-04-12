Dim WshShell, strCurDir
Set WshShell = CreateObject("WScript.Shell")
strCurDir    = WshShell.CurrentDirectory
CreateObject("Wscript.Shell").Run """" & strCurDir & "\Run_DelProf2_Script.bat" & """" ,0,True
Set WshShell = Nothing