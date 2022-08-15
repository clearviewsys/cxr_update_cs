//%attributes = {}
//do cleanup after deletions

C_TEXT:C284($path; $posixPath)
C_OBJECT:C1216($fileForDeletion)
If ([LinkedDocs:4]filePath:26#"")
	$path:=WAPI_uploadsFolder+[LinkedDocs:4]filePath:26
	$posixPath:=Convert path system to POSIX:C1106($path)
	$fileForDeletion:=File:C1566($posixPath)
	If ($fileForDeletion.exists)
		$fileForDeletion.delete()
	End if 
End if 