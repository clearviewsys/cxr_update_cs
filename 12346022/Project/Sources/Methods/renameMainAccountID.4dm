//%attributes = {}
C_TEXT:C284($mainaccountID; $1)

$mainaccountID:=$1

If (isUserManager)
	If ($mainaccountID#"")
		renameMainAccountInAccounts($mainaccountID)
	End if 
Else 
	myAlert("Only managers are allowed to rename a parent account")
End if 