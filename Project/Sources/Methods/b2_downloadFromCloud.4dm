//%attributes = {}
C_COLLECTION:C1488($1; $remoteFiles; $filesToUpload)
C_OBJECT:C1216($oneFile)
C_TEXT:C284($path; $backupDestination; $result)
C_BOOLEAN:C305($ok)

$ok:=b2_authorize_account

If ($ok)
	
	$remoteFiles:=$1
	
	For each ($oneFile; $remoteFiles)
		
		$path:=b2_getLocalDownloadDestination+$oneFile.fileName
		$result:=b2_downloadFileByName($oneFile.fileName; $path; True:C214)  // skip authorization
		
	End for each 
	
End if 

