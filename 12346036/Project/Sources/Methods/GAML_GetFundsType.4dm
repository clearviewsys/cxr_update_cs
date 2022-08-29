//%attributes = {}
// GAML_GetFundsType
// Gets the Funds type using the invoice number


C_TEXT:C284($0)
C_TEXT:C284($1; $fundsType)

Case of 
		
	: (Count parameters:C259=0)
		$fundsType:="P"  // P: Other, D: Cash
		
	: (Count parameters:C259=1)
		$fundsType:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=$fundsType
