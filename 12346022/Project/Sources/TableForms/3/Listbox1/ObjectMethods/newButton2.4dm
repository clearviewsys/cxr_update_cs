
If (isUserAuthorizedToModify(->[Customers:3]))
	modifyRecordTable(->[Customers:3]; "Review")
Else 
	myAlert("Sorry, you are not authorized to edit customer's profiles.")
End if 