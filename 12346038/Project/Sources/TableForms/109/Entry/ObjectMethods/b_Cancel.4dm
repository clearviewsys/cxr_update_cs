
C_TEXT:C284($msg)
handleCancelButton
If (docModified)
	$msg:=GetLocalizedErrorMessage(4228)  // If you cancel you will lost some changes. Do you want yo quit without saving?
	myConfirm($msg; getLocalizedKeyword("yes"); getLocalizedKeyword("no"))
	
	If (ok=1)
		CANCEL:C270
	End if 
Else 
	
	CANCEL:C270
End if 
