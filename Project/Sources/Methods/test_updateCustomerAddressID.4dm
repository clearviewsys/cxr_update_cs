//%attributes = {}
//test method for updateCustomerAddressID
C_TEXT:C284($testCustomerID)
$testCustomerID:="QSCUS1026010"

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
ASSERT:C1129(Records in selection:C76([Customers:3])=1)

//-------------------------------
//test: if [Customers] record has no [Addresses] record, should create a new [Address] record
//-------------------------------
READ WRITE:C146([Customers:3])
[Customers:3]MainAddressID:147:=""
SAVE RECORD:C53([Customers:3])
UNLOAD RECORD:C212([Customers:3])

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressID"; False:C215)
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)

C_TEXT:C284($createdAddressID)
$createdAddressID:=[Customers:3]MainAddressID:147
ASSERT:C1129($createdAddressID#"")

QUERY:C277([Addresses:147]; [Addresses:147]AddressID:18=$createdAddressID)
ASSERT:C1129(Records in selection:C76([Addresses:147])=1)
ASSERT:C1129([Addresses:147]Type:1="Main")
ASSERT:C1129([Addresses:147]CountryCode:7=[Customers:3]CountryCode:113)
ASSERT:C1129([Addresses:147]City:4=[Customers:3]City:8)
ASSERT:C1129([Addresses:147]ZipCode:6=[Customers:3]PostalCode:10)
ASSERT:C1129([Addresses:147]State:5=[Customers:3]Province:9)
C_OBJECT:C1216($splittedAddressAndUnit)
$splittedAddressAndUnit:=splitAddressToUnitAndStreet([Customers:3]Address:7)
ASSERT:C1129([Addresses:147]Address:3=$splittedAddressAndUnit.streetAddress)
ASSERT:C1129([Addresses:147]UnitNo:15=$splittedAddressAndUnit.unitNumber)

//-------------------------------
//test: if [Customers] address data has changed, it should create a new Main address and marke the old one as Old-Main
//-------------------------------
READ WRITE:C146([Customers:3])
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
C_TEXT:C284($previousStreetAddress; $previousUnitNumber)
C_OBJECT:C1216($splittedAddressAndUnit)
$splittedAddressAndUnit:=splitAddressToUnitAndStreet([Customers:3]Address:7)
$previousStreetAddress:=$splittedAddressAndUnit.streetAddress
$previousUnitNumber:=$splittedAddressAndUnit.unitNumber
[Customers:3]Address:7:="211 - 165 6th st e"
SAVE RECORD:C53([Customers:3])
UNLOAD RECORD:C212([Customers:3])

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressID"; False:C215)
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)

QUERY:C277([Addresses:147]; [Addresses:147]RecordID:9=$testCustomerID; *)
QUERY:C277([Addresses:147];  & ; [Addresses:147]TableNo:8=Table:C252(->[Customers:3]); *)
QUERY:C277([Addresses:147];  & ; [Addresses:147]Type:1="Main")
ASSERT:C1129(Records in selection:C76([Addresses:147])=1)
ASSERT:C1129([Customers:3]MainAddressID:147=[Addresses:147]AddressID:18)
ASSERT:C1129([Addresses:147]Address:3="165 6th st e")
C_TEXT:C284($recentAddressId)
$recentAddressId:=[Addresses:147]AddressID:18


QUERY:C277([Addresses:147];  & ; [Addresses:147]TableNo:8=Table:C252(->[Customers:3]); *)
QUERY:C277([Addresses:147];  & ; [Addresses:147]Type:1="Old-Main")
ASSERT:C1129(Records in selection:C76([Addresses:147])=1)
ASSERT:C1129([Addresses:147]Address:3=$previousStreetAddress)
ASSERT:C1129([Addresses:147]UnitNo:15=$previousUnitNumber)

//-------------------------------
//test: if nothing in [Customers] address data is changed, no new [Addresses] should be created
//-------------------------------
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressID"; False:C215)
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)

QUERY:C277([Addresses:147]; [Addresses:147]RecordID:9=$testCustomerID; *)
QUERY:C277([Addresses:147];  & ; [Addresses:147]TableNo:8=Table:C252(->[Customers:3]))
ASSERT:C1129(Records in selection:C76([Addresses:147])=2)

ASSERT:C1129([Customers:3]MainAddressID:147=$recentAddressId)

//-------------------------------
//cleanup: delete [Addresses] records, restore [Customers] record data
//-------------------------------
READ WRITE:C146([Customers:3])
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$testCustomerID)
[Customers:3]Address:7:=$previousUnitNumber+"-"+$previousStreetAddress
[Customers:3]MainAddressID:147:=""
SAVE RECORD:C53([Customers:3])
UNLOAD RECORD:C212([Customers:3])

READ WRITE:C146([Addresses:147])
QUERY:C277([Addresses:147]; [Addresses:147]RecordID:9=$testCustomerID; *)
QUERY:C277([Addresses:147];  & ; [Addresses:147]TableNo:8=Table:C252(->[Customers:3]))
If (Records in selection:C76([Addresses:147])=2)
	DELETE SELECTION:C66([Addresses:147])
End if 


SET QUERY LIMIT:C395(10)
QUERY:C277([Customers:3]; [Customers:3]CountryCode:113="US")
SET QUERY LIMIT:C395(0)
updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressID"; False:C215)