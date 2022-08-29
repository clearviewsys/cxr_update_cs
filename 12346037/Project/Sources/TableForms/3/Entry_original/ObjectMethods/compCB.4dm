//SET ENTERABLE(CompanyName;Self->)
//If (Self->=False)
//CompanyName:=""
//Else 
//GOTO AREA(CompanyName)
//End if 
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([Customers:3]isCompany:41)
		//GOTO OBJECT([Customers]BusinessType)
		GOTO OBJECT:C206([Customers:3]CompanyName:42)
		
	Else 
		GOTO OBJECT:C206([Customers:3]FirstName:3)
		[Customers:3]isWholesaler:87:=False:C215
		[Customers:3]isMSB:85:=False:C215
	End if 
	//colourizeField (->[Customers]CompanyName;[Customers]isCompany)
	//colourizeField (->[Customers]FirstName;Not(isCompany))
	//colourizeField (->[Customers]LastName;Not(isCompany))
End if 

