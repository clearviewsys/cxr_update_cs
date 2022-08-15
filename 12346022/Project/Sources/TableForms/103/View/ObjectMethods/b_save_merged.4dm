// this code overwrites the source code of an object or a method to a previous version

C_TEXT:C284(vSourceCode; $revision; $comments)
$revision:=String:C10(arrIDs{arrIDs})
$comments:=arrComments{arrIDs}
If (vMergedCode#"")
	
	myConfirm("Are you sure you want to save the merged source code to revision "+String:C10(arrIDs{arrIDs}); "Replace Method"; "Cancel")
	If (OK=1)
		METHOD SET CODE:C1194([DB_CodeRevisions:103]MethodPath:12; vMergedCode)
		// commit4DMethod
		createDB_CodeRevisionRecord([DB_CodeRevisions:103]MethodName:11; [DB_CodeRevisions:103]MethodPath:12; vSourceCode; "Reverted to revision "+$revision; $comments; [DB_CodeRevisions:103]Story:3)
	End if 
End if 
