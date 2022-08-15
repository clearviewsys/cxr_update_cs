If (Form event code:C388=On Load:K2:1)
	[Customers:3]isDocumentsVerified:109:=False:C215  // when we open the form this shouldn't be checked
	[Customers:3]DocumentsVerifiedBy:110:=""  // 
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([Customers:3]isDocumentsVerified:109=True:C214)
		[Customers:3]DocumentsVerifiedBy:110:=getApplicationUser
	Else 
		[Customers:3]DocumentsVerifiedBy:110:=""
	End if 
	
End if 

