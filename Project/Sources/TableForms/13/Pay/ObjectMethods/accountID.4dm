
C_OBJECT:C1216($entity)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (getKeyValue("ewire.accountid.useSelect"; "true")="true")
			
			If (INV_vNextAccountID#"")
				[eWires:13]AccountID:30:=INV_vNextAccountID
				
				If ([eWires:13]AccountID:30#"")
					$entity:=ds:C1482.Accounts.query("AccountID == :1"; INV_vNextAccountID)
					If ($entity.length>0)
						[eWires:13]toCountryCode:112:=$entity.first().CountryCode
						[eWires:13]toCountry:10:=getCountryNameByCode([eWires:13]toCountryCode:112)
						[eWires:13]AgentID:26:=$entity.first().AgentID
					End if 
					
				End if 
			End if 
			
			
			$entity:=ds:C1482.Accounts.query("isForeignAccount == :1"; True:C214)
			
			If ($entity.length>0)  //Records in selection([Accounts])>0)  // there is a list to pick from
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
				orderByAccountNames
				
				COLLECTION TO ARRAY:C1562($entity.toCollection("AccountID"); Self:C308->; "AccountID")
				//SELECTION TO ARRAY([Accounts]AccountID;Self->)
				INSERT IN ARRAY:C227(Self:C308->; 1; 1)
				Self:C308->{1}:="Pick an agent account..."
				Self:C308->:=Abs:C99(Find in array:C230(Self:C308->; [eWires:13]AccountID:30))
			End if 
			
			
			
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			Self:C308->:=0
		End if 
		
		
		
	: (Form event code:C388=On Data Change:K2:15)
		[eWires:13]AccountID:30:=Self:C308->{Self:C308->}
		
		// subaccounts now
		C_POINTER:C301($subAccountPtr)
		$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "SubAccountID")
		handleDropDown_SubAccount($subAccountPtr; ->[eWires:13]SubAccountID:118; [eWires:13]AccountID:30; True:C214)
	Else 
		
		
End case 

If ([eWires:13]AccountID:30#"")
	$entity:=ds:C1482.Accounts.query("AccountID == :1"; [eWires:13]AccountID:30)
	If ($entity.length>0)
		[eWires:13]toCountryCode:112:=$entity.first().CountryCode
		[eWires:13]toCountry:10:=getCountryNameByCode([eWires:13]toCountryCode:112)
		[eWires:13]AgentID:26:=$entity.first().AgentID
		
		selectLinksByCustIDnCountry
	End if 
End if 