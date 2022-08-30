C_LONGINT:C283($n)

If (cbValidate=1)
	$n:=countEODTellerProofForUserCurr(vCurrency; vCashAccount)
	If ($n>0)
		ALERT:C41("You have already closed this balance for the day")
		cbValidate:=0
	End if 
End if 