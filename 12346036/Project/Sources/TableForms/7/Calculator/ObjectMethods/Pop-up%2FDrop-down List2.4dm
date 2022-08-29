If (Form event code:C388=On Clicked:K2:4)
	setFlagPicture(->vToFlag; Self:C308->{Self:C308->})
	C_REAL:C285(vRate2)
	handleVecToCurrency(vecToCurrency{vecToCurrency}; ->vToMarketAvg; ->vToOurSell; ->vRate2)
	handleCalculatorFormMethod
	vExchangeRate:=vOurExchangeRate
	
End if 