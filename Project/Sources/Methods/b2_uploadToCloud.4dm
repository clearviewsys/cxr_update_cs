//%attributes = {"executedOnServer":true}
// EOS property is set
// uploads selected file from 4D Client B2 Cloud interface

C_COLLECTION:C1488($1; $localFiles; $filesToUpload)
C_OBJECT:C1216($selected)
C_TEXT:C284($path; $backupDestination)


$localFiles:=$1

$backupDestination:=backup_getDestinationFolder

$filesToUpload:=New collection:C1472

For each ($selected; $localFiles)
	If ($selected.localPath#"backup_folder")
		$path:=b2_getLocalDownloadDestination+$selected.fileName
	Else 
		$path:=$backupDestination+$selected.fileName
	End if 
	$filesToUpload.push($path)
End for each 

CALL WORKER:C1389("b2_worker"; "b2_uploaderWorker"; $filesToUpload)
