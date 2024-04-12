
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();

$Username = Read-Host "Enter Username"

$TodaysDate = Get-Date

$NTUserDat = Get-Item "C:\Users\$($Username)\NTUser.dat" -force

$NTUserDat.LastWriteTime = $TodaysDate

$NewNtUserDate = Get-Item "C:\Users\$($Username)\NTUSER.dat" -force

Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"NTUSER.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

$($NewNtUserDate)
