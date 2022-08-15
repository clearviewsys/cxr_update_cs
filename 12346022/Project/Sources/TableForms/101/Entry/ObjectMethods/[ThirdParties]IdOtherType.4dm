C_TEXT:C284($thirdPartyIdType)
Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		$thirdPartyIdType:=Substring:C12([ThirdParties:101]IdType:14; 1; 1)
		
		If ($thirdPartyIdType#"E")  // Other
			OBJECT SET ENTERABLE:C238(*; "ThirdPartyIdOtherType"; False:C215)
			[ThirdParties:101]IdOtherType:15:=""
		Else 
			OBJECT SET ENTERABLE:C238(*; "ThirdPartyIdOtherType"; True:C214)
			GOTO OBJECT:C206(*; "ThirdPartyIdOtherType")
		End if 
		
End case 
