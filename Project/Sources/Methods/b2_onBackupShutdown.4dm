//%attributes = {"executedOnServer":true}
C_LONGINT:C283($1; $backupStatus; $newProcID)
C_BOOLEAN:C305($2)
C_TEXT:C284($appVersion; $majorVersion; $lastBackupFilePath; $lastLogFilePath; $backupDestinationFolder; $oneFile; $oneFullPathFile)
C_OBJECT:C1216($backupHistory; $compare)
C_COLLECTION:C1488($filesToUpload)

$backupStatus:=$1

UTIL_Log("b2"; Current method name:C684+" called")

If ($backupStatus=0)
	
	If (Count parameters:C259=2)
		
		// TRACE
		
		UTIL_Log("b2"; "b2 in on backup shutdown started in new process")
		
		$lastBackupFilePath:=Get 4D file:C1418(Last backup file:K5:30)
		
		UTIL_Log("b2"; "last backup file "+$lastBackupFilePath)
		
		$appVersion:=Application version:C493
		$majorVersion:=$appVersion[[1]]+$appVersion[[2]]
		
		If (Num:C11($majorVersion)>17)  // backup.4DSettings is the file since v18
			
			$lastLogFilePath:=backup_getlastBackupLogFile
			
		Else   // old XML file format
			
			$lastLogFilePath:=backup_getLastBackupLogFilev17
			
			UTIL_Log("b2"; "last log file path "+$lastLogFilePath)
			
		End if 
		
		$filesToUpload:=New collection:C1472($lastBackupFilePath; $lastLogFilePath)
		
		UTIL_Log("b2"; "comparing local and remote locations")
		
		$compare:=b2_compare
		
		If ($compare.toUpload#Null:C1517)
			
			UTIL_Log("b2"; "uploading")
			
			$backupDestinationFolder:=backup_getDestinationFolder
			
			For each ($oneFile; $compare.toUpload)
				$oneFullPathFile:=$backupDestinationFolder+$oneFile
				If ($oneFullPathFile#$lastBackupFilePath)
					If ($oneFullPathFile#$lastLogFilePath)
						$filesToUpload.push($oneFullPathFile)
						UTIL_Log("b2"; "file queued "+$oneFullPathFile)
					End if 
				End if 
			End for each 
			
		End if 
		
		CALL WORKER:C1389("b2_worker"; "b2_uploaderWorker"; $filesToUpload)
		
	Else 
		
		$newProcID:=New process:C317(Current method name:C684; 0; "b2_process"; $backupStatus; True:C214)
		
	End if 
	
End if 



If (False:C215)
	//C_LONGINT($1; $backupStatus)
	//C_TEXT($appVersion; $majorVersion; $lastBackupFilePath; $lastLogFilePath; $backupDestinationFolder; $oneFile; $oneFullPathFile)
	//C_OBJECT($backupHistory; $compare)
	//C_COLLECTION($filesToUpload)
	
	//$backupStatus:=$1
	
	//If ($backupStatus=0)
	
	//$lastBackupFilePath:=Get 4D file(Last backup file)
	
	//$appVersion:=Application version
	//$majorVersion:=$appVersion[[1]]+$appVersion[[2]]
	
	//If (Num($majorVersion)>17)  // backup.4DSettings is the file since v18
	
	//// $lastLogFilePath:=backup_getlastBackupLogFile
	
	//Else   // old XML file format
	
	//$lastLogFilePath:=backup_getLastBackupLogFilev17
	
	//End if 
	
	//$filesToUpload:=New collection($lastBackupFilePath; $lastLogFilePath)
	
	
	//$compare:=b2_compare
	
	//If ($compare.toUpload#Null)
	
	//$backupDestinationFolder:=backup_getDestinationFolder
	
	//For each ($oneFile; $compare.toUpload)
	//$oneFullPathFile:=$backupDestinationFolder+$oneFile
	//If ($oneFullPathFile#$lastBackupFilePath)
	//If ($oneFullPathFile#$lastLogFilePath)
	//$filesToUpload.push($oneFullPathFile)
	//End if 
	//End if 
	//End for each 
	
	//End if 
	
	//CALL WORKER("b2_worker"; "b2_uploaderWorker"; $filesToUpload)
	
	//End if 
End if 
