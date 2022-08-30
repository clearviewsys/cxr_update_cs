If (isUserDesigner)
	deleteAllUserPasswords
	myAlert("Historical user passwords have been deleted.")
Else 
	myalert_designerOnly
End if 