//pickBankAccountsofCurrency (Self;[Wires]Currency)


C_TEXT:C284(INV_VNEXTACCOUNTID)
If (INV_VNEXTACCOUNTID#"")
	[Wires:8]CXR_AccountID:11:=INV_VNEXTACCOUNTID
	INV_VNEXTACCOUNTID:=""
	//GOTO OBJECT([Wires]CXR_SubAccountID)
Else 
	//pickNonCashAccountsOfCurrency (Self;[Wires]Currency)
End if 

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On Data Change:K2:15))
	pickNonCashAccountsOfCurrency(Self:C308; [Wires:8]Currency:15)
End if 

C_POINTER:C301($subAccountPtr)
$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
If (Is nil pointer:C315($subAccountPtr))
	ASSERT:C1129(False:C215; "nil pointer")
Else 
	handleDropDown_SubAccount($subAccountPtr; ->[Wires:8]CXR_SubAccountID:61; [Wires:8]CXR_AccountID:11; True:C214)
End if 