If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(vecFromCurrency; 0)
	ARRAY TEXT:C222(vecToCurrency; 0)
	fillCurrencyCodeArray(->vecFromCurrency)
	fillCurrencyCodeArray(->vecToCurrency)
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	setFlagPicture(->vFromFlag; Self:C308->{Self:C308->})
	C_REAL:C285(vRate1)
	handleVecFromCurrency(vecFromCurrency{vecFromCurrency}; ->vFromMarketAvg; ->vFromOurBuy; ->vRate1)
	handleCalculatorFormMethod
	vExchangeRate:=vOurExchangeRate
	
End if 
