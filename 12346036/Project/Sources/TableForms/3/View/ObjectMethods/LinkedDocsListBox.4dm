//handleListBoxObjectMethod(Self;Current form table)
//ALERT("here")

If ((Form event code:C388=On Clicked:K2:4))
	displayCustomersLInkedDocs
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	openFormWindow(->[LinkedDocs:4]; "HybridViewPic_File")
End if 