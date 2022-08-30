C_LONGINT:C283($1; $backupStatus)

$backupStatus:=$1

createBackupLog($backupStatus)

If ($1#0)
	sendEmailForBackupFailure
End if 

SP_start  //make sure this is running

// Execute only in development environment. 

If (isDevelopmentEnv)
	
	// Export Keywords
	OnBackupExports
	
	exportDB_SourceCodes
End if 

If ($backupStatus=0)
	// run backblaze upload
	
End if 
