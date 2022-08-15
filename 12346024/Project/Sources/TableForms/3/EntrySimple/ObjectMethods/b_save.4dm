C_TEXT:C284(vPictureIDRef; vIDType)
checkInit
validateCustomers

If (checkErrorExist)
	myAlert(checkGetErrorString)
	REJECT:C38
Else 
	If (checkWarningExist)  // if there is a warning
		CONFIRM:C162(checkGetWarningString; "Continue"; "Back to Form")
		If (OK=0)  // user wants to proceed with transfer   ` user pressed cancel transfer
			REJECT:C38
		End if 
	End if 
End if 
