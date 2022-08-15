//%attributes = {}
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		[WireTemplates:42]BeneficiaryFullName:9:=FJ_Trim(toTitleCase(->[WireTemplates:42]BeneficiaryFirstName:40))+" "+FJ_Trim(toTitleCase(->[WireTemplates:42]BeneficiaryLastName:41))
		
		
End case 