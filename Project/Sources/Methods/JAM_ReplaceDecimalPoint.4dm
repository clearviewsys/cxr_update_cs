//%attributes = {}
// JAM_ReplaceDecimalPoint
// Replace decimal point in a converted number string


C_TEXT:C284($1; $strNumber)
C_TEXT:C284($0)


Case of 
		
	: (Count parameters:C259=1)
		$strNumber:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$strNumber:="0"+Replace string:C233($strNumber; "."; "")
$0:=$strNumber




