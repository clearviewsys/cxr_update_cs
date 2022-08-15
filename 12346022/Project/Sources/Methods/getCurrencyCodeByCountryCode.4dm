//%attributes = {}
// getCurrencyCodeByCountryCode (countryCode) : currencyCode
// returns the currency code given a country code


C_TEXT:C284($1; $0; $countryCode; $currencyCode)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=0)
		$countryCode:="US"
		
	: (Count parameters:C259=1)
		$countryCode:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($countryCodesArr; 0)
ARRAY TEXT:C222($currencyCodeArr; 0)

populateCountryCode_CCY_Arrays(->$countryCodesArr; ->$currencyCodeArr)
$i:=Find in array:C230($countryCodesArr; $countryCode)
If ($i>0)
	$currencyCode:=$currencyCodeArr{$i}
End if 

$0:=$currencyCode