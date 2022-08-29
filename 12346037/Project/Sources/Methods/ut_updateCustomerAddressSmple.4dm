//%attributes = {"shared":true}
// __UNIT_TEST
// Dec 2020
//test method for updateCustomerAddressIDSimple
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("updateCustomerAddressSmple"; Current method name:C684; "Modules.Customers")

C_TEXT:C284($testCustomerID)

START TRANSACTION:C239
/*
CREATE RECORD([Customers])
[Customers]customerID:="AAA___"
[Customers]FirstName:="John"
[Customers]LastName:="Doe"
SAVE RECORD([Customers])

CREATE RECORD([Addresses])
[Addresses]RecordID:="AAA___"
[Addresses]TableNo:=Table(->[Customers])
[Address

SAVE RECORD([Addresses])

$testCustomerID:="AAA___"
*/
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)

AJ_assert($test; Records in selection:C76([Customers:3]); 1; "given custom ID "; "expect to find one customer matching")

//ASSERT(Records in selection([Customers])=1)

READ WRITE:C146([Addresses:147])
QUERY:C277([Addresses:147]; [Addresses:147]RecordID:9=$testCustomerID)

//-------------------------------
//test: if [Customers] record has no [Addresses] record, should create a new [Address] record
//-------------------------------
READ WRITE:C146([Customers:3])
[Customers:3]MainAddressID:147:=""
SAVE RECORD:C53([Customers:3])
UNLOAD RECORD:C212([Customers:3])

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressIDSimple"; False:C215)
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)

C_TEXT:C284($createdAddressID)
$createdAddressID:=[Customers:3]MainAddressID:147
//ASSERT($createdAddressID#"")
AJ_assert($test; $createdAddressID#""; True:C214; "A not null Address ID"; "confirm not null")

QUERY:C277([Addresses:147]; [Addresses:147]AddressID:18=$createdAddressID)

//ASSERT(Records in selection([Addresses])=1)
AJ_assert($test; Records in selection:C76([Addresses:147]); 1; "one address per address ID"; "Expected only one address")

//ASSERT([Addresses]Type="Main")
AJ_assert($test; [Addresses:147]Type:1; "Main"; "address type as "+"Main"; "return "+"Main")


//ASSERT([Addresses]CountryCode=[Customers]CountryCode)
AJ_assert($test; [Addresses:147]CountryCode:7; [Customers:3]CountryCode:113; "country code as "+[Customers:3]CountryCode:113; "return "+[Customers:3]CountryCode:113)

//ASSERT([Addresses]City=[Customers]City)
AJ_assert($test; [Addresses:147]City:4; [Customers:3]City:8; "city as "+[Customers:3]City:8; "return "+[Customers:3]City:8)

//ASSERT([Addresses]ZipCode=[Customers]PostalCode)
AJ_assert($test; [Addresses:147]ZipCode:6; [Customers:3]PostalCode:10; "zip/postal code as "+[Customers:3]PostalCode:10; "return "+[Customers:3]PostalCode:10)

//ASSERT([Addresses]State=[Customers]Province)
AJ_assert($test; [Addresses:147]State:5; [Customers:3]Province:9; "province as "+[Customers:3]Province:9; "return "+[Customers:3]Province:9)

//ASSERT([Addresses]Address=[Customers]Address)
AJ_assert($test; [Addresses:147]Address:3; [Customers:3]Address:7; "address as "+[Customers:3]Address:7; "return "+[Customers:3]Address:7)

//ASSERT([Addresses]UnitNo=[Customers]AddressUnitNo)
AJ_assert($test; [Addresses:147]UnitNo:15; [Customers:3]AddressUnitNo:148; "Unit No as "+[Customers:3]AddressUnitNo:148; "return "+[Customers:3]AddressUnitNo:148)

CANCEL TRANSACTION:C241