//If ([eWires]isPaymentSent)
//pickAccountsOfCurrency (Self;[eWires]ToCurrency)
//Else 
//pickAccountsOfCurrency (Self;[eWires]FromCurrency)
//End if 

C_TEXT:C284(INV_vNextAccountID)
C_OBJECT:C1216($entity)

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (getKeyValue("ewire.accountid.useSelect"; "true")="false")
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
				//INV_vNextAccountID:=""
			End if 
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		If (False:C215)
			//FILTER EVENT // this fails b/c it chantes the form event
			POST KEY:C465(Character code:C91("a"); Control key mask:K16:9+Shift key mask:K16:3)  //trigger bAccount
		Else 
			pickAccountsOfCurrency(->[eWires:13]AccountID:30; [eWires:13]Currency:12; "Pick a Sub-ledger Account for sending eWire")
			C_POINTER:C301($subAccountPtr)
			$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "SubAccountID")
			handleDropDown_SubAccount($subAccountPtr; ->[eWires:13]SubAccountID:118; [eWires:13]AccountID:30; True:C214)
			[eWires:13]toCountryCode:112:=[Accounts:9]CountryCode:39
			[eWires:13]toCountry:10:=getCountryNameByCode([Accounts:9]CountryCode:39)
			[eWires:13]AgentID:26:=[Accounts:9]AgentID:16
			selectLinksByCustIDnCountry
		End if 
End case 

