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
		OBJECT SET TITLE:C194(*; "l_companyname"; "Company Name")
		FORM GOTO PAGE:C247(2)  // company page
		POST OUTSIDE CALL:C329(Current process:C322)  // refresh
	Else 
		GOTO OBJECT:C206([Customers:3]Salutation:2)
		[Customers:3]isWholesaler:87:=False:C215
		[Customers:3]isMSB:85:=False:C215
		OBJECT SET TITLE:C194(*; "l_companyname"; "Employer Name")
		FORM GOTO PAGE:C247(1)
	End if 
	//colourizeField (->[Customers]CompanyName;[Customers]isCompany)
	//colourizeField (->[Customers]FirstName;Not(isCompany))
	//colourizeField (->[Customers]LastName;Not(isCompany))
	validateCustomers
End if 

