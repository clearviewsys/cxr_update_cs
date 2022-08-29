
C_REAL:C285(vBalanceRemaining; vMarketRate; vMarketValue)

If (Form event code:C388=On Data Change:K2:15)
	vMarketValue:=vBalanceRemaining*vMarketRate
End if 