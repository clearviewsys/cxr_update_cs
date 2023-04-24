//%attributes = {"publishedWeb":true}
Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToModify(Current form table:C627); "ChangeButton")
	: (Form event code:C388=On Clicked:K2:4)
		modifyRecordClicked(Current form table:C627; Record number:C243(Current form table:C627->))
End case 