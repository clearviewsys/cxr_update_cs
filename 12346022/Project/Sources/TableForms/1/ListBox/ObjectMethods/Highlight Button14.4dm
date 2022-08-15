If (isUserAuthorizedToModify(->[Cheques:1]))
	handleClearChequesButton("$cheques_LBSet")
Else 
	myAlert("Sorry, you are not authorized to clear any cheques.")
End if 