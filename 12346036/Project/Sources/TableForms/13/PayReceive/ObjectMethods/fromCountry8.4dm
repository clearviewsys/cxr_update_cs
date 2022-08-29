If ([eWires:13]isPaymentSent:20)
	pickAccountsOfCurrency(Self:C308; [eWires:13]Currency:12)
Else 
	pickAccountsOfCurrency(Self:C308; [eWires:13]FromCurrency:11)
End if 

If (OK=1)
	C_POINTER:C301($subAccountPtr)
	$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "SubAccountID")
	handleDropDown_SubAccount($subAccountPtr; ->[eWires:13]SubAccountID:118; [eWires:13]AccountID:30; True:C214)
End if 
