C_COLLECTION:C1488($remoteFiles)
C_OBJECT:C1216($oneFile)
C_REAL:C285($epoch)
C_LONGINT:C283($mb)

$mb:=1024*1024

$remoteFiles:=b2_ls

If ($remoteFiles=Null:C1517)
	$remoteFiles:=New collection:C1472
End if 

Form:C1466.remoteFiles:=New collection:C1472

For each ($oneFile; $remoteFiles)
	
	$epoch:=0
	
	If ($oneFile.fileInfo#Null:C1517)
		If ($oneFile.fileInfo.src_last_modified_millis#Null:C1517)
			$epoch:=Num:C11($oneFile.fileInfo.src_last_modified_millis)
		End if 
	End if 
	
	Form:C1466.remoteFiles.push(New object:C1471("fileName"; $oneFile.fileName; "dateCreated"; epochToDate($epoch); "fileSize"; Round:C94($oneFile.size/$mb; 2)))
	
End for each 
