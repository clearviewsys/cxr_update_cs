//%attributes = {"executedOnServer":true}
// Finds the file asscoiated to the webAttachment being deleted, and deletes it from the WebDocuments folder in CXR @viktor

C_TEXT:C284($path; $posixPath)
C_OBJECT:C1216($fileForDeletion)
$path:=WAPI_uploadsFolder+[WebAttachments:86]FilePath:3
$posixPath:=Convert path system to POSIX:C1106($path)
$fileForDeletion:=File:C1566($posixPath)
If ($fileForDeletion.exists)
	$fileForDeletion.delete()
End if 