If (isUserAuthorizedToModify(->[Cheques:1]))
	handleClearChequesButton
Else 
	myAlert("Sorry, you are not authorized to clear any cheques.")
End if 