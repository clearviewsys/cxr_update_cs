//%attributes = {}
// GetCountryCode (countryName) : country Code
// this method uses constant arrays and doesn't search the table countries
// This method returns the country code based on the country name


C_TEXT:C284($1; $0; $countryCode; $countryName)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=0)
		$countryName:="United States"
		
	: (Count parameters:C259=1)
		$countryName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($countryCodesArr; 0)
ARRAY TEXT:C222($countryNamesArr; 0)

populateCountryArrays_ISO3166(->$countryCodesArr; ->$countryNamesArr)
$i:=Find in array:C230($countryNamesArr; $countryName)
If ($i>0)
	$countryCode:=$countryCodesArr{$i}
End if 

$0:=$countryCode