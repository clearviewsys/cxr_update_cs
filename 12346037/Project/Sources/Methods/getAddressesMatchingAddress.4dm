//%attributes = {}
//Amir 13th April 2020
//success <C_BOOLEAN> := GetAddressesMatchingAddress(addressObject <C_OBJECT> to find addresses near it: use NewAddress
//                                                               address entity selection <C_POINTER> : to store addresses (entity selection) that matches given address
//                                                                                                                           
C_OBJECT:C1216($addressObj; $1)
C_POINTER:C301($addressEntitySelectionPtr; $2)
C_BOOLEAN:C305($success; $0)
$addressObj:=$1
$addressEntitySelectionPtr:=$2

If (Count parameters:C259#2)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

validateAddressObject($addressObj)
ASSERT:C1129(Type:C295($addressEntitySelectionPtr)=Is pointer:K8:14)
ASSERT:C1129(Type:C295($addressEntitySelectionPtr->)=Is object:K8:27)

$success:=True:C214

C_OBJECT:C1216($addressHashObj)
$addressHashObj:=getAddressHash($addressObj)
READ ONLY:C145([Addresses:147])
//#TODO: use the ORDA queries in version 18 https://blog.4d.com/more-sophisticated-orda-queries-with-formulas/

//#ORDA
//finding exact matches
QUERY:C277([Addresses:147]; [Addresses:147]HashWithStreetAddress:16=$addressHashObj.hashForExactMatch)
ARRAY TEXT:C222($addressIds; 0)
SELECTION TO ARRAY:C260([Addresses:147]UUID:2; $addressIds)
C_COLLECTION:C1488($addressIdCollection)
$addressIdCollection:=New collection:C1472
ARRAY TO COLLECTION:C1563($addressIdCollection; $addressIds)
$addressEntitySelectionPtr->:=New object:C1471
$addressEntitySelectionPtr->:=ds:C1482.Addresses.query("UUID in :1"; $addressIdCollection)

$0:=$success

