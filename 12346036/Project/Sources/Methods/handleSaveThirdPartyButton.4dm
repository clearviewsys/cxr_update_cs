//%attributes = {}
If ([ThirdParties:101]ThirdPartiesID:31="")
	[ThirdParties:101]ThirdPartiesID:31:=makeThirdPartiesID
End if 

If (Not:C34(Undefined:C82(vInvoiceNumber)))
	[ThirdParties:101]InvoiceID:30:=vInvoiceNumber
End if 

If ([ThirdParties:101]IsCompany:2)
	[Invoices:5]ThirdPartyName:29:=[ThirdParties:101]CompanyName:23
Else 
	[Invoices:5]ThirdPartyName:29:=makeFullName([ThirdParties:101]FirstName:4; [ThirdParties:101]LastName:3)
End if 

handleSaveButton

