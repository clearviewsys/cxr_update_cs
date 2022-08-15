//%attributes = {"shared":true}

// __UNIT_TEST
// Jan 2021
C_OBJECT:C1216($test)

$test:=AJ_UnitTest.new("getAddressProximity"; Current method name:C684; "API.GoogleMap")

START TRANSACTION:C239

//create a test address and delete them after the test
C_TEXT:C284($countryCode; $province; $city; $postalCode; $streetAddress; $unitNumber)
$countryCode:="CA"
$province:="BC"
$city:="Vancouver"
$postalCode:="V5V 3J4"
$streetAddress:="123 test street"
$unitNumber:="100"
C_REAL:C285($latitude; $longitude)
$latitude:=49.276879
$longitude:=-123.121688

C_OBJECT:C1216($addressObject)
$addressObject:=newAddress($countryCode; $province; $city; $postalCode; $streetAddress; $unitNumber)
C_OBJECT:C1216($hashObj)
$hashObj:=getAddressHash($addressObject)
//creating test record which will be deleted at the end
CREATE RECORD:C68([Addresses:147])
[Addresses:147]CountryCode:7:=$countryCode
[Addresses:147]City:4:=$city
[Addresses:147]ZipCode:6:=$postalCode
[Addresses:147]Address:3:=$streetAddress
[Addresses:147]UnitNo:15:=$unitNumber
[Addresses:147]Latitude:13:=$latitude
[Addresses:147]Longitude:14:=$longitude
[Addresses:147]HashWithStreetAddress:16:=$hashObj.hashForExactMatch
[Addresses:147]HashWithoutStreetAddress:17:=$hashObj.hashForProximity
SAVE RECORD:C53([Addresses:147])

C_TEXT:C284($IdOfAddressToDelete)
$IdOfAddressToDelete:=[Addresses:147]UUID:2


$addressObject:=newAddress($countryCode; $province; $city; $postalCode; "another street"; "another unit number")
$addressObject.lat:=$latitude+0.005
$addressObject.lng:=$longitude+0.005

C_OBJECT:C1216($addressSearchResultObj)
C_BOOLEAN:C305($success)
$success:=getAddressesMatchingAddress($addressObject; ->$addressSearchResultObj)
C_TEXT:C284($given)
$given:=JSON Stringify:C1217($addressObject)
//ASSERT($addressSearchResultObj.length=0;"Expected to find zero exact address match")
AJ_assert($test; $addressSearchResultObj.length; 0; $given; "Expected to find zero exact address match")


$success:=getAddressesNearAddress($addressObject; ->$addressSearchResultObj; New object:C1471)  //not caring about error obj
//ASSERT($success=True;"Expected true for success")
AJ_assert($test; $success; True:C214; $given; "Expected true for success")

//ASSERT($addressSearchResultObj.length=1;"Expected to find one nearby address")
AJ_assert($test; $addressSearchResultObj.length; 1; $given; "Expected to find one nearby match")


//#ORDA
//ASSERT($addressSearchResultObj.first().UUID=$IdOfAddressToDelete;"Expected IDs to match")
AJ_assert($test; $addressSearchResultObj.first().UUID; $IdOfAddressToDelete; $given; "Expected IDs to match")

$addressObject:=newAddress($countryCode; $province; $city; $postalCode; $streetAddress; $unitNumber)  //matches saved record exactly
$addressObject.lat:=$latitude
$addressObject.lng:=$longitude
$success:=getAddressesMatchingAddress($addressObject; ->$addressSearchResultObj)
//ASSERT($addressSearchResultObj.length=1;"Expected to find one exact address match")
$given:="Calling getAddressMatchingAddress with address"+JSON Stringify:C1217($addressObject)
AJ_assert($test; $addressSearchResultObj.length; 1; $given; "Expected 1 exact match")

//ASSERT($addressSearchResultObj.first().UUID=$IdOfAddressToDelete;"Expected IDs to match")
$given:="Calling getAddressMatchingAddress with address"+JSON Stringify:C1217($addressObject)
AJ_assert($test; $addressSearchResultObj.first().UUID; $IdOfAddressToDelete; $given; "Expected IDs to  match")

$success:=getAddressesNearAddress($addressObject; ->$addressSearchResultObj; New object:C1471)  //not caring about error obj
//ASSERT($success=True;"Expected true for success")
$given:="getAddressesNearAddress with "+JSON Stringify:C1217($addressObject)
AJ_assert($test; $success; True:C214; $given; "Expected true for success")

//ASSERT($addressSearchResultObj.length=0;"Expected to find zero nearby address")
AJ_assert($test; $addressSearchResultObj.length; 0; $given; "Expected to find zero nearby address")

CANCEL TRANSACTION:C241

//delete the test record
//READ WRITE([Addresses])
//QUERY([Addresses];[Addresses]UUID=$IdOfAddressToDelete)
//If (Records in selection([Addresses])=1)
//DELETE RECORD([Addresses])
//End if 

