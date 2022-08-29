//%attributes = {"publishedWeb":true}
// updateQuoteUsingYahoo ( destinationCurrencyTicker) -> return true on success
// PRE: Record must be selected before you call this method
// this method updates the current record using Yahoo finance 

C_TEXT:C284($destCurrency)
C_BOOLEAN:C305($0)
C_TEXT:C284(vHTML)

vHTML:=""
If (False:C215)  // this method is obsolete)
	
	If (Count parameters:C259=1)
		$destCurrency:=$1
	Else 
		$destCurrency:=[Currencies:6]toISO4217:32
	End if 
	
	If ($destCurrency="")
		$destCurrency:=<>baseCurrency
	End if 
	
	//vHTML:=getYahooQuotesHTML ([Currencies]Symbol;$destCurrency)
	C_REAL:C285($normalizer)
	$normalizer:=100000
	
	If ([Currencies:6]AutoUpdateOurRates:21)
		vHTML:=getYahooQuotesHTML([Currencies:6]ISO4217:31; $destCurrency; $normalizer)
		$0:=parseQuoteFieldsFromYahoo(->vHTML; $normalizer)
	Else 
		$0:=True:C214
	End if 
End if 
