//%attributes = {"shared":true,"publishedSoap":true,"publishedWsdl":true}
// returns the last successful backup date
// this method can be called remotely

C_DATE:C307($0; $lastBackupDate)
READ ONLY:C145([BackupLogs:47])
QUERY:C277([BackupLogs:47]; [BackupLogs:47]Status:4=0)
ORDER BY:C49([BackupLogs:47]; [BackupLogs:47]BackupDate:2; <)
If (Records in selection:C76([BackupLogs:47])>0)
	FIRST RECORD:C50([BackupLogs:47])
	$lastBackupDate:=[BackupLogs:47]BackupDate:2
Else 
	$lastBackupDate:=!00-00-00!
End if 

$0:=$lastBackupDate