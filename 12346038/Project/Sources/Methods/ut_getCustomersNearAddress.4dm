//%attributes = {"shared":true}
// __UNIT_TEST
// Jan 2021 

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getCustomerNearAddress"; Current method name:C684; "API.GoogleMap")



//test method for getCustomersNearAddress

C_OBJECT:C1216($testCustomersES)
//#ORDA
$testCustomersES:=ds:C1482.Customers.all().slice(0; 2)  //find two random customers

C_TEXT:C284($countryCode; $province; $city; $postalCode; $streetAddress1; $unitNumber1; $streetAddress2; $unitNumber2)
$countryCode:="CA"
$province:="BC"
$city:="Vancouver"
$postalCode:="V7L 1P2"
$streetAddress1:="165 6th st e"
$streetAddress2:="141 6th st e"
$unitNumber1:="101"
$unitNumber2:="102"

C_OBJECT:C1216($addressObj1)
$addressObj1:=newAddress($countryCode; $province; $city; $postalCode; $streetAddress1; $unitNumber1)

START TRANSACTION:C239

C_LONGINT:C283($customersTableNo)
$customersTableNo:=Table:C252(->[Customers:3])

CREATE RECORD:C68([Addresses:147])  //first test address
[Addresses:147]CountryCode:7:=$countryCode
[Addresses:147]City:4:=$city
[Addresses:147]ZipCode:6:=$postalCode
[Addresses:147]Address:3:=$addressObj1.streetAddress
[Addresses:147]UnitNo:15:=$addressObj1.unit
[Addresses:147]Latitude:13:=49.314715
[Addresses:147]Longitude:14:=-123.072606
[Addresses:147]TableNo:8:=$customersTableNo
[Addresses:147]RecordID:9:=$testCustomersES[0].CustomerID  //address for first customer
SAVE RECORD:C53([Addresses:147])

C_COLLECTION:C1488($IdOfAddressesToDeleteCol)
$IdOfAddressesToDeleteCol:=New collection:C1472
$IdOfAddressesToDeleteCol.push([Addresses:147]UUID:2)

C_OBJECT:C1216($addressObj2)
$addressObj2:=newAddress($countryCode; $province; $city; $postalCode; $streetAddress2; $unitNumber2)

CREATE RECORD:C68([Addresses:147])
[Addresses:147]CountryCode:7:=$countryCode
[Addresses:147]City:4:=$city
[Addresses:147]ZipCode:6:=$postalCode
[Addresses:147]Address:3:=$addressObj2.streetAddress
[Addresses:147]UnitNo:15:=$addressObj2.unit
[Addresses:147]Latitude:13:=49.315002
[Addresses:147]Longitude:14:=-123.073242
[Addresses:147]TableNo:8:=$customersTableNo
[Addresses:147]RecordID:9:=$testCustomersES[1].CustomerID  //address for second customer
SAVE RECORD:C53([Addresses:147])

$IdOfAddressesToDeleteCol.push([Addresses:147]UUID:2)

C_OBJECT:C1216($customerResultES)

getCustomersMatchingAddress($addressObj1; ->$customerResultES)
//ASSERT($customerResultES.length=1;"Expected to find one customer")
C_TEXT:C284($given)
$given:="given the address"+JSON Stringify:C1217($addressObj1)
AJ_assert($test; $customerResultES.length; 1; $given; "101- Expected to find one customer")


//ASSERT($customerResultES.first().CustomerID=$testCustomersES[0].CustomerID;"Expected to find the first customer")
AJ_assert($test; $customerResultES.first().CustomerID; $testCustomersES[0].CustomerID; $given; "102- Expected to find the first customer")

C_BOOLEAN:C305($success)
$success:=getCustomersNearAddress($addressObj1; ->$customerResultES; New object:C1471)  //not caring about errors
//ASSERT($success=True;"Expected true for success")
AJ_assert($test; $success; True:C214; $given; "103- Expected true for success")

//ASSERT($customerResultES.length=1;"Expected to find one customer")
AJ_assert($test; $customerResultES.length; 1; $given; "104- Expected to find one customer")

getCustomersMatchingAddress($addressObj2; ->$customerResultES)
//ASSERT($customerResultES.length=1;"Expected to find one customer")
C_TEXT:C284($given)
$given:="given the address"+JSON Stringify:C1217($addressObj2)
//ASSERT($customerResultES.first().CustomerID=$testCustomersES[1].CustomerID;"Expected to find the second customer")
AJ_assert($test; $customerResultES.last().CustomerID; $testCustomersES[1].CustomerID; $given; "105- Expected to find the second customer")

//ASSERT($customerResultES.first().CustomerID=$testCustomersES[1].CustomerID;"Expected to find the second customer")
AJ_assert($test; $customerResultES.last().CustomerID; $testCustomersES[1].CustomerID; $given; "106- Expected to find the second customer")

CANCEL TRANSACTION:C241


////delete the test records
//READ WRITE([Addresses])
//QUERY([Addresses];[Addresses]UUID=$IdOfAddressesToDeleteCol[0])
//If (Records in selection([Addresses])=1)
//DELETE RECORD([Addresses])
//End if 

//QUERY([Addresses];[Addresses]UUID=$IdOfAddressesToDeleteCol[1])
//If (Records in selection([Addresses])=1)
//DELETE RECORD([Addresses])
//End if 







