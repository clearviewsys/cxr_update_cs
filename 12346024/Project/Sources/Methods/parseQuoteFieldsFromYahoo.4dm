//%attributes = {"publishedWeb":true}
// parseQuoteFieldsFromYahoo (->HTMLText;coefficient)
// coeffiecient is the amount that is passed to the reuters fromAmount calculator
// because the rates are not precise enough we have to send larger numbers to get higher precision

// fields will be parsed and assigned


C_POINTER:C301($1)
C_REAL:C285($normalizer)
C_BOOLEAN:C305($0)
C_REAL:C285($marketAvg)

If (Count parameters:C259=2)
	$normalizer:=$2
Else 
	$normalizer:=1
End if 

If ($1->="")
	
	[Currencies:6]hasFailedUpdate:37:=True:C214
Else 
	
	$marketAvg:=getYahooMarketAvg($1)/$normalizer
	setCurrencySpotRate($marketAvg; getUpdateSourceMainURL)
	
	
End if 

$0:=Not:C34([Currencies:6]hasFailedUpdate:37)
