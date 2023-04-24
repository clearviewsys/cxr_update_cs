//%attributes = {}
C_TEXT:C284($0)
C_COLLECTION:C1488($backupHistory)
C_OBJECT:C1216($lastBackup)

$backupHistory:=backup_getHistory

If ($backupHistory.length>0)
	
	$backupHistory:=$backupHistory.orderBy("backupNumber desc")
	
	$lastBackup:=$backupHistory[0]
	
	$0:=$lastBackup.logPath
	
End if 
