C_LONGINT:C283($1; $backupStatus)

$backupStatus:=$1
<<<<<<< HEAD

createBackupLog($backupStatus)
=======
>>>>>>> b2_integration

createBackupLog($backupStatus)

If ($backupStatus#0)
	sendEmailForBackupFailure
End if 

SP_start  //make sure this is running

// Execute only in development environment. 

If (isDevelopmentEnv)
	
	// Export Keywords
	OnBackupExports
	
	// no need for this, we are in Project mode now using GitHub @milan 07/18/22
	// exportDB_SourceCodes
	
	
End if 

If (getKeyValue("b2.syncBackups")="true")
	b2_onBackupShutdown($backupStatus)
End if 

If (getKeyValue("b2.syncBackups")="true")
	//b2_onBackupShutdown($1)
End if 
