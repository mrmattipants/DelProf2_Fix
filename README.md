# **DelProf2_Fix**<br>
A Solution to the ongoing Issues, affecting the DelProf2 Utility by Helge Klein.

**Helge Klein - DelProf2 User Profile Deletion Tool:**<br>
https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool/

**Microsoft Tech Community - Issue with date modified for NTUSER.DAT:**<br>
https://techcommunity.microsoft.com/t5/windows-deployment/issue-with-date-modified-for-ntuser-dat/m-p/102438

The actual Fix is implemented by the “**Update-NtUserDat.ps1**” Script, which loops through All of the User Profiles on the Computer, on which it is Running and Corrects the Date/Time on the associated “**NTUSER.DAT**” Files (via the “**LastWriteTime**” Attribute), by Copying the Date/Time from their “**USRCLASS.DAT**” File (which is Located in the User’s “**C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows**” Folder).

# <ins>Script:</ins>

- **DelProf2.exe**<br>
  - This is the same “**DelProf2.exe**” version that can be downloaded from the official website.

- **Update-NtUserDat.ps1**<br>
  - The “**Update-NtUserDat.ps1**” contains the actual fix, as it Corrects the Date/Time on the User’s “**NTUSER.DAT**” File (via the “**LastWriteTime**” Attribute), by Copying the Date/Time from their “**USRCLASS.DAT**” File.

- **Run_DelProf2_Script.bat**<br>
  - The “**Run_DelProf2_Script.bat**” Script Runs the “**Update-NtUserDat.ps1**” (containing the Fix), before Running the “**DelProf2.exe**” Tool, to Cleanup the Old/Outdated User Accounts (currently Set to Delete Profiles Older than 90 Days).

- **Run_DelProf2_Script.vbs**<br>
  - The “**Run_DelProf2_Script.vbs**” Script simply Runs the “**Run_DelProf2_Script.bat**” Script, Silently (without displaying any Command Line Windows, etc.).

# <ins>Testing:</ins>

- **DelProf2.exe**<br>
  - This is the same “**DelProf2.exe**” version that can be downloaded from the official website.

- **Set-NewDateOnUsrClassDat.ps1**<br>
  - The “**Set-NewDateOnUsrClassDat.ps1**” can be used to Change the Date/Time on the “**USRCLASS.DAT**” File, belonging to a specific User Profile. The Script will Prompt for the “**Username**” and “**Date & Time**” (or “**Number of Days**” to Subtract from the existing Date/Time).

- **Set-NewDateOnUsrClassDat.bat**<br>
  - The “**Set-NewDateOnUsrClassDat.bat**” Script simply Runs the “**Set-NewDateOnUsrClassDat.ps1**” Script, with the necessary Parameters & Privileges, etc.

- **Set-TodaysDateOnNtUserDat.ps1**<br>
  - The "**Set-TodaysDateOnNtUserDat.ps1**" Script can be used to Set the Date/Time on a User's "**NTUSER.DAT**" File, to the Current Date/Time.

- **Set-TodaysDateOnNtUserDat.bat**<br>
  - The “**Set-TodaysDateOnNtUserDat.ps1**” Script simply Runs the “**Set-TodaysDateOnNtUserDat.ps1**” Script, with the necessary Parameters & Privileges, etc.

- **Update-NtUserDat.ps1**<br>
  - This is the same “**Update-NtUserDat.ps1**” Script, that is in the “**Script**” Directory, which contains the actual “**DelProf2**” Fix.

- **Test_DelProf2_Script.bat**<br>
  - The “**Test_DelProf2_Script.bat**” Script Runs the “**Update-NtUserDat.ps1**” (containing the Fix), before Running the “**DelProf2.exe**” Tool, in “**List Only, Do Not Delete**” aka “**What-If**“ Mode (Listing Old/Outdated Profiles without Deleting them).
 
# <ins>Deployment - Group Policy:</ins>

Create your GPO and Add a "**Startup Script**" Policy, in the following Location.
**Computer Configuration > Policies > Windows Settings > Scripts > Startup**

<img src="https://i.imgur.com/mUmHEHj.png">

Under the "**Startup Properties**", Click on the "**Show Files**" Button.

<img src="https://i.imgur.com/f7b2Z4r.png">

Copy the following Four Script Files from DelProf2_Fix "**Scripts**" Folder to your "**Startup Script**" Policy Folder.

- **DelProf2.exe**
- **Update-NtUserDat.ps1**
- **Run_DelProf2_Script.bat**
- **Run_DelProf2_Script.vbs**

<img src="https://i.imgur.com/EkyagyP.png">

Return to the "**Startup Properties**" and Add the "**Run_DelProf2_Script.vbs**" Script to the Listbox, under the "**Scripts**" Tab.

<img src="https://i.imgur.com/HLxDBA4.png">

You can now Close the Group Policy Configuration and Review your Group Policy, from the "**Settings**" Tab, of the Group Policy Management Preview Window.

<img src="https://i.imgur.com/w3vfsr8.png">

