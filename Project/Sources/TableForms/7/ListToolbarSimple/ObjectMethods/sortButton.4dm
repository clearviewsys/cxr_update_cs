Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToView(Current form table:C627); "sortButton")
	: (Form event code:C388=On Clicked:K2:4)
		If (isUserAuthorizedToView(Current form table:C627))
			bSortRecords
		End if 
End case 

