//%attributes = {}
//addressID:= createRecordAddress (->[tablePtr]; recordID; addressType; suite; street address; postalcode; city; province; country code (2 digit); [optional] latitude; [optional] longitude)
//creates address record for given table pointer and record id (for example customer). returns addressID

// Unit test is written

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($recordID; $2)
C_TEXT:C284($addressType; $3)
C_TEXT:C284($suiteNumber; $4)
C_TEXT:C284($streetAddress; $5)
C_TEXT:C284($postalCode; $6)
C_TEXT:C284($city; $7)
C_TEXT:C284($province; $8)
C_TEXT:C284($countryCode; $9)
C_TEXT:C284($0)

Case of 
	: (Count parameters:C259=9)
		$tablePtr:=$1
		$recordID:=$2
		$addressType:=$3
		$suiteNumber:=$4
		$streetAddress:=$5
		$postalCode:=$6
		$city:=$7
		$province:=$8
		$countryCode:=$9
		
	: (Count parameters:C259=11)
		$tablePtr:=$1
		$recordID:=$2
		$addressType:=$3
		$suiteNumber:=$4
		$streetAddress:=$5
		$postalCode:=$6
		$city:=$7
		$province:=$8
		$countryCode:=$9
		
		C_REAL:C285($latitude; $10; $longitude; $11)
		$latitude:=$10
		$longitude:=$11
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ WRITE:C146([Addresses:147])
CREATE RECORD:C68([Addresses:147])

C_TEXT:C284($addressID)
$addressID:=makeAddressID
[Addresses:147]AddressID:18:=$addressID
[Addresses:147]RecordID:9:=$recordID
[Addresses:147]TableNo:8:=Table:C252($tablePtr)  // returns the table number
[Addresses:147]Type:1:=$addressType
[Addresses:147]UnitNo:15:=$suiteNumber
[Addresses:147]Address:3:=$streetAddress
[Addresses:147]ZipCode:6:=$postalCode
[Addresses:147]City:4:=$city
[Addresses:147]State:5:=$province
[Addresses:147]CountryCode:7:=$countryCode
[Addresses:147]isActive:20:=True:C214

If (Count parameters:C259=11)
	[Addresses:147]Latitude:13:=$latitude
	[Addresses:147]Longitude:14:=$longitude
End if 

SAVE RECORD:C53([Addresses:147])
UNLOAD RECORD:C212([Addresses:147])


//----------using # ORDA
//C_TEXT($addressID)
//C_OBJECT($addressObj)
//$addressObj:=ds.Addresses.new()
//$addressID:=makeAddressID 
//$addressObj.AddressID:=$addressID
//$addressObj.RecordID:=$recordID
//$addressObj.TableNo:=Table($tablePtr)  // returns the table number
//$addressObj.Type:=$addressType
//$addressObj.UnitNo:=$suiteNumber
//$addressObj.Address:=$streetAddress
//$addressObj.ZipCode:=$postalCode
//$addressObj.City:=$city
//$addressObj.State:=$province
//$addressObj.CountryCode:=$countryCode
//$addressObj.isActive:=True

//If (Count parameters=11)
//$addressObj.Latitude:=$latitude
//$addressObj.Longitude:=$longitude
//End if 

//$addressObj.save()

$0:=$addressID