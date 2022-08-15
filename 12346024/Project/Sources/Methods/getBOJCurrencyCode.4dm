//%attributes = {}
// getBOJCurrencyCode (code: txt): BOJ Code
// e.g. getBOJCurrencyCode ("JMD") returns "000"

C_TEXT:C284($0; $1; $BOJCode; $ISOCode)

ARRAY TEXT:C222($arrISOCode; 0)
ARRAY TEXT:C222($arrBOJCode; 0)

Case of 
	: (Count parameters:C259=0)
		$ISOCode:="CAD"  // for testing
	: (Count parameters:C259=1)
		$ISOCode:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

populateBOJ_CCYArrays(->$arrISOCode; ->$arrBOJCode)
C_LONGINT:C283($i)

$i:=Find in array:C230($arrISOCode; $ISOCode)
If ($i>0)
	$BOJCode:=$arrBOJCode{$i}
Else 
	$BOJCode:="999"
End if 

$0:=$BOJCode