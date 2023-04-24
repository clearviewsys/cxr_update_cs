//%attributes = {}
// getCountryNameByCode (countryCode) : countryName
// returns the country name given a country code
// this method uses constant arrays and doesn't search the table countries


C_TEXT:C284($1; $0; $countryCode; $countryName)
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
ARRAY TEXT:C222($countryNamesArr; 0)

populateCountryArrays_ISO3166(->$countryCodesArr; ->$countryNamesArr)
$i:=Find in array:C230($countryCodesArr; $countryCode)
If ($i>0)
	$countryName:=$countryNamesArr{$i}
End if 

$0:=$countryName