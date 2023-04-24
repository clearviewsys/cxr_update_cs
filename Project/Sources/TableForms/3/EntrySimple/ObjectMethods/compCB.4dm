//SET ENTERABLE(CompanyName;Self->)
//If (Self->=False)
//CompanyName:=""
//Else 
//GOTO AREA(CompanyName)
//End if 
If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([Customers:3]isCompany:41)
		GOTO OBJECT:C206([Customers:3]CompanyName:42)
	End if 
	
End if 