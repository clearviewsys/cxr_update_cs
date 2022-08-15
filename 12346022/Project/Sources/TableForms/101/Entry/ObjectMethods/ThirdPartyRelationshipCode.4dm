C_TEXT:C284($thirdPartyOtherRelationship)

Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		$thirdPartyOtherRelationship:=Substring:C12([ThirdParties:101]RelationshipCode:21; 1; 1)
		
		If ($thirdPartyOtherRelationship#"J")
			OBJECT SET ENTERABLE:C238(*; "ThirdPartyOtherRelationship"; False:C215)
			[ThirdParties:101]OtherRelationship:22:=""
		Else 
			OBJECT SET ENTERABLE:C238(*; "ThirdPartyOtherRelationship"; True:C214)
			GOTO OBJECT:C206(*; "ThirdPartyOtherRelationship")
		End if 
		
End case 
