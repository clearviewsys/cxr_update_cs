//%attributes = {}
// validateRatesSensibility(currency;isReceived; ourRate;buyRate;spotRate;sellRate)
C_TEXT:C284($currency; $1)
C_BOOLEAN:C305($2; $isReceived)
C_REAL:C285($ourRate; $buyRate; $spotRate; $sellRate; $3; $4; $5; $6)
$currency:=$1
$isReceived:=$2
$ourRate:=$3
$buyRate:=$4
$spotRate:=$5
$sellRate:=$6

C_REAL:C285(vRateChangeAllowance)
If ($ourRate#0)
	checkAddErrorIf((($currency=<>baseCurrency) & ($ourRate#1)); "Base currency rate is always 1")
	
	If (isUserAllowedToChangeRates(->vRateChangeAllowance))
		
		Case of 
				
			: ($isReceived)  // buy
				
				If ($ourRate>$buyRate)  // it is dangerous only if we buy higher than the set rate, but lower is ok
					checkAddWarning("HOLD ON: You are buying at higher rate than the set Buy Rate!")  // warn the user that they may lose money
					checkAddWarningOnTrue(($ourRate>=$sellRate); "You are buying at the selling rate. You may lose money in this transaction.")  // we can never buy higher than the selling rate
					checkAddErrorIf(isRateOffRange($buyRate; $ourRate; vRateChangeAllowance); "You are only allowed to change the rate up to %"+String:C10(vRateChangeAllowance*100))
				Else 
					checkAddWarningOnTrue(isRateOffRange($buyRate; $ourRate); "The buy rate seems too cheap, or too good to be true!")
				End if 
				
			Else 
				
				If ($ourRate<$sellRate)  // if we sell less than the sell rate
					checkAddWarning("HOLD ON: You are selling at a lower rate than the set Sell Rate!")  // warn the user that they may lose money
					checkAddWarningOnTrue(($ourRate<=$buyRate); "You are selling at the buy rate. Please verify the rate again.")  // we can never buy higher than the selling rate
					checkAddErrorIf(isRateOffRange($sellRate; $ourRate; vRateChangeAllowance); "You are only allowed to change the rate up to %"+String:C10(vRateChangeAllowance*100))
				Else 
					checkAddWarningOnTrue(isRateOffRange($sellRate; $ourRate); "The selling rate seems too expensive, or too good to be true!")
				End if 
				
		End case 
		
		
	Else 
		If ($isReceived)
			checkAddErrorIf($buyRate#$ourRate; "You cannot change the buy rate")
		Else 
			checkAddErrorIf($sellRate#$ourRate; "You cannot change the sell rate")
		End if 
		
		
	End if 
	
	
	
End if 
CLEAR VARIABLE:C89(vRateChangeAllowance)
