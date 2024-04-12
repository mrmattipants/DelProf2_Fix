
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();

$NumberofDays = 0

$Username = Read-Host "Enter Username"

$Choice = Read-Host "Type `"1`" to Set Date/Time or Type `"2`" to Set Number of Days"

If ($Choice -eq "1") {

	$DateTime = Read-Host "Enter Date & Time (Tuesday, June 6, 2023 12:05:00 AM)"

	$NewDate = Get-Date -Date $DateTime
	
} ElseIf ($Choice -eq "2") {

	$DateTime = Read-Host "Enter the Number of Days (180)"
	
	$NumberofDays = $DateTime

}

If ($NumberofDays -eq 0 -and $NewDate -is [DateTime]) {

    $UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    $UsrClassDat.LastWriteTime = $NewDate

    $NewUsrClassDate = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"UsrClass.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

    $($NewUsrClassDate)

} ElseIf ($NumberofDays -gt 0 -and $NewDate -isnot [DateTime]) {

    $UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    $NewDate = ($UsrClassDat.LastWriteTime).AddDays(-$NumberofDays)

    $UsrClassDat.LastWriteTime = $NewDate

    $NewUsrClassDate = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force

    Write-Host "`nThe `"LastWriteTime`" Attribute, from the `"UsrClass.dat`" File, which belongs to the `"$($Username)`" User Profile, has been Successfully Updated" -ForegroundColor Green

    $($NewUsrClassDate)

} Else {
    
    Write-Host "`nThe`"UsrClass.dat`" File, belonging to the `"$($Username)`" User Profile, has NOT been Updated, because the `"NewDate`" and/or `"NumberOfDays`" Variables were NOT Correctly Set" -ForegroundColor Red

    $($NewUsrClassDate)

}
