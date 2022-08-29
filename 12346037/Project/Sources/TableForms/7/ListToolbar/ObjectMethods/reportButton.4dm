Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToPrint(Current form table:C627); "reportButton")
	: (Form event code:C388=On Clicked:K2:4)
		If (isUserAuthorizedToPrint(Current form table:C627))
			bQuickReport
		End if 
End case 