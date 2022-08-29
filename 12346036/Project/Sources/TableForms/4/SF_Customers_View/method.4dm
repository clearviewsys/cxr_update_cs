
If (Form event code:C388=On Display Detail:K2:22)
	stampText("stamp_isIDExpired"; " Document Expired ✖"; "red"; isDateExpired([LinkedDocs:4]ExpiryDate:4))
	
End if 