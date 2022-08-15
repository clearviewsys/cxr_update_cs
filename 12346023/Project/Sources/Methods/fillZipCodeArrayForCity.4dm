//%attributes = {}
// fills an array of zipcodes for the current selected city

// fillZipCodeArrayForCity(->array; {cityName})

C_POINTER:C301($arrPtr; $1)
C_TEXT:C284($city; $2; $key)
$arrPtr:=$1

Case of 
	: (Count parameters:C259=1)
		$city:=[Cities:60]CityName:1
	: (Count parameters:C259=2)
		$city:=$2
		QUERY:C277([Cities:60]; [Cities:60]CityName:1=$city)
		
End case 
$key:=[Cities:60]LastLineKey:3
QUERY:C277([ZipCodes:63]; [ZipCodes:63]LastLineKey:1=$key)  // find all the zip codes with the common lastlineKey

// fill in the array
If (Records in selection:C76([ZipCodes:63])>0)
	DISTINCT VALUES:C339([ZipCodes:63]ZipCode:2; $arrPtr->)  // fill in the array
	$arrPtr->:=1
	
End if 
