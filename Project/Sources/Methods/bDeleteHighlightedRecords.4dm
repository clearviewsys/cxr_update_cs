//%attributes = {}


Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToDelete(Current form table:C627); "deleteButton")
	: (Form event code:C388=On Clicked:K2:4)
		deleteHighlightedRecords(Current form table:C627)
End case 