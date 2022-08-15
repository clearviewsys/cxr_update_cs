applyFocusRect
myConfirm("Do you want to cancel? All changes will be lost!"; "Don't Cancel"; "Cancel!")
If (ok=0)
	CANCEL:C270
Else 
	REJECT:C38
End if 
