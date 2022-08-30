If (Form event code:C388=On Data Change:K2:15)
	pickAccountsOfCurrency(Self:C308; [Items:39]Currency:8)
	If (OK=1)
		C_POINTER:C301($subAccountPtr)
		$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
		handleDropDown_SubAccount($subAccountPtr; ->[Items:39]SubAccountID:26; [Items:39]AccountID:12; True:C214)
	End if 
End if 