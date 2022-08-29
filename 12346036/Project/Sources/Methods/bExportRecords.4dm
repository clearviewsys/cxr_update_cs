//%attributes = {"publishedWeb":true}
Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToExport(Current form table:C627); "exportButton")
	: (Form event code:C388=On Clicked:K2:4)
		If (isUserAuthorizedToExport(Current form table:C627))
			executeMethodName("export"+Table name:C256(Current form table:C627))
		Else 
			myAlert("Sorry, you are not authorized to export data from this table.")
		End if 
End case 