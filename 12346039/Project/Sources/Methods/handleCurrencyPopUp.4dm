//%attributes = {}
C_POINTER:C301($1; $2)
C_POINTER:C301($fromCurrencyPtr; $toCurrencyPtr)
$fromCurrencyPtr:=$1
$toCurrencyPtr:=$2


If (($fromCurrencyPtr->>0) & ($toCurrencyPtr->>0))
	Case of 
		: ($fromCurrencyPtr->=$toCurrencyPtr->)  // Curr1=Curr2 ....  error
			
			FORM GOTO PAGE:C247(1)
			$toCurrencyPtr->:=0
			myAlert("Currencies must be different")  // Cross (X -> Y)
			
			
		: (($toCurrencyPtr->{$toCurrencyPtr->}=<>baseCurrency) & ($fromCurrencyPtr->#$toCurrencyPtr->))  // Buy (X -> local)
			
			
			[Invoices:5]TransactionType:12:="Buy"
			[Invoices:5]fromCurrency:3:=$fromCurrencyPtr->{$fromCurrencyPtr->}
			RELATE ONE:C42([Invoices:5]fromCurrency:3)  // load the currency
			
			[Invoices:5]PolicyRateBuy:5:=[Currencies:6]OurBuyRateLocal:7  // fill in the our buy rate
			
			
			[Invoices:5]toCurrency:8:=<>baseCurrency
			FORM GOTO PAGE:C247(2)
			
		: (($fromCurrencyPtr->{$fromCurrencyPtr->}=<>baseCurrency) & ($fromCurrencyPtr->#$toCurrencyPtr->))  // sell (Local -> X)
			
			[Invoices:5]TransactionType:12:="Sell"
			[Invoices:5]toCurrency:8:=$toCurrencyPtr->{$toCurrencyPtr->}
			RELATE ONE:C42([Invoices:5]toCurrency:8)
			[Invoices:5]PolicyRateSell:10:=[Currencies:6]OurSellRateLocal:8
			
			[Invoices:5]fromCurrency:3:=<>baseCurrency  // 
			
			FORM GOTO PAGE:C247(3)
			
		: (($fromCurrencyPtr->#$toCurrencyPtr->) & ($fromCurrencyPtr->{$fromCurrencyPtr->}#<>baseCurrency) & ($toCurrencyPtr->{$toCurrencyPtr->}#<>baseCurrency))  // Cross
			
			[Invoices:5]TransactionType:12:="Cross"
			[Invoices:5]fromCurrency:3:=$fromCurrencyPtr->{$fromCurrencyPtr->}
			RELATE ONE:C42([Invoices:5]fromCurrency:3)
			[Invoices:5]PolicyRateBuy:5:=[Currencies:6]SpotRateLocal:17  // instead of ourBuyRate we take Market Avg so that commission is only taken 1 time
			
			
			[Invoices:5]toCurrency:8:=$toCurrencyPtr->{$toCurrencyPtr->}
			RELATE ONE:C42([Invoices:5]toCurrency:8)
			[Invoices:5]PolicyRateSell:10:=[Currencies:6]OurSellRateLocal:8
			
			FORM GOTO PAGE:C247(4)
			
	End case 
	
End if 