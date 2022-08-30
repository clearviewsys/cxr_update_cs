//%attributes = {}
//Amir 21st April 2020
// geocodes address object (latitude and longitude) using google API
//success <C_BOOLEAN> := googleGeocodeAddressObj(address object to geocode <C_OBJECT> : use newAddress method
//                                                 $errorObj <C_OBJECT> to store error)

// Unit test is written @Tiran


C_OBJECT:C1216($addressObj; $1)
C_OBJECT:C1216($errorObj; $2)
$addressObj:=$1
$errorObj:=$2
ASSERT:C1129(Count parameters:C259=2)
validateAddressObject($addressObj)
ASSERT:C1129(Type:C295($errorObj)=Is object:K8:27)
ASSERT:C1129($errorObj#Null:C1517)

C_OBJECT:C1216($geocodeResult)
C_TEXT:C284($formattedAddress)
C_BOOLEAN:C305($success)
$formattedAddress:=$formattedAddress+String:C10($addressObj.streetAddress)+", "
$formattedAddress:=$formattedAddress+String:C10($addressObj.city)+","
If ($addressObj.province#"")
	$formattedAddress:=$formattedAddress+String:C10($addressObj.province)+","
End if 
$formattedAddress:=$formattedAddress+String:C10($addressObj.zipCode)+","
$formattedAddress:=$formattedAddress+String:C10($addressObj.countryCode)
$success:=googleGeocodeAddressString($formattedAddress; ->$geocodeResult; ->$errorObj)

If ($success=True:C214)
	$addressObj.lat:=$geocodeResult.lat
	$addressObj.lng:=$geocodeResult.lng
End if 
$0:=$success