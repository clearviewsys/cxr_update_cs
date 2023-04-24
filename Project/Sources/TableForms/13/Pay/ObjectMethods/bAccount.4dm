

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (getKeyValue("ewire.accountid.useSelect"; "true")="false")
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			//OBJECT SET VISIBLE(*;"l_AccountID";False)
		End if 
	Else 
		pickAccountsOfCurrency(->[eWires:13]AccountID:30; [eWires:13]Currency:12; "Pick a Sub-ledger Account for sending eWire")
		C_POINTER:C301($subAccountPtr)
		$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "SubAccountID")
		handleDropDown_SubAccount($subAccountPtr; ->[eWires:13]SubAccountID:118; [eWires:13]AccountID:30; True:C214)
		[eWires:13]toCountryCode:112:=[Accounts:9]CountryCode:39
		[eWires:13]toCountry:10:=getCountryNameByCode([Accounts:9]CountryCode:39)
		[eWires:13]AgentID:26:=[Accounts:9]AgentID:16
		selectLinksByCustIDnCountry
End case 

