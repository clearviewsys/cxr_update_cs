C_TEXT:C284(INV_vNextAccountID)

If (Form event code:C388=On Load:K2:1)
	If (INV_vNextAccountID#"")
		[AccountInOuts:37]AccountID:6:=INV_vNextAccountID
		INV_vNextAccountID:=""
	End if 
	pickAccountsOfCurrency(Self:C308; vCurrency; "Please Select An Account")
End if 

If (Form event code:C388=On Data Change:K2:15)
	pickAccountsOfCurrency(Self:C308; [AccountInOuts:37]Currency:8; "Please Select An Account")
End if 

GOTO OBJECT:C206([AccountInOuts:37]SubAccountID:23)
POST OUTSIDE CALL:C329(Current process:C322)  // update the balance

C_POINTER:C301($dropDownPtr)
$dropDownPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
handleDropDown_SubAccount($dropDownPtr; ->[AccountInOuts:37]SubAccountID:23; [AccountInOuts:37]AccountID:6; True:C214)
