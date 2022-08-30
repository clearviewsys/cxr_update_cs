//%attributes = {}
//author Amir 12th April 2020
//constructor for address, returns an address object
//address object <C_OBJECT> := newAddress(CountryCode <C_TEXT>, Province <C_TEXT>, City <C_TEXT>, ZipCode <C_TEXT>, Street Address <C_TEXT>, Unit <C_TEXT>
// Unit test is written, however not complete

C_TEXT:C284($countryCode; $1)
C_TEXT:C284($province; $2)
C_TEXT:C284($city; $3)
C_TEXT:C284($zipCode; $4)
C_TEXT:C284($streetAddress; $5)
C_TEXT:C284($unit; $6)
C_OBJECT:C1216($addressObj; $0)

If (Count parameters:C259=6)
	$countryCode:=$1
	$province:=$2
	$city:=$3
	$zipCode:=$4
	$streetAddress:=$5
	$unit:=$6
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

//removed asserts on input validation since this method is called in trigger

$addressObj:=New object:C1471
$addressObj.countryCode:=$countryCode
$addressObj.province:=$province
$addressObj.city:=$city
$addressObj.zipCode:=$zipCode
$addressObj.streetAddress:=$streetAddress
$addressObj.unit:=$unit

$0:=$addressObj

