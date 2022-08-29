//setting default country code
//Canada Post AddressComplete API requires 3 digit country code

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($countryCode2Digit)
		$countryCode2Digit:=<>CountryCode
		C_POINTER:C301($countryCodeInput)
		$countryCodeInput:=OBJECT Get pointer:C1124(Object named:K67:5; "CountryCode")
		$countryCodeInput->:=$countryCode2Digit
End case 


