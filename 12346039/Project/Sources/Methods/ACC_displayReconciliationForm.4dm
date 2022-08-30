//%attributes = {}
// ACC_displayReconciliationForm({accountName})

C_TEXT:C284($1; $accountName)

Case of 
	: (Count parameters:C259=1)
		$accountName:=$1
		READ ONLY:C145([Accounts:9])
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountName)
End case 

If (Records in selection:C76([Accounts:9])=1)
	If (isUserAllowedToReconcile)
		openFormWindow(->[Accounts:9]; "reconcile_array")
	Else 
		myAlert("Sorry, you are not authorized to reconcile accounts.")
	End if 
End if 
