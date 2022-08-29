//%attributes = {}
//Method to delete all historical password records in the system
If (isUserDesigner)
	myConfirm("You are about to delete all historical records of past passwords. This will allow passwords to be re-used moving forward. Are you sure you would like to continue?")
	
	If (OK=1)
		READ WRITE:C146([UserPasswords:145])
		ALL RECORDS:C47([UserPasswords:145])
		While (Not:C34(End selection:C36([UserPasswords:145])))
			DELETE RECORD:C58([UserPasswords:145])
			NEXT RECORD:C51([UserPasswords:145])
		End while 
		myAlert("Historical passwords deleted.")
	Else 
		myAlert("Transaction cancelled.")
	End if 
Else 
	myalert_designerOnly
End if 