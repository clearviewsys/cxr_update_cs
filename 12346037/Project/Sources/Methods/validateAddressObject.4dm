//%attributes = {}
//Amir 13th April 2020
//validates address objects created by NewAddress method
C_OBJECT:C1216($addressObj; $1)
$addressObj:=$1
ASSERT:C1129(Type:C295($addressObj)=Is object:K8:27)
ASSERT:C1129($addressObj#Null:C1517)
ASSERT:C1129(OB Is defined:C1231($addressObj; "countryCode"))
//ASSERT(Length($addressObj.countryCode)=2)
ASSERT:C1129(OB Is defined:C1231($addressObj; "province"))
ASSERT:C1129(OB Is defined:C1231($addressObj; "city"))
//ASSERT($addressObj.city#"")
ASSERT:C1129(OB Is defined:C1231($addressObj; "zipCode"))
//ASSERT($addressObj.zipCode#"")
ASSERT:C1129(OB Is defined:C1231($addressObj; "streetAddress"))
//ASSERT($addressObj.streetAddress#"")
ASSERT:C1129(OB Is defined:C1231($addressObj; "unit"))