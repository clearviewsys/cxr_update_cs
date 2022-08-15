//%attributes = {}
//Amir 19th April 2020
//finds customers that are within search proximity of given address
//success <C_BOOLEAN> := getCustomersNearAddress(address object <C_OBJECT> to match customers against it : use newAddress method
//                                               customer entity selection <C_POINTER> : to store results
//                                               error object <C_OBJECT> : to store error from Google API or other error
//                                               [optional] search radius for proximity <C_REAL> : value above or equal to 1000m is recommended )

// Unit test is written

C_OBJECT:C1216($addressObj; $1)
C_POINTER:C301($customerEntitySelectionPtr; $2)
C_OBJECT:C1216($errorObj; $3)

$addressObj:=$1
$customerEntitySelectionPtr:=$2
$errorObj:=$3

C_BOOLEAN:C305($success; $0)

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
ASSERT:C1129(Type:C295($customerEntitySelectionPtr)=Is pointer:K8:14)
ASSERT:C1129(Type:C295($customerEntitySelectionPtr->)=Is object:K8:27)
ASSERT:C1129(Type:C295($errorObj)=Is object:K8:27)
ASSERT:C1129($errorObj#Null:C1517)
ASSERT:C1129($searchRadius>0)

C_OBJECT:C1216($addressSearchEntitySelection)
$success:=True:C214
$success:=getAddressesNearAddress($addressObj; ->$addressSearchEntitySelection; $errorObj; $searchRadius)
//#ORDA
If ($success=True:C214)
	C_LONGINT:C283($customersTableNo)
	$customersTableNo:=Table:C252(->[Customers:3])
	
	//finding customers matching address proximity
	C_COLLECTION:C1488($customerIDs)
	$customerIDs:=$addressSearchEntitySelection.query("TableNo = :1"; $customersTableNo).RecordID  //getting [Customers]CustomerID
	$customerEntitySelectionPtr->:=ds:C1482.Customers.query("CustomerID in :1"; $customerIDs)
End if 

$0:=$success

