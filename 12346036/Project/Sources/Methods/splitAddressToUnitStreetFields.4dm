//%attributes = {}
//Amir 14th July 2020
//seperates mixed street address and unit number into parts
//splitAddressToUnitStreetFields($addressText;->street Address field;->unit number field)


C_TEXT:C284($mixedStreetAddress; $1)
C_POINTER:C301($sreetAddressFieldPtr; $unitNumberFieldPtr; $2; $3)
ASSERT:C1129(Count parameters:C259=3)
$mixedStreetAddress:=$1
$sreetAddressFieldPtr:=$2
$unitNumberFieldPtr:=$3

C_OBJECT:C1216($streetAddressObj)
$streetAddressObj:=splitAddressToUnitAndStreet($mixedStreetAddress)

$sreetAddressFieldPtr->:=$streetAddressObj.streetAddress
$unitNumberFieldPtr->:=$streetAddressObj.unitNumber
