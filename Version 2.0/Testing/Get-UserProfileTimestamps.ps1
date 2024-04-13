$profilelist = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
$Accounts = @()

foreach ($p in $profilelist) {
    try {
        $objUser = (New-Object System.Security.Principal.SecurityIdentifier($p.PSChildName)).Translate([System.Security.Principal.NTAccount]).value
    } catch {
        $objUser = "[UNKNOWN]"
    }

    Remove-Variable -Force LTH,LTL,UTH,UTL -ErrorAction SilentlyContinue
    $LTH = '{0:X8}' -f (Get-ItemProperty -Path $p.PSPath -Name LocalProfileLoadTimeHigh -ErrorAction SilentlyContinue).LocalProfileLoadTimeHigh
    $LTL = '{0:X8}' -f (Get-ItemProperty -Path $p.PSPath -Name LocalProfileLoadTimeLow -ErrorAction SilentlyContinue).LocalProfileLoadTimeLow
    $UTH = '{0:X8}' -f (Get-ItemProperty -Path $p.PSPath -Name LocalProfileUnloadTimeHigh -ErrorAction SilentlyContinue).LocalProfileUnloadTimeHigh
    $UTL = '{0:X8}' -f (Get-ItemProperty -Path $p.PSPath -Name LocalProfileUnloadTimeLow -ErrorAction SilentlyContinue).LocalProfileUnloadTimeLow

    $LoadTime = if ($LTH -and $LTL) {
        [datetime]::FromFileTime("0x$LTH$LTL")
    } else {
        $null
    }
    $UnloadTime = if ($UTH -and $UTL) {
        [datetime]::FromFileTime("0x$UTH$UTL")
    } else {
        $null
    }
    $HashTable = [pscustomobject][ordered]@{
        User = $objUser
        SID = $p.PSChildName
        Logintime = $LoadTime
        LogoutTime = $UnloadTime
    }
    $Accounts += $HashTable
}

$Accounts | Where-Object {$_.User -notlike "NT AUTHORITY\*"} | Format-List