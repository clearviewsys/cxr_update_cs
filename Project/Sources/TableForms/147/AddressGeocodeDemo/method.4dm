//setting default country code
//Canada Post AddressComplete API requires 3 digit country code
C_TEXT:C284($countryCode3Digit; $countryCode2Digit)
$countryCode2Digit:=<>CountryCode
$countryCode3Digit:=getCountryCodeBy2charCode($countryCode2Digit)
If ($countryCode3Digit#"")
	C_POINTER:C301($countryCodeInput)
	$countryCodeInput:=OBJECT Get pointer:C1124(Object named:K67:5; "CountryCode")
	$countryCodeInput->:=$countryCode3Digit
End if 

OBJECT SET VISIBLE:C603(*; "GoogleMap"; False:C215)

