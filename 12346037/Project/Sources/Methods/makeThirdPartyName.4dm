//%attributes = {}
// makeThirdPartyName

If ([ThirdParties:101]IsCompany:2)
	[Invoices:5]ThirdPartyName:29:=[ThirdParties:101]CompanyName:23
Else 
	If ([ThirdParties:101]OtherName:5#"")
		[Invoices:5]ThirdPartyName:29:=[ThirdParties:101]FirstName:4+" "+[ThirdParties:101]OtherName:5+" "+[ThirdParties:101]LastName:3
	Else 
		[Invoices:5]ThirdPartyName:29:=[ThirdParties:101]FirstName:4+" "+[ThirdParties:101]LastName:3
	End if 
End if 



