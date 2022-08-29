C_TEXT:C284($old)
$old:=[AccountInOuts:37]AccountID:6
[AccountInOuts:37]AccountID:6:=""
pickAccountsOfCurrency(->[AccountInOuts:37]AccountID:6; [AccountInOuts:37]Currency:8; "Pick an account")
If (OK=0)
	[AccountInOuts:37]AccountID:6:=$old
End if 