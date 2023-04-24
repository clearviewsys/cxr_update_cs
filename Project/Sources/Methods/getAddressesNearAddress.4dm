//%attributes = {}
//Amir 13th April 2020
//success <C_BOOLEAN> := GetAddressesNearAddress(addressObject <C_OBJECT> to find addresses near it: use NewAddress
//                                                               address entity selection <C_POINTER> : to store addresses (entity selection) near given address
//                                                               error object <C_OBJECT> : to store error from Google API or other error message
//                                                               [optional] search radius <C_REAL>: value above or equal to 1000m is recommended)
// Unit test is written


C_OBJECT:C1216($addressObj; $1)
C_POINTER:C301($addressEntitySelectionPtr; $2)
C_OBJECT:C1216($errorObj; $3)
C_BOOLEAN:C305($success; $0)
$addressObj:=$1
$addressEntitySelectionPtr:=$2
$errorObj:=$3
C_REAL:C285($searchRadius)
Case of 
	: (Count parameters:C259=3)
		$searchRadius:=Num:C11(getKeyValue("address.search.proximity.radius.in.meter"; "1000"))
	: (Count parameters:C259=4)
		C_REAL:C285($4)
		$searchRadius:=$4
		ASSERT:C1129(Type:C295($searchRadius)=Is real:K8:4; "Expected real number for search radius")
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

validateAddressObject($addressObj)
ASSERT:C1129(Type:C295($addressEntitySelectionPtr)=Is pointer:K8:14)
ASSERT:C1129(Type:C295($addressEntitySelectionPtr->)=Is object:K8:27)
ASSERT:C1129(Type:C295($errorObj)=Is object:K8:27)
ASSERT:C1129($errorObj#Null:C1517)
ASSERT:C1129($searchRadius>0)

//if lat (latitude) and lng (longitude) properties are not defined on address object, fetch them from google api
$success:=True:C214
If ((Not:C34(OB Is defined:C1231($addressObj; "lat"))) | (Not:C34(OB Is defined:C1231($addressObj; "lng"))))
	$success:=googleGeocodeAddressObj($addressObj; $errorObj)
End if 

If ($success=True:C214)
	C_OBJECT:C1216($addressHashObj)
	$addressHashObj:=getAddressHash($addressObj)
	READ ONLY:C145([Addresses:147])
	//#TODO: use the ORDA queries in version 18 https://blog.4d.com/more-sophisticated-orda-queries-with-formulas/
	
	//finding proximity matches
	
	QUERY:C277([Addresses:147]; [Addresses:147]HashWithoutStreetAddress:17=$addressHashObj.hashForProximity)
	QUERY SELECTION:C341([Addresses:147]; [Addresses:147]HashWithStreetAddress:16#$addressHashObj.hashForExactMatch)  //excluding exact matches from proximity search
	QUERY SELECTION BY FORMULA:C207([Addresses:147]; getCoordinateDistanceMath(Num:C11($addressObj.lat); Num:C11($addressObj.lng); [Addresses:147]Latitude:13; [Addresses:147]Longitude:14)<=Num:C11($searchRadius))
	ARRAY TEXT:C222($addressIds; 0)
	SELECTION TO ARRAY:C260([Addresses:147]UUID:2; $addressIds)
	C_COLLECTION:C1488($addressIdCollection)
	$addressIdCollection:=New collection:C1472
	ARRAY TO COLLECTION:C1563($addressIdCollection; $addressIds)
	//#ORDA
	$addressEntitySelectionPtr->:=ds:C1482.Addresses.query("UUID in :1"; $addressIdCollection)
	
	
End if 
$0:=$success
