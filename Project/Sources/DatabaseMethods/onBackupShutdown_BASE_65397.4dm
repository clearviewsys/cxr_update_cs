C_LONGINT:C283($1)

createBackupLog($1)

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

