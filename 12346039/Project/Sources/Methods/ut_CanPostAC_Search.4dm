//%attributes = {"shared":true}
// __UNIT_TEST
//test method for CanPost_AC_Search
// Jan 2021

C_TEXT:C284($searchTerm)
C_BOOLEAN:C305($success)
C_OBJECT:C1216($test)

$test:=AJ_UnitTest.new("CanPost_AC_Search"; Current method name:C684; "API.CanadaPost")

C_TEXT:C284($country)
C_OBJECT:C1216($errorObj)

$searchTerm:="311 w pender"
$country:="CAN"

ARRAY OBJECT:C1221($resultObjArr; 0)
$success:=CanPostAC_Search(->$resultObjArr; $searchTerm; $country; ->$errorObj)
//ASSERT($success=True;"Expected true for success") // old way
// $test.given:="given CAN as country code"
// $test.should:="expect true result"
// $test.expected:=True
// $test.actual:=$success
// $test.assert()
AJ_assert($test; $success; True:C214; "Passing CAN as country code and 311 West Pender as Address"; "expect true")

//ASSERT(Size of array($resultObjArr)=12;"Expected 12 addresses for result") // old way
//$test.given:="given CAN as country code"
//$test.should:="12 addresses in the resulting array"
//$test.expected:=12
//$test.actual:=Size of array($resultObjArr)
//$test.assert()
AJ_assert($test; Size of array:C274($resultObjArr); 12; "Passing CAN as country code and 311 West Pender as Address"; "size of array should be 12")

$country:="CAT"

ARRAY OBJECT:C1221($resultObjArr; 0)
$success:=CanPostAC_Search(->$resultObjArr; $searchTerm; $country; ->$errorObj)
//ASSERT($success=False;"Expected false for success")

//$test.given:="given CAT as the country code"
//$test.should:="expect false resut"
//$test.expected:=False
//$test.actual:=$success
//$test.assert()
AJ_assert($test; $success; False:C215; "Given CAT as country code and 311 West Pender as Address"; "should return false")

//ASSERT(Size of array($resultObjArr)=0;"Expected no addresses for result")
$test.given:="given CAT as the country code"
$test.should:="expect no addresses for result"
$test.expected:=0
$test.actual:=Size of array:C274($resultObjArr)
$test.assert()
AJ_assert($test; Size of array:C274($resultObjArr); 0; "Given CAT as country code and 311 West Pender as Address"; "size of resulting array should be 0")

//ASSERT($errorObj#Null;"Expected an error")
//$test.given:="given CAT as the country code"
//$test.should:="expect an error object to be not null"
//$test.expected:=True
//$test.actual:=($errorObj#Null)
//$test.assert()
AJ_assert($test; ($errorObj#Null:C1517); True:C214; "Given CAT as country code and 311 West Pender as Address"; "errorObj should result not null")

// The old way
//ASSERT($errorObj.errorCode="1003")
//ASSERT($errorObj.errorDescription="Country Invalid")
//ASSERT($errorObj.errorCause="The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code.")
//ASSERT($errorObj.errorResolution="Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code.")

// the new way to write the test
// this is one way to test 
$test.given:="given CAT as the country code"
$test.should:="expect the error object to contain informations about the error"
$test.expected:=New object:C1471("errorCode"; "1003")
$test.expected.errorDescription:="Country Invalid"
$test.expected.errorCause:="The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code."
$test.expected.errorResolution:="Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code."
$test.actual:=$errorObj
$test.assert()

// this is another way to test the same thing
C_OBJECT:C1216($expectedErrorObj)
$expectedErrorObj:=New object:C1471
$expectedErrorObj.errorCode:="1003"
$expectedErrorObj.errorDescription:="Country Invalid"
$expectedErrorObj.errorCause:="The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code."
$expectedErrorObj.errorResolution:="Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code."
AJ_assert($test; $errorObj; $expectedErrorObj; "Given CAT as country code and 311 West Pender as Address"; "Error object should return "+JSON Stringify:C1217($expectedErrorObj))





