//%attributes = {}
C_COLLECTION:C1488($localFiles; $localDownloadedFiles)
C_OBJECT:C1216($oneFile)
C_LONGINT:C283($mb)

$mb:=1024*1024  // candidate for key value?

$localFiles:=b2_getLocalFileList

If ($localFiles=Null:C1517)
	$localFiles:=New collection:C1472
End if 

Form:C1466.localFiles:=New collection:C1472

For each ($oneFile; $localFiles)
	Form:C1466.localFiles.push(New object:C1471("fileName"; $oneFile.fullName; "dateCreated"; $oneFile.creationDate; "fileSize"; \
		Round:C94($oneFile.size/$mb; 2); "localPath"; "backup_folder"; "style"; Normal:K14:15))
End for each 

$localDownloadedFiles:=b2_getLocalDownloadedFilelist

For each ($oneFile; $localDownloadedFiles)
	Form:C1466.localFiles.push(New object:C1471("fileName"; $oneFile.fullName; "dateCreated"; $oneFile.creationDate; "fileSize"; \
		Round:C94($oneFile.size/$mb; 2); "localPath"; "b2_downloads"; "style"; Italic:K14:3))
End for each 

Form:C1466.localFiles:=Form:C1466.localFiles.orderBy("fileName asc")
