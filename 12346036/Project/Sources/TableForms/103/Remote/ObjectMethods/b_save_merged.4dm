// this code overwrites the source code of an object or a method to a previous version

C_TEXT:C284(vSourceCode; $revision; $comments; $methodName; $methodPath)
$revision:=String:C10(arrId{arrId})
$comments:=arrComments{arrID}
$methodName:=arrMethodName{arrMethodName}
$methodPath:=arrMethodPath{arrMethodPath}
If (vMergedCode#"")
	
	myConfirm("Are you sure you want to save the merged source code to revision "+String:C10(arrID{arrID}); "Replace Method"; "Cancel")
	If (OK=1)
		
		METHOD SET CODE:C1194($methodName; vMergedCode)
		// commit4DMethod
		createDB_CodeRevisionRecord($methodName; $methodPath; vSourceCode; "Copied from remote revision "+$revision; $comments; [DB_CodeRevisions:103]Story:3)
	End if 
End if 
