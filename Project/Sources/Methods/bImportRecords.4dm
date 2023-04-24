//%attributes = {"publishedWeb":true}
Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToImport(Current form table:C627); "importButton")
	: (Form event code:C388=On Clicked:K2:4)
		If (isUserAuthorizedToImport(Current form table:C627))
			executeMethodName("import"+Table name:C256(Current form table:C627))
		Else 
			myAlert("Sorry, you are not authorized to import data into this table.")
		End if 
End case 
