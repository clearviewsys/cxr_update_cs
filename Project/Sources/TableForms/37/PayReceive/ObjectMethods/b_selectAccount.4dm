If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($old)
	$old:=[AccountInOuts:37]AccountID:6
	[AccountInOuts:37]AccountID:6:=""
	pickAccountsOfCurrency(->[AccountInOuts:37]AccountID:6; [AccountInOuts:37]Currency:8; "Please Select An Account")
	If (OK=0)
		[AccountInOuts:37]AccountID:6:=$old
	End if 
	
	POST OUTSIDE CALL:C329(Current process:C322)
End if 