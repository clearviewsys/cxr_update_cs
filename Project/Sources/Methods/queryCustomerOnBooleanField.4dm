//%attributes = {}
// queryCustomerOnBooleanField (->field; booleanValue; onSelection)

C_POINTER:C301($fieldPtr; $1)
C_BOOLEAN:C305($bool; $2; $onSelection; $3)

$bool:=True:C214
$onSelection:=False:C215

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Customers:3]isAccount:34
		
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$bool:=$2
		
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$bool:=$2
		$onSelection:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($onSelection)
	QUERY SELECTION:C341([Customers:3]; $fieldPtr->=$bool)
Else 
	QUERY:C277([Customers:3]; $fieldPtr->=$bool)
End if 

//orderbyCustomers