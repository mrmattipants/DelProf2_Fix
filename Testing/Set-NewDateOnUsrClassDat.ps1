
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();

$Username = "Username"

$NewDate = Get-Date -Date "Tuesday, June 6, 2023 12:05:00 AM"

$NumberofDays = 0

If ($NewDate -and (!$NumberofDays -or $NumberofDays -lt 1)) {

    $UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    $UsrClassDat.LastWriteTime = $NewDate

    $NewUsrClassDate = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"UsrClass.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

    $($NewUsrClassDate)

} ElseIf ($NumberofDays -and $NumberofDays -gt 0 -and !$NewDate) {

    $UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    $NewDate = ($UsrClassDat.LastWriteTime).AddDays(-$NumberofDays)

    $UsrClassDat.LastWriteTime = $NewDate

    $NewUsrClassDate = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"UsrClass.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

    $($NewUsrClassDate)

} ElseIf ($NumberofDays -and $NumberofDays -gt 0 -and $NewDate) {
    
    $UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    $NewDate = ($NewDate).AddDays(-$NumberofDays)

    $UsrClassDat.LastWriteTime = $NewDate

    $NewUsrClassDate = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"UsrClass.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

    $($NewUsrClassDate)

} Else {
    
    Write-Host "`nThe`"UsrClass.dat`" File, belonging to the `"$($Username)`" User Profile, has NOT been Updated, because the `"NewDate`" and/or `"NumberOfDays`" Variables were NOT Correctly Set" -ForegroundColor Red

    $($NewUsrClassDate)

}