# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.3#erroractionpreference
$ErrorActionPreference = "SilentlyContinue"

# C:\Users folder
$Path = "$env:systemdrive\Users"

# Exclude user folders
$ExcludedUsers = @('Default', 'Public', 'Administrator')

$UserFolders = $Path | Get-ChildItem -Directory -Exclude $ExcludedUsers

# Check each user profile folder and update the NTUSER.dat date modified time if it's different from UsrClass.dat
ForEach ($UserFolder in $UserFolders)
{
   $Username = $UserFolder.Name
   # Do not proceed unless both NTUSER.DAT and UsrClass.dat exist
   if ((Test-Path "$Path\$Username\NTUSER.DAT") -and (Test-Path "$Path\$Username\AppData\Local\Microsoft\Windows\UsrClass.dat"))
   {
      # Get Last Modified time for the NTUSER.DAT file
      $NTUSERDat = Get-Item "$Path\$Username\NTUSER.DAT" -Force
      $NTUSERDatLastModified = $NTUSERDat.LastWriteTime
      Write-Host "$Username - NTUSER.DAT Last Modified: $NTUSERDatLastModified"
      
      # Get Last Modified time for the UsrClass.dat file
      $UsrClassDat = Get-Item "$Path\$Username\AppData\Local\Microsoft\Windows\UsrClass.dat" -force
      $UsrClassDatLastModified = $UsrClassDat.LastWriteTime
      Write-Host "$Username - UsrClass.dat Last Modified: $UsrClassDatLastModified"
      
      # Set the NTUSER.DAT Last Modified time to the same time as the UsrClass.dat file
      if ($NTUSERDatLastModified -ne $UsrClassDatLastModified)
      {
         $NTUSERDat.LastWriteTime = $UsrClassDatLastModified
         Write-Host "$Username - NTUSER.dat Last Modified date updated to match UsrClass.dat"
      }
      else
      {
         Write-Host "$Username - NTUSER.dat Last Modified date already matches UsrClass.dat"
      }
      
      $NTUSERDat = $null
      $UsrClassDat = $null
      Write-Host ""
   }
}