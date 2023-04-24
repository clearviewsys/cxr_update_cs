//%attributes = {"shared":true}
// __UNIT_TEST
// converted to AJAR @Zoya
//Dec 2020

C_OBJECT:C1216($test)
// ut_
$test:=AJ_UnitTest.new("CreateRecordAddress"; Current method name:C684; "Modules")

//test method for createRecordAddress
C_TEXT:C284($addressId)
C_TEXT:C284($addressType; $suiteNumber; $streetAddress; $postalCode; $city; $province; $countryCode; $customerRecordId)
$addressType:="Main"
$suiteNumber:="110"
$streetAddress:="123 test street"
$postalCode:="V7V123"
$city:="Vancouver"
$province:="BC"
$countryCode:="CA"
$customerRecordId:="TTCUS20793"
$addressId:=createRecordAddress(->[Customers:3]; $customerRecordId; $addressType; $suiteNumber; $streetAddress; $postalCode; $city; $province; $countryCode)

//ASSERT($addressId#"")
AJ_assert($test; $addressId#""; True:C214; "A not null Address ID"; "confirm not null")

QUERY:C277([Addresses:147]; [Addresses:147]AddressID:18=$addressId)

//ASSERT(Records in selection([Addresses])=1;"Expected only one address")
AJ_assert($test; Records in selection:C76([Addresses:147]); 1; "one address per address ID"; "Expected only one address")

//ASSERT([Addresses]Type=$addressType)
AJ_assert($test; [Addresses:147]Type:1; $addressType; "address type as "+$addressType; "return "+$addressType)

//ASSERT([Addresses]UnitNo=$suiteNumber)
AJ_assert($test; [Addresses:147]UnitNo:15; $suiteNumber; "unit/suit number as "+$suiteNumber; "return "+$suiteNumber)

//ASSERT([Addresses]Address=$streetAddress)
AJ_assert($test; [Addresses:147]Address:3; $streetAddress; "123 test street as the street address"; "return "+$streetAddress)

//ASSERT([Addresses]ZipCode=$postalCode)
AJ_assert($test; [Addresses:147]ZipCode:6; $postalCode; "V7V123 as the zip/postal code"; "return "+$postalCode)

//ASSERT([Addresses]City=$city)
AJ_assert($test; [Addresses:147]City:4; $city; "Vancouver as the city"; "return "+$city)

//ASSERT([Addresses]State=$province)
AJ_assert($test; [Addresses:147]State:5; $province; "BC as the province"; "return "+$province)

//ASSERT([Addresses]CountryCode=$countryCode)
AJ_assert($test; [Addresses:147]CountryCode:7; $countryCode; "CA as the country code"; "return "+$countryCode)

//ASSERT([Addresses]RecordID=$customerRecordId)
AJ_assert($test; [Addresses:147]RecordID:9; $customerRecordId; "TTCUS20793 as custoemr record ID"; "return "+$customerRecordId)

//ASSERT([Addresses]TableNo=Table(->[Customers]))
AJ_assert($test; [Addresses:147]TableNo:8; Table:C252(->[Customers:3]); "pushing a record in Customers"; "return customers table No")

READ WRITE:C146([Addresses:147])
If (Records in selection:C76([Addresses:147])=1)
	DELETE RECORD:C58([Addresses:147])
End if 

$addressId:=createRecordCustomerAddress($customerRecordId; $addressType; $suiteNumber; $streetAddress; $postalCode; $city; $province; $countryCode)
ASSERT:C1129($addressId#"")
AJ_assert($test; $addressId#""; True:C214; "a not null address ID"; "return True")

QUERY:C277([Addresses:147]; [Addresses:147]AddressID:18=$addressId)

ASSERT:C1129(Records in selection:C76([Addresses:147])=1; "Expected only one address")
AJ_assert($test; Records in selection:C76([Addresses:147]); 1; "one address per address ID"; "Expected only one address")

/*ASSERT([Addresses]Type=$addressType)
ASSERT([Addresses]UnitNo=$suiteNumber)
ASSERT([Addresses]Address=$streetAddress)
ASSERT([Addresses]ZipCode=$postalCode)
ASSERT([Addresses]City=$city)
ASSERT([Addresses]State=$province)
ASSERT([Addresses]CountryCode=$countryCode)
ASSERT([Addresses]RecordID=$customerRecordId)
ASSERT([Addresses]TableNo=Table(->[Customers]))*/


AJ_assert($test; [Addresses:147]Type:1; $addressType; "address type as "+$addressType; "return "+$addressType)

AJ_assert($test; [Addresses:147]UnitNo:15; $suiteNumber; "unit/suit number as "+$suiteNumber; "return "+$suiteNumber)

AJ_assert($test; [Addresses:147]Address:3; $streetAddress; "123 test street as the street address"; "return "+$streetAddress)

AJ_assert($test; [Addresses:147]ZipCode:6; $postalCode; "V7V123 as the zip/postal code"; "return "+$postalCode)

AJ_assert($test; [Addresses:147]City:4; $city; "Vancouver as the city"; "return "+$city)

AJ_assert($test; [Addresses:147]State:5; $province; "BC as the province"; "return "+$province)

AJ_assert($test; [Addresses:147]CountryCode:7; $countryCode; "CA as the country code"; "return "+$countryCode)

AJ_assert($test; [Addresses:147]RecordID:9; $customerRecordId; "TTCUS20793 as custoemr record ID"; "return "+$customerRecordId)

AJ_assert($test; [Addresses:147]TableNo:8; Table:C252(->[Customers:3]); "pushing a record in Customers"; "return customers table No")

//trigger should set these values
//ASSERT([Addresses]HashWithoutStreetAddress#"")
AJ_assert($test; [Addresses:147]HashWithoutStreetAddress:17#""; True:C214; "Hash without street address should not be null "; "return something like "+[Addresses:147]HashWithoutStreetAddress:17)
//ASSERT([Addresses]HashWithStreetAddress#"")
AJ_assert($test; [Addresses:147]HashWithStreetAddress:16#""; True:C214; "Hash with street address should not be null "; "return something like "+[Addresses:147]HashWithStreetAddress:16)
//ASSERT([Addresses]creationDate#!00-00-00!)
AJ_assert($test; [Addresses:147]creationDate:19#!00-00-00!; True:C214; "any record in table"; "have a creation date")
//ASSERT([Addresses]creationTime#Time("00:00:00"))
AJ_assert($test; [Addresses:147]creationTime:22#Time:C179("00:00:00"); True:C214; "any record in table"; " have a cretion time")

READ WRITE:C146([Addresses:147])
If (Records in selection:C76([Addresses:147])=1)
	DELETE RECORD:C58([Addresses:147])
End if 

