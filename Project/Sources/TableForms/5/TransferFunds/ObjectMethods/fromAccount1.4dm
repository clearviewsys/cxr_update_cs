
applyFocusRect
C_REAL:C285(vFrombalance; vMaximumTransferOut)
If (vCurrency="")
	pickAccounts(Self:C308; "ALL RECORDS([ACCOUNTS])"; "Transfer from account")
	vCurrency:=[Accounts:9]Currency:6
Else 
	pickAccountsOfCurrency(Self:C308; vCurrency; "Transfer from account")
	
End if 

POST OUTSIDE CALL:C329(Current process:C322)