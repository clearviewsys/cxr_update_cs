//%attributes = {"shared":true}
// __UNIT_TEST
//Dec 2020
C_OBJECT:C1216($test)
C_TEXT:C284($given)

$test:=AJ_UnitTest.new("newAddress"; Current method name:C684; "Modules.Addresses")



//test method
C_OBJECT:C1216($addressObj)
$addressObj:=newAddress("CA"; "BC"; "Vancouver"; "V1V 2AC"; "123 main street"; "200")

C_OBJECT:C1216($expectedObj)
$expectedObj:=New object:C1471
$expectedObj.unit:="200"
$expectedObj.countryCode:="CA"
$expectedObj.province:="BC"
$expectedObj.streetAddress:="123 main street"
$expectedObj.city:="Vancouver"
$expectedObj.zipCode:="V1V 2AC"

AJ_assert($test; $addressObj; $expectedObj; JSON Stringify:C1217($addressObj); JSON Stringify:C1217($expectedObj))

/*
ASSERT($addressObj.countryCode="CA")
ASSERT($addressObj.province="BC")
ASSERT($addressObj.city="Vancouver")
ASSERT($addressObj.zipCode="V1V 2AC")
ASSERT($addressObj.streetAddress="123 main street")
ASSERT($addressObj.unit="200")
*/


