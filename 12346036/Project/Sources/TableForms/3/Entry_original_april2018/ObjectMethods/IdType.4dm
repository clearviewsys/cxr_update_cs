Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($thirdPartyIdType)
		$thirdPartyIdType:=Substring:C12([Customers:3]PictureID_GovernmentCode:20; 1; 1)
		
		If ($thirdPartyIdType#"E")  // Other
			OBJECT SET ENTERABLE:C238(*; "IdTypeOther"; False:C215)
			[Customers:3]PictureID_Authority:116:=""
		Else 
			OBJECT SET ENTERABLE:C238(*; "IdTypeOther"; True:C214)
			GOTO OBJECT:C206(*; "IdTypeOther")
		End if 
		
End case 
