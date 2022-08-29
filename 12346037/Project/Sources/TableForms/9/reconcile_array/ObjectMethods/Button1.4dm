If (Form event code:C388#On Clicked:K2:4)  // this is to check if accidentally the enter key was pressed (for example during searching)
	
	CONFIRM:C162("Are you sure you want to save the reconciliations?")
	If (OK=1)
		handleSaveReconcileButton
	Else 
		REJECT:C38
	End if 
End if 
If (Form event code:C388=On Clicked:K2:4)
	handleSaveReconcileButton
End if 