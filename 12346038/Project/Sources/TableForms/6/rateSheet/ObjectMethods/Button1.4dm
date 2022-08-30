C_LONGINT:C283(cbUseInverseRates)


$n:=Size of array:C274(aFlags)
//
checkInit
C_LONGINT:C283($i; $total)
For ($i; 1; $n)
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=aCurrencies{$i})
	If (isRateOffRange([Currencies:6]SpotRateLocal:17; aSpotRates{$i}))
		checkAddWarning([Currencies:6]CurrencyCode:1+" spot rate of "+String:C10(aSpotRates{$i})+" seems off from "+String:C10([Currencies:6]SpotRateLocal:17))
	End if 
	If (isRateOffRange([Currencies:6]OurBuyRateLocal:7; aOurBuyRates{$i}))
		checkAddWarning([Currencies:6]CurrencyCode:1+" buy rate of "+String:C10(aSpotRates{$i})+" seems off from  "+String:C10([Currencies:6]SpotRateLocal:17))
	End if 
	If (isRateOffRange([Currencies:6]OurSellRateLocal:8; aOurSellRates{$i}))
		checkAddWarning([Currencies:6]CurrencyCode:1+" sell rate of "+String:C10(aSpotRates{$i})+" seems off from  "+String:C10([Currencies:6]SpotRateLocal:17))
	End if 
	
End for 
//
If (isValidationConfirmed)
	READ WRITE:C146([Currencies:6])
	COPY NAMED SELECTION:C331([Currencies:6]; "$currenciesSnapshot")
	CREATE EMPTY SET:C140([Currencies:6]; "$lockedcurrencies")
	
	C_LONGINT:C283($progress; $n)
	$progress:=launchProgressBar("Updating...")
	$total:=Size of array:C274(aFlags)
	BRING TO FRONT:C326($progress)
	
	For ($i; 1; $total)
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=aCurrencies{$i})  // find the associated record
		If (Locked:C147([Currencies:6]))
			ADD TO SET:C119([Currencies:6]; "$lockedcurrencies")
		Else 
			LOAD RECORD:C52([Currencies:6])
			[Currencies:6]oldSpotRate1:44:=[Currencies:6]SpotRateLocal:17
			[Currencies:6]displayOrderOnBoard:6:=$i
			[Currencies:6]Country:22:=arrCountries{$i}
			[Currencies:6]Name:2:=arrCurrencyNames{$i}
			
			If (cbUseInverseRates=1)
				[Currencies:6]OurBuyRateLocal:7:=1/aInvBuyRates{$i}
				[Currencies:6]SpotRateLocal:17:=1/aInvSpotRates{$i}
				[Currencies:6]OurSellRateLocal:8:=1/aInvSellRates{$i}
				
			Else 
				[Currencies:6]OurBuyRateLocal:7:=aOurBuyRates{$i}
				[Currencies:6]SpotRateLocal:17:=aSpotRates{$i}
				[Currencies:6]OurSellRateLocal:8:=aOurSellRates{$i}
			End if 
			[Currencies:6]hasFailedUpdate:37:=False:C215
			
			refreshProgressBar($progress; $i; $total)
			DELAY PROCESS:C323(Current process:C322; 1)
			SAVE RECORD:C53([Currencies:6])
			setProgressBarTitle($progress; "Currency  "+aCurrencies{$i}+" is being updated.")
		End if 
	End for 
	HIDE PROCESS:C324($progress)
	
	If (Records in set:C195("$lockedcurrencies")>0)
		myAlert(String:C10(Records in set:C195("$lockedcurrencies"))+" records were locked and were not updated during save.")
		USE NAMED SELECTION:C332("$currenciesSnapshot")
		CLEAR NAMED SELECTION:C333("$currenciesSnapshot")
		CLEAR SET:C117("$lockedcurrencies")
		READ ONLY:C145([Currencies:6])
		
		REJECT:C38
	Else 
		USE NAMED SELECTION:C332("$currenciesSnapshot")
		CLEAR NAMED SELECTION:C333("$currenciesSnapshot")
		CLEAR SET:C117("$lockedcurrencies")
		READ ONLY:C145([Currencies:6])
	End if 
	writeCurrencyRatesAsXML  // write the rates again
Else 
	REJECT:C38
End if 
