//%attributes = {}
// OnBackupExports
// Exports all the neccessary tables after executing a backup
// Must BE EXECUTED ON SERVER

C_BLOB:C604($exportParams)
C_TEXT:C284($resourceFolder; $fileName; $exportParamsFileName; $resourcesFolder)

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12


If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

If (isDevelopmentEnv)
	
	exportDB_KeywordsOnBackup
	exportDenominationsOnBackup
	
End if 
