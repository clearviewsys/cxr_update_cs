//%attributes = {}
// this method is called from within the handleQuickCash Button

C_TEXT:C284(vReceivedorPaid; vCurrency)
C_REAL:C285(vAmount; vAmountLocal; vRate; vBuyRate; vSellRate)
C_REAL:C285(vRateChangeAllowance4Ind; vRateChangeAllowance4Corp)
C_TEXT:C284($paymentMethod)
C_BOOLEAN:C305($coinCondition; $matchFeeRule; $matchAMLRule)
C_REAL:C285($deviation)

ARRAY TEXT:C222(vecPaymentMethod; 6)
$paymentMethod:=vecPaymentMethod{vecPaymentMethod}


checkIfNullString(->vCustomerID; "Customer ID")
checkifRecordExists(->[Customers:3]; ->[Customers:3]CustomerID:1; ->vCustomerID; "Customer ID")

// ***********************************  NEW IN VERSION 3.606
$matchFeeRule:=False:C215
$matchAMLRule:=matchAMLRules(vReceivedorPaid; vecPaymentMethod{vecPaymentMethod}; INV_vNextAccountID; vAmount; vCurrency; vAmountLocal)

//If (checkWarningExist )
//  //createRecordExceptionLog (->[Invoices];"AML Rule match:";;checkGetWarningString )
//End if 

// *************************************************************************************************************************


If (vRate#0)
	$coinCondition:=($paymentMethod=c_Cash) & (vAmount#Int:C8(vAmount))
	checkAddErrorIf(((vCurrency=<>baseCurrency) & (vRate#1)); "Base currency rate should be 1")
	
	
	If (isUserAllowedToChangeRates(->vRateChangeAllowance4Ind; ->vRateChangeAllowance4Corp))  // user is allowed to change the rate
		//checkAddWarningOnTrue (isRateOffRange (vSpotRate;vRate);"The rate seems very off!")
		Case of 
				
			: (vReceivedorPaid=c_Received)  // buy
				
				If (Not:C34([Currencies:6]weBuyCoins:47))  // we don't buy coins
					checkAddWarningOnTrue($coinCondition; "We only buy paper bills for this currency. Coins are not accepted.")
				End if 
				
				If ([Customers:3]isCompany:41)  // range checking of rate is not necessary for dealing with corporations
					If ([Customers:3]isInsider:102) & (getKeyValue("invoices.isinsider.rate.override.allowed"; "false")="True")  //internal transaction 7/27/22 @ibb
						checkAddWarningOnTrue(isRateOffRange(vBuyRate; vRate; vRateChangeAllowance4Corp); "Your maximum allowance to change the corporate buy rate is %"+String:C10(vRateChangeAllowance4Corp*100))
					Else 
						checkAddErrorIf(isRateOffRange(vBuyRate; vRate; vRateChangeAllowance4Corp); "Your maximum allowance to change the corporate buy rate is %"+String:C10(vRateChangeAllowance4Corp*100))
					End if 
				Else   // range checking for dealing with individual customers
					
					
					If (vRate>vBuyRate)  // it is dangerous only if we buy higher than the set rate, but lower is ok
						checkAddWarning("Caution: You are paying more than your preset Buy Rate!")  // warn the user that they may lose money
						checkAddWarningOnTrue((vRate>=vSellRate); "WAIT: You are buying higher than your own selling rate!!!")  // we can never buy higher than the selling rate
						checkAddErrorIf(isRateOffRange(vBuyRate; vRate; vRateChangeAllowance4Ind); "You are only allowed to change the rate up to %"+String:C10(vRateChangeAllowance4Ind*100))
					Else 
						$deviation:=calcDeviationInPct(vRate; vBuyRate)
						//checkAddWarningOnTrue (isRateOffRange (vBuyRate;vRate);"This rate has a "+String($deviation)+"% deviation from "+String(vBuyRate))
						checkAddErrorIf(isRateOffRange(vBuyRate; vRate); "This rate has a "+String:C10($deviation)+"% deviation from "+String:C10(vBuyRate))  //@ibb 7/27/22
						checkAddErrorIf(($deviation>1000); "Sorry, but this must be a human-error. Rate deviation is"+String:C10($deviation)+"%")
						
					End if 
					
					
				End if 
				
			: (vReceivedorPaid=c_Paid)  // sell 
				
				If (Not:C34([Currencies:6]weSellCoins:48))  // we don't buy coins
					checkAddWarningOnTrue($coinCondition; "Are you sure you carry the coins for this currency?")
				End if 
				If ([Customers:3]isCompany:41)  // range checking is different when dealing with with corporations
					If ([Customers:3]isInsider:102) & (getKeyValue("invoices.isinsider.rate.override.allowed"; "false")="True")  //internal transaction 7/27/22 @ibb"
						checkAddWarningOnTrue(isRateOffRange(vSellRate; vRate; vRateChangeAllowance4Corp); "Your maximum allowance to change the corporate sell rate is %"+String:C10(vRateChangeAllowance4Corp*100))
					Else 
						checkAddErrorIf(isRateOffRange(vSellRate; vRate; vRateChangeAllowance4Corp); "Your maximum allowance to change the corporate sell rate is %"+String:C10(vRateChangeAllowance4Corp*100))
					End if 
				Else 
					If (vRate<vSellRate)  // if we sell less than the sell rate
						checkAddWarning("Caution: You are selling cheaper than the default selling rate.")  // warn the user that they may lose money
						checkAddWarningOnTrue((vRate<=vBuyRate); "WAIT: You are selling cheaper than your own buy rate.")  // we can never buy higher than the selling rate
						checkAddErrorIf(isRateOffRange(vSellRate; vRate; vRateChangeAllowance4Ind); "You are only allowed to change the rate up to %"+String:C10(vRateChangeAllowance4Ind*100))
					Else 
						$deviation:=calcDeviationInPct(vRate; vSellRate)
						//checkAddWarningOnTrue (isRateOffRange (vSellRate;vRate);"This rate has a "+String($deviation)+"% deviation from "+String(vSellRate))
						checkAddErrorIf(isRateOffRange(vSellRate; vRate); "This rate has a "+String:C10($deviation)+"% deviation from "+String:C10(vSellRate))  //@ibb 7/27/22
						checkAddErrorIf(($deviation>1000); "Sorry, but this must be a human-error. Rate deviation is"+String:C10($deviation)+"%")
					End if 
				End if 
				
				
				
			Else 
				//checkAddError ("Please select Buy/Sell")
				
		End case 
		
		If (checkWarningExist)
			createRecordExceptionLog(->[Invoices:5]; "Rate adjustment:"; vInvoiceNumber; checkGetWarningString)
		End if 
		
	Else   // user is not authorized to change the dealing rate
		Case of 
			: (vReceivedorPaid=c_Received)  // buy
				checkAddErrorIf(vBuyRate#vRate; "Sorry, you cannot change the buy rate")
			: (vReceivedorPaid=c_Paid)
				checkAddErrorIf(vSellRate#vRate; "Sorry, you cannot change the sell rate.")
		End case 
	End if 
End if 



//validateRatesSensibility (vCurrency;(vReceivedorPaid=c_Received );vRate;vBuyRate;vSpotRate;vSellRate)