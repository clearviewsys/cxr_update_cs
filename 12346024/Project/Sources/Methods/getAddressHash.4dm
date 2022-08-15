//%attributes = {}
//author: Amir
//6th April 2020
//returns address hash which is used for address matching and proximity search
//hash object <C_OBJECT> := getAddressHash(address object <C_OBJECT>: use NewAddress method

// Unit test is written

C_OBJECT:C1216($addressObj; $1)
C_OBJECT:C1216($0; $addressHashObj)
$addressObj:=$1
If (Count parameters:C259#1)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 


$addressHashObj:=New object:C1471
$addressHashObj.hashForProximity:=Generate digest:C1147(Uppercase:C13(String:C10($addressObj.countryCode+$addressObj.city+$addressObj.zipCode)); MD5 digest:K66:1)
$addressHashObj.hashForExactMatch:=Generate digest:C1147(Uppercase:C13(String:C10($addressObj.countryCode+$addressObj.city+$addressObj.zipCode+$addressObj.streetAddress+$addressObj.unit)); MD5 digest:K66:1)

$0:=$addressHashObj
