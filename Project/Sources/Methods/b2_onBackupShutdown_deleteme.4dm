//%attributes = {}
//C_LONGINT($1; $backupStatus)
//C_TEXT($appVersion; $majorVersion; $lastBackupFilePath; $lastLogFilePath; $backupDestinationFolder; $oneFile; $oneFullPathFile)
//C_OBJECT($backupHistory; $compare)
//C_COLLECTION($filesToUpload)

//$backupStatus:=$1

//If ($backupStatus=0)

//// TRACE

//UTIL_Log("b2"; "b2 in on backup shutdown started")

//$lastBackupFilePath:=Get 4D file(Last backup file)

//UTIL_Log("b2"; "last backup file "+$lastBackupFilePath)

//$appVersion:=Application version
//$majorVersion:=$appVersion[[1]]+$appVersion[[2]]

//If (Num($majorVersion)>17)  // backup.4DSettings is the file since v18

//// $lastLogFilePath:=backup_getlastBackupLogFile

//Else   // old XML file format

//$lastLogFilePath:=backup_getLastBackupLogFilev17

//UTIL_Log("b2"; "last log file path "+$lastLogFilePath)

//End if 

//$filesToUpload:=New collection($lastBackupFilePath; $lastLogFilePath)

//UTIL_Log("b2"; "comparing local and remote locations")

//$compare:=b2_compare

//If ($compare.toUpload#Null)

//UTIL_Log("b2"; "uploading")

//$backupDestinationFolder:=backup_getDestinationFolder

//For each ($oneFile; $compare.toUpload)
//$oneFullPathFile:=$backupDestinationFolder+$oneFile
//If ($oneFullPathFile#$lastBackupFilePath)
//If ($oneFullPathFile#$lastLogFilePath)
//$filesToUpload.push($oneFullPathFile)
//UTIL_Log("b2"; "file queued "+$oneFullPathFile)
//End if 
//End if 
//End for each 

//End if 

//CALL WORKER("b2_worker"; "b2_uploaderWorker"; $filesToUpload)

//End if 
