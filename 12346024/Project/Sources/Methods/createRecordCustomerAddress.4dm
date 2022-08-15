//%attributes = {}
//Amir 18th May 2020
//$addressId:=createRecordCustomerAddress([Customers]CustomerID;$addressType;$suiteNumber;$streetAddress;$postalCode;$city;$province;$countryCode (2 digit);[optional] $latitude;[optional] $longitude)

C_TEXT:C284($customerId; $1)
C_TEXT:C284($addressType; $2)
C_TEXT:C284($suiteNumber; $3)
C_TEXT:C284($streetAddress; $4)
C_TEXT:C284($postalCode; $5)
C_TEXT:C284($city; $6)
C_TEXT:C284($province; $7)
C_TEXT:C284($countryCode; $8)

$customerId:=$1
$addressType:=$2
$suiteNumber:=$3
$streetAddress:=$4
$postalCode:=$5
$city:=$6
$province:=$7
$countryCode:=$8

Case of 
	: (Count parameters:C259=10)
		C_REAL:C285($latitude; $9; $longitude; $10)
		$latitude:=$9
		$longitude:=$10
End case 

If ((Count parameters:C259#8) & (Count parameters:C259#10))
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

C_TEXT:C284($0)  //addressId

Case of 
	: (Count parameters:C259=8)
		$0:=createRecordAddress(->[Customers:3]; $customerId; $addressType; $suiteNumber; $streetAddress; $postalCode; $city; $province; $countryCode)
	: (Count parameters:C259=10)
		$0:=createRecordAddress(->[Customers:3]; $customerId; $addressType; $suiteNumber; $streetAddress; $postalCode; $city; $province; $countryCode; $latitude; $longitude)
End case 


