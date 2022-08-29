//%attributes = {}
// GetCountryCode (countryName) : country Code
// this method uses constant arrays and doesn't search the table countries
// This method returns the country code based on the country name


C_TEXT:C284($1; $0; $countryCode; $countryName)
C_TEXT:C284($areaCode)

C_LONGINT:C283($i)


Case of 
	: (Count parameters:C259=0)
		$countryCode:=<>CountryCode
		
	: (Count parameters:C259=1)
		$countryCode:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($areaCodesArr; 0)
ARRAY TEXT:C222($countryCodesArr; 0)

populateAreaCodeArrays(->$countryCodesArr; ->$areaCodesArr)
$i:=Find in array:C230($countryCodesArr; $countryCode)
If ($i>0)
	$areaCode:=$areaCodesArr{$i}
End if 

$0:=$areaCode