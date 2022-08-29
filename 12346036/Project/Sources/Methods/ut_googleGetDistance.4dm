//%attributes = {"shared":true}
//test method for Address_GetDistanceGoogle
//AJAR @ZOya
//13 Jan 2021

// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("GoogleGetDistance"; Current method name:C684; "API.GoogleMap")


C_OBJECT:C1216($pointA)
C_OBJECT:C1216($pointB)
$pointA:=New object:C1471
$pointA.lat:=49.3157976
$pointA.lng:=-123.0745078

$pointB:=New object:C1471
$pointB.lat:=49.3285962
$pointB.lng:=-123.1648352

C_OBJECT:C1216($resultObj; $errorObj)
$resultObj:=New object:C1471
$errorObj:=New object:C1471
C_BOOLEAN:C305($success)
$success:=googleGetDistance($pointA; $pointB; $resultObj; $errorObj)
/*ASSERT($success=True;"Expected true for success")
ASSERT($resultObj.distance>3000;"Expectation failed for distance")
ASSERT($resultObj.text#"";"Expectation failed for text")
ASSERT(Undefined($errorObj.error_message);"Expected no errors")
*/
C_LONGINT:C283($testVar)
$testVar:=$resultObj.distance
C_TEXT:C284($testText)
$testText:=$resultObj.text
AJ_assert($test; $success; True:C214; JSON Stringify:C1217($pointA)+JSON Stringify:C1217($pointB); "Expected true for success")
AJ_assert($test; $testVar>3000; True:C214; JSON Stringify:C1217($pointA)+JSON Stringify:C1217($pointB); "Expectation failed for distance")
AJ_assert($test; $testText#""; True:C214; JSON Stringify:C1217($pointA)+JSON Stringify:C1217($pointB); "Expectation failed for text")
AJ_assert($test; Undefined:C82($errorObj.error_message); True:C214; JSON Stringify:C1217($pointA)+JSON Stringify:C1217($pointB); "Expected no errors")

$success:=googleGetDistance($pointA; $pointB; $resultObj; $errorObj; "WrongGoogleApiKey")
/*ASSERT($success=False;"Expected false for success")
ASSERT($errorObj.error_message="Error connecting to Google Distance API: The provided API key is invalid.";"Expectation failed for error message")
*/

AJ_assert($test; $success; False:C215; "WrongGoogleApiKey"; "Expected false for success")
AJ_assert($test; $errorObj.error_message; "Error connecting to Google Distance API: The provided API key is invalid."; "WrongGoogleApiKey"; "Expectation failed for error message")