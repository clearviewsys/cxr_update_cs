If (Form event code:C388=On Load:K2:1)
	C_REAL:C285(vFromAmount; vToAmount; vExchangeRate)
	initializeCalculator
	//SET TIMER(60*60)
	
	
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	handleCalculatorFormMethod
End if 