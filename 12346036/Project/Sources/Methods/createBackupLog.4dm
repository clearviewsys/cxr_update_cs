//%attributes = {}
// createBackupLog(status)

CREATE RECORD:C68([BackupLogs:47])
[BackupLogs:47]BackupDate:2:=Current date:C33
[BackupLogs:47]BackupTime:3:=Current time:C178
[BackupLogs:47]Status:4:=$1
SAVE RECORD:C53([BackupLogs:47])
UNLOAD RECORD:C212([BackupLogs:47])

