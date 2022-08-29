//%attributes = {}
//Amir 19th April 2020
//for given address, it finds customers having that address
//success <C_BOOLEAN> := GetCustomersMatchingAddress(address object <C_OBJECT> to match customers against it : use NewAddress method
//                                               customer entity selection <C_POINTER> : to store results

C_OBJECT:C1216($addressObj; $1)
C_POINTER:C301($customerEntitySelectionPtr; $2)
C_BOOLEAN:C305($success; $0)

If (Count parameters:C259#2)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

$addressObj:=$1
$customerEntitySelectionPtr:=$2

validateAddressObject($addressObj)
ASSERT:C1129(Type:C295($customerEntitySelectionPtr)=Is pointer:K8:14)
ASSERT:C1129(Type:C295($customerEntitySelectionPtr->)=Is object:K8:27)

C_OBJECT:C1216($addressSearchEntitySelection)
$success:=True:C214
getAddressesMatchingAddress($addressObj; ->$addressSearchEntitySelection)
//#ORDA

C_LONGINT:C283($customersTableNo)
$customersTableNo:=Table:C252(->[Customers:3])

//finding customers matching address exactly
C_COLLECTION:C1488($customerIDs)
$customerIDs:=$addressSearchEntitySelection.query("TableNo = :1"; $customersTableNo).RecordID  //getting [Customers]CustomerID
$customerEntitySelectionPtr->:=ds:C1482.Customers.query("CustomerID in :1"; $customerIDs)
$0:=$success

