# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.3#erroractionpreference
$ErrorActionPreference = "SilentlyContinue"

# C:\Users folder
$Path = "$env:systemdrive\Users"

# Exclude user folders
$ExcludedUsers = @('Default', 'Public', 'Administrator')

$UserProfiles = $Path | Get-ChildItem -Directory -Exclude $ExcludedUsers

$RegProfiles = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList\*"

# Check each user profile folder and update the NTUSER.dat date modified time if it's different from UsrClass.dat
ForEach ($UserProfile in $UserProfiles)
{
   $Username = $UserProfile.Name
   $NTUserDatFile = "$($UserProfile.FullName)\NTUSER.DAT"
   # Do not proceed unless both NTUSER.DAT and UsrClass.dat exist
   if ((Test-Path $NTUserDatFile))
   {
      # Get Last Modified time for the NTUSER.DAT file
      $NTUSERDat = Get-Item $NTUserDatFile -Force
      $NTUSERDatLastModified = $NTUSERDat.LastWriteTime
      Write-Host `n"$Username - NTUSER.DAT Last Modified: $NTUSERDatLastModified"
      
      # Get "LocalProfileLoadTimeHigh" and "LocalProfileLoadTimeLow" Registry Values
      $RegProfile = $RegProfiles | Where-Object { $_.ProfileImagePath -eq $UserProfile.FullName }
      $ProfileLoadHighDec = $RegProfile.LocalProfileLoadTimeHigh
      $ProfileLoadLowDec = $RegProfile.LocalProfileLoadTimeLow

      # Convert Decimal to Hex string, Example:  ProfileLoadHighHex = 01d8fd57 / ProfileLoadLowHex = 86b1d3bc
      $ProfileLoadHighHex = [System.Convert]::ToString($ProfileLoadHighDec,16)   
      $ProfileLoadLowHex = [System.Convert]::ToString($ProfileLoadLowDec,16)
      
      # Concatenate hex strings, Example: 01d8fd5786b1d3bc
      $ProfileHexJoined = -join ($ProfileLoadHighHex,$ProfileLoadLowHex)
      
      # Convert to DateTime format, Example: 11/21/2022 03:15:37
      $TimestampInt = [Convert]::ToInt64($ProfileHexJoined,16)
      $ProfileLoadTime = [DateTime]::FromFileTime($TimestampInt)
      
      # Set the NTUSER.DAT Last Modified time to the same time as the Profile Load Time
      if ($NTUSERDatLastModified -ne $ProfileLoadTime)
      {
         $NTUSERDat.LastWriteTime = $ProfileLoadTime
         Write-Host "$($Username) - NTUSER.dat Last Modified date updated to match Profile Load Time: $($ProfileLoadTime)" -ForegroundColor Green
      }
      else
      {
         Write-Host "$($Username) - NTUSER.dat Last Modified date already matches Profile Load Time: $($NTUSERDatLastModified)" -ForegroundColor Yellow
      }
      
      Remove all iteration data as to not corrupt datastream
      $Vars = @('Username','NTUserDatFile','NTUSERDat','NTUSERDatLastModified','RegProfile','ProfileLoadHighDec','ProfileLoadLowDec','ProfileLoadHighHex','ProfileLoadLowHex','ProfileHexJoined','TimestampInt','ProfileLoadTime') 
      $Var | ForEach-Object { Remove-Variable $_ -ErrorAction SilentlyContinue }

   }
}