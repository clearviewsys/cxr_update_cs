//%attributes = {}
// validatePostalCodeFormat($postalCode: text, $countryCode: text) -> $isValid: boolean
// This method will check the validity of the format of a postal/zip code. It will not chech if the code itself is valid.
// It will check if the country code exists, then return valid, if country code is not in the case statemetn it will always return true
// @viktor
// Unit test is written @Viktor

C_TEXT:C284($postalCode; $1; $countryCode; $2)
C_TEXT:C284($regex)
C_BOOLEAN:C305($isValid)

Case of 
	: (Count parameters:C259=2)
		$postalCode:=$1
		$countryCode:=Uppercase:C13($2)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($countryCode="CA")  // CANADA
		$regex:="^[A-Za-z]\\d[A-Za-z][ -]?\\d[A-Za-z]\\d$"
		$isValid:=Match regex:C1019($regex; $postalCode)
		
	: ($countryCode="US")  // UNITED STATES
		$regex:="^[0-9]{5}(?:-[0-9]{4})?$"
		$isValid:=Match regex:C1019($regex; $postalCode)
		
	: ($countryCode="NZ")  // NEW ZEALAND
		$regex:="^(\\d\\s*\\.*-*){4}$"
		$isValid:=Match regex:C1019($regex; $postalCode)
		
	Else 
		$isValid:=True:C214
End case 

$0:=$isValid