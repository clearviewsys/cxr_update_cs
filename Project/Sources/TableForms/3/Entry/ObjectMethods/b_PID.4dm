If (Form event code:C388=On Load:K2:1)
	// check if the license is valid
	If (getKeyValue("BisN.isActive"; "Inactive")="active")
		OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
	End if 
	
End if 
C_BOOLEAN:C305($success)
If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]SIN_No:14="")
		myAlert("This service uses Bisnode Consumer API and requires a valid person ID. \nFor example, ensure the key values for BisN.country is 'SE' and BisN.environment is 'test'. Use the person ID '200001061304' for testing.")
	Else 
		C_OBJECT:C1216($personObj)
		$success:=BisN_getCustomerInfoUsingPID([Customers:3]SIN_No:14; ->$personObj)
		If ($success=True:C214)
			[Customers:3]FirstName:3:=$personObj.firstName
			[Customers:3]LastName:4:=$personObj.familyName
			[Customers:3]DOB:5:=Date:C102($personObj.dateOfBirth)
			[Customers:3]HomeTel:6:=$personObj.homePhone
			[Customers:3]CellPhone:13:=$personObj.cellPhone
			[Customers:3]Address:7:=$personObj.formattedAddress
			[Customers:3]CountryCode:113:=$personObj.country
			[Customers:3]City:8:=$personObj.city
			[Customers:3]PostalCode:10:=$personObj.postalCode
		End if 
	End if 
	
End if 

//[Customers]HomeTel
//[Customers]CellPhone
//[Customers]WorkTel
