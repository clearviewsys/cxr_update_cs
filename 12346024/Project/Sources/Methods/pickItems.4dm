//%attributes = {}
// pickItems (->self; forceDialog)
// picks an item

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $forceDialog)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$forceDialog:=False:C215
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$forceDialog:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickRecordForTable(->[Items:39]; ->[Items:39]ItemID:1; $fieldPtr; False:C215; $forceDialog)

