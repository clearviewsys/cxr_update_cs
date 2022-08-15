//%attributes = {}
//QUERY([Customers];[Customers]CustomerID="CUS2065074")

//test method for checkCustomerForRelations



//TEST PRECONDITION
Case of 
	: (getKeyValue("check.same.location.same.lastname"; "false")#"true")
		ASSERT:C1129(False:C215; "key value check.same.location.same.lastname should be set to true for this test")
		
	: (getKeyValue("check.same.location.different.lastname"; "false")#"true")
		ASSERT:C1129(False:C215; "key value check.same.location.different.lastname should be set to true for this test")
		
	: (getKeyValue("check.close.location.same.lastname"; "false")#"true")
		ASSERT:C1129(False:C215; "key value check.close.location.same.lastname should be set to true for this test")
End case 


//TEST SETUP
//John Smith: main customer record
C_TEXT:C284($customerUuid; $customerId)
C_TEXT:C284($otherCustomerUuid; $otherCustomerId)
C_TEXT:C284($thirdCustomerUuid; $thirdCustomerId)

$customerId:="CUS123456789"
CREATE RECORD:C68([Customers:3])
[Customers:3]FirstName:3:="John"
[Customers:3]LastName:4:="Smith"
[Customers:3]CustomerID:1:=$customerId
SAVE RECORD:C53([Customers:3])
$customerUuid:=[Customers:3]UUID:112

//James Smith
$otherCustomerId:="CUS100200300"
CREATE RECORD:C68([Customers:3])
[Customers:3]FirstName:3:="James"
[Customers:3]LastName:4:="Smith"
[Customers:3]CustomerID:1:=$otherCustomerId
SAVE RECORD:C53([Customers:3])
$otherCustomerUuid:=[Customers:3]UUID:112

//Mike Brown
$thirdCustomerId:="CUS400500600"
CREATE RECORD:C68([Customers:3])
[Customers:3]FirstName:3:="Mike"
[Customers:3]LastName:4:="Brown"
[Customers:3]CustomerID:1:=$thirdCustomerId
SAVE RECORD:C53([Customers:3])
$thirdCustomerUuid:=[Customers:3]UUID:112

C_COLLECTION:C1488($addressUuidToDeleteCollection)
$addressUuidToDeleteCollection:=New collection:C1472

//one address for John Smith
CREATE RECORD:C68([Addresses:147])
[Addresses:147]TableNo:8:=Table:C252(->[Customers:3])
[Addresses:147]RecordID:9:=$customerId
[Addresses:147]Address:3:="123 somewhere testing street"
[Addresses:147]UnitNo:15:="1"
[Addresses:147]City:4:="city"
[Addresses:147]CountryCode:7:="CA"
[Addresses:147]ZipCode:6:="VVVVVV1"
SAVE RECORD:C53([Addresses:147])
$addressUuidToDeleteCollection.push([Addresses:147]UUID:2)

//another address for John Smith
CREATE RECORD:C68([Addresses:147])
[Addresses:147]TableNo:8:=Table:C252(->[Customers:3])
[Addresses:147]RecordID:9:=$customerId
[Addresses:147]Address:3:="456 somewhere else testing street"
[Addresses:147]UnitNo:15:="2"
[Addresses:147]City:4:="another city"
[Addresses:147]CountryCode:7:="CA"
[Addresses:147]ZipCode:6:="VVVVVV2"
SAVE RECORD:C53([Addresses:147])
$addressUuidToDeleteCollection.push([Addresses:147]UUID:2)

//one address for James Smith: same location as John Smith
CREATE RECORD:C68([Addresses:147])
[Addresses:147]TableNo:8:=Table:C252(->[Customers:3])
[Addresses:147]RecordID:9:=$otherCustomerId
[Addresses:147]Address:3:="123 somewhere testing street"
[Addresses:147]UnitNo:15:="1"
[Addresses:147]City:4:="city"
[Addresses:147]CountryCode:7:="CA"
[Addresses:147]ZipCode:6:="VVVVVV1"
SAVE RECORD:C53([Addresses:147])
$addressUuidToDeleteCollection.push([Addresses:147]UUID:2)

//another address for James Smith: close location to John Smith, same last name
CREATE RECORD:C68([Addresses:147])
[Addresses:147]TableNo:8:=Table:C252(->[Customers:3])
[Addresses:147]RecordID:9:=$otherCustomerId
[Addresses:147]Address:3:="4646 somewhere in the map"
[Addresses:147]UnitNo:15:="200"
[Addresses:147]City:4:="city"
[Addresses:147]CountryCode:7:="CA"
[Addresses:147]ZipCode:6:="VVVVVV1"
SAVE RECORD:C53([Addresses:147])
$addressUuidToDeleteCollection.push([Addresses:147]UUID:2)

//one address for Mike Brown: different lastname, same location as John Smith
CREATE RECORD:C68([Addresses:147])
[Addresses:147]TableNo:8:=Table:C252(->[Customers:3])
[Addresses:147]RecordID:9:=$thirdCustomerId
[Addresses:147]Address:3:="123 somewhere testing street"
[Addresses:147]UnitNo:15:="1"
[Addresses:147]City:4:="city"
[Addresses:147]CountryCode:7:="CA"
[Addresses:147]ZipCode:6:="VVVVVV1"
SAVE RECORD:C53([Addresses:147])
$addressUuidToDeleteCollection.push([Addresses:147]UUID:2)

//TEST ACTION
QUERY:C277([Customers:3]; [Customers:3]UUID:112=$customerUuid)
checkCustomerForRelations

//TEST ASSERT
//#ORDA
C_OBJECT:C1216($relationsEs)
$relationsEs:=ds:C1482.Relations.query("customerID = :1 and toCustomerID = :2 and relationType = :3"; $customerId; $otherCustomerId; "same.location.same.lastname")
ASSERT:C1129($relationsEs.length=1; "Expected one relation between two customers")

$relationsEs:=ds:C1482.Relations.query("customerID = :1 and toCustomerID = :2 and relationType = :3"; $customerId; $otherCustomerId; "close.location.same.lastname")
ASSERT:C1129($relationsEs.length=1; "Expected one relation between two customers")

$relationsEs:=ds:C1482.Relations.query("customerID = :1 and toCustomerID = :2 and relationType = :3"; $customerId; $thirdCustomerId; "same.location.diff.lastname")
ASSERT:C1129($relationsEs.length=1; "Expected one relation between two customers")

//TEST CLEANUP
QUERY:C277([Customers:3]; [Customers:3]UUID:112=$customerUuid)
If (Records in selection:C76([Customers:3])=1)
	DELETE RECORD:C58([Customers:3])
End if 
QUERY:C277([Customers:3]; [Customers:3]UUID:112=$otherCustomerUuid)
If (Records in selection:C76([Customers:3])=1)
	DELETE RECORD:C58([Customers:3])
End if 
QUERY:C277([Customers:3]; [Customers:3]UUID:112=$thirdCustomerUuid)
If (Records in selection:C76([Customers:3])=1)
	DELETE RECORD:C58([Customers:3])
End if 

C_TEXT:C284($uuid)
For each ($uuid; $addressUuidToDeleteCollection)
	QUERY:C277([Addresses:147]; [Addresses:147]UUID:2=$uuid)
	If (Records in selection:C76([Addresses:147])=1)
		DELETE RECORD:C58([Addresses:147])
	End if 
End for each 

QUERY:C277([Relations:154]; [Relations:154]customerID:3=$customerId; *)
QUERY:C277([Relations:154];  & ; [Relations:154]toCustomerID:4=$otherCustomerId)
DELETE SELECTION:C66([Relations:154])

QUERY:C277([Relations:154]; [Relations:154]customerID:3=$customerId; *)
QUERY:C277([Relations:154];  & ; [Relations:154]toCustomerID:4=$thirdCustomerId)
DELETE SELECTION:C66([Relations:154])


