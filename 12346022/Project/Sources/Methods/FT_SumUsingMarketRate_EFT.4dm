//%attributes = {}
// FT_SumUsingMarketRate_EFT ($recordId)


C_TEXT:C284($1; $recordId)
C_REAL:C285($0; $totMarketRate)
C_BOOLEAN:C305($exported)

Case of 
	: (Count parameters:C259=1)
		$recordId:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$exported:=(operationMode=0)
QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$recordId)

$totMarketRate:=0

While (Not:C34(End selection:C36([Registers:10])))
	
	If ([Registers:10]RegisterType:4="Buy")
		$totMarketRate:=$totMarketRate+AmountToSpotRate([Registers:10]DebitLocal:23)
	Else 
		$totMarketRate:=$totMarketRate+AmountToSpotRate([Registers:10]CreditLocal:24)
	End if 
	
	NEXT RECORD:C51([Registers:10])
End while 

$0:=$totMarketRate