# DelProf2_Fix
A Solution to the ongoing Issues, affecting the DelProf2 Utility by Helge Klein.

Helge Klein - DelProf2 User Profile Deletion Tool:
https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool/

Microsoft Tech Community - Issue with date modified for NTUSER.DAT:
https://techcommunity.microsoft.com/t5/windows-deployment/issue-with-date-modified-for-ntuser-dat/m-p/102438

The actual Fix is implemented by the “Update-NtUserDat.ps1” Script, which loops through All of the User Profiles on the Computer, on which it is Running and Corrects the Date/Time on the associated “NTUSER.DAT” Files (via the “LastWriteTime” Attribute), by Copying the Date/Time from their “USRCLASS.DAT” File (which is Located in the User’s “C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows” Folder).
