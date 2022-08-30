//pickBankAccountsofCurrency (Self;[Wires]Currency)` removed in ver. 3.427

C_TEXT:C284(INV_VNEXTACCOUNTID)
If (INV_VNEXTACCOUNTID#"")
	[Wires:8]CXR_AccountID:11:=INV_VNEXTACCOUNTID
	INV_VNEXTACCOUNTID:=""
Else 
	pickNonCashAccountsOfCurrency(Self:C308; [Wires:8]Currency:15)  // added in ver. 3.427
End if 

C_POINTER:C301($subAccountPtr)
$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
handleDropDown_SubAccount($subAccountPtr; ->[Wires:8]CXR_SubAccountID:61; [Wires:8]CXR_AccountID:11; True:C214)
