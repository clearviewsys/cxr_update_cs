
If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([WireTemplates:42]BeneficiaryIsCompany:39)
		[WireTemplates:42]BeneficiaryFirstName:40:=""
		[WireTemplates:42]BeneficiaryLastName:41:=""
		
		GOTO OBJECT:C206([WireTemplates:42]BeneficiaryFullName:9)
		POST OUTSIDE CALL:C329(Current process:C322)  // refresh
	Else 
		[WireTemplates:42]BeneficiaryFullName:9:=""
		GOTO OBJECT:C206([WireTemplates:42]BeneficiaryFirstName:40)
		POST OUTSIDE CALL:C329(Current process:C322)  // refresh
	End if 
End if 

