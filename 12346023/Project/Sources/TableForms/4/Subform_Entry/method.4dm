If (Form event code:C388=On Double Clicked:K2:5)
	ALERT:C41("clicked")
End if 
If (Form event code:C388=On Display Detail:K2:22)
	colorizeExpiredDate(->[LinkedDocs:4]ExpiryDate:4)
End if 