Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();

$Username = Read-Host "Enter Username"
$LDT = Read-Host "Enter Login Date & Time (Monday, January 1, 2024 12:01:01 AM)"
$NewLoadDateTime = Get-Date -Date $LDT
$UDT = Read-Host "Enter Logout Date & Time (Tuesday, January 2, 2024 11:59:59 PM)"
$NewUnloadDateTime = Get-Date -Date $UDT


$profilelist = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

foreach ($p in $profilelist) {
    $UserProfile = (Get-ItemProperty "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($p.PSChildName)" -Name ProfileImagePath).ProfileImagePath
    If ($UserProfile -eq "C:\Users\$($Username)") {
        try {
            $objUser = (New-Object System.Security.Principal.SecurityIdentifier($p.PSChildName)).Translate([System.Security.Principal.NTAccount]).value 
        } catch {
            $objUser = "[UNKNOWN]"
        }

        If ($NewLoadDateTime -is [DateTime]) {

            $LoadDateTime = $($NewLoadDateTime).ToFileTime()
            $LoadHex = '{0:X16}' -f $LoadDateTime
            $LoadHex1 = $LoadHex.Substring(0,8)
            $LoadInt1 = [uint32]"0x$($LoadHex1)"
            $LoadHex2 = $LoadHex.Substring(8,8)
            $LoadInt2 = [uint32]"0x$($LoadHex2)"
            

            Set-ItemProperty -Path "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($p.PSChildName)" -Name LocalProfileLoadTimeHigh -Type dword -Value $LoadInt1
            Set-ItemProperty -Path "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($p.PSChildName)" -Name LocalProfileLoadTimeLow -Type dword -Value $LoadInt2
        }

        If ($NewUnloadDateTime -is [DateTime]) {

            $UnloadDateTime = $($NewUnloadDateTime).ToFileTime()
            $UnloadHex = '{0:X16}' -f $UnloadDateTime
            $UnloadHex1 = $UnloadHex.Substring(0,8)
            $UnloadInt1 = [uint32]"0x$($UnloadHex1)"
            $UnloadHex2 = $UnloadHex.Substring(8,8)
            $UnloadInt2 = [uint32]"0x$($UnloadHex2)"

            Set-ItemProperty -Path "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($p.PSChildName)" -Name LocalProfileUnloadTimeHigh -Type dword -Value $UnloadInt1
            Set-ItemProperty -Path "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($p.PSChildName)" -Name LocalProfileUnloadTimeLow -Type dword -Value $UnloadInt2

        }

    }

}