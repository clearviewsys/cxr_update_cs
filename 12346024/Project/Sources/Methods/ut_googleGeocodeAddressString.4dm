//%attributes = {"shared":true}
//test method for Address_GeocodeAddress
//Ajar conversion done @Zoya
//13 Jan 2021
// __UNIT_TEST

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("googleGeocodeAddressString"; Current method name:C684; "API.GoogleMap")

C_OBJECT:C1216($resultObj; $errorObj)
C_BOOLEAN:C305($success)
C_TEXT:C284($address)

$address:="3844 Hobbs St, VICTORIA, BC, V8N 4C4, CA"

$success:=googleGeocodeAddressString($address; ->$resultObj; ->$errorObj)

//the following 4 tests all fail!

/*ASSERT($success=True;"Expected true for success")
ASSERT($resultObj#Null;"Expected non-null for result")
ASSERT($errorObj=Null;"Expected null for error")
ASSERT($resultObj.lat=48.4626156;"Expectation failed for latitude coordinate of geocode result")
ASSERT($resultObj.lng=-123.2986559;"Expectation failed for longitude coordinate of geocode result")
*/
AJ_assert($test; $success; True:C214; JSON Stringify:C1217($address); "Expected true for success")
AJ_assert($test; $resultObj#Null:C1517; True:C214; JSON Stringify:C1217($address); "Expected non-null for result")
AJ_assert($test; $errorObj=Null:C1517; True:C214; JSON Stringify:C1217($address); "Expected null for error")

C_LONGINT:C283($resultLat; $resultLng)
$resultLat:=$resultObj.lat
$resultLng:=$resultObj.lng
AJ_assert($test; $resultLat; 48.4626156; JSON Stringify:C1217($address); "Expectation failed for latitude coordinate of geocode result")
AJ_assert($test; $resultLng; -123.2986559; JSON Stringify:C1217($address); "Expectation failed for longitude coordinate of geocode result")




//testing wrong api key
$resultObj:=Null:C1517
$errorObj:=Null:C1517
$success:=googleGeocodeAddressString($address; ->$resultObj; ->$errorObj; "wrong api key")
/*ASSERT($success=False;"Expected false for success")
ASSERT($resultObj=Null;"Expected no result")
ASSERT($errorObj#Null;"Expected non-null object for error")
ASSERT($errorObj.error_message="Error connecting to Google Geocoding API: The provided API key is invalid.";"Expectation failed for error message")
*/
AJ_assert($test; $success; False:C215; "wrong api key"; "Expected false for success")
AJ_assert($test; $resultObj=Null:C1517; True:C214; "wrong api key"; "Expected no result")
AJ_assert($test; $errorObj#Null:C1517; True:C214; "wrong api key"; "Expected non-null object for error")
AJ_assert($test; $errorObj.error_message; "Error connecting to Google Geocoding API: The provided API key is invalid."; "wrong api key"; "Expectation failed for error message")