myConfirm("Do you want to cancel? All Changes will be lost!"; "Don't Cancel"; "Cancel!")
If (OK=0)
	CANCEL:C270
Else 
	REJECT:C38
End if 
