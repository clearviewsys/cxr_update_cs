//%attributes = {}
C_DATE:C307($lastBackupDate; $today; $nextBackupDate; $nextBackupTime)
C_TIME:C306($lastBackupTime; $now)

checkInit

If (Application type:C494=4D Server:K5:6)  // Modified by: Barclay (1/31/2012)
	//don't display on server
Else 
	$today:=Current date:C33
	$now:=Current time:C178
	
	GET BACKUP INFORMATION:C888(0; $lastBackupDate; $lastBackupTime)  // get last backup date and time
	If (Abs:C99($lastBackupDate-$today)>1)
		checkAddWarning("Backup was not done for more than a day. Your last backup was on "+String:C10($lastBackupDate)+" at "+String:C10($lastbackuptime))
		checkAddWarningIf(Not:C34(isUserAdministrator); "Please inform your system admin to backup soon!")
	End if 
	
	If (checkWarningExist & isUserAdministrator)
		//backupNow 
	End if 
End if 