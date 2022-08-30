If (Form event code:C388=On Clicked:K2:4)
	pickAccounts(->[Items:39]AccountID:12; "allRecordsAccounts"; "Pick Account"; True:C214)
	If (OK=1)
		[Items:39]Currency:8:=[Accounts:9]Currency:6
	End if 
End if 