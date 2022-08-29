//%attributes = {}
// assertFieldType_BLOB (->[table] ; ->[field] )
// assert the field is of type BLOB

C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_LONGINT:C283($fieldType)
C_TEXT:C284($errorMsg)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Registers:10]
		$fieldPtr:=->[Registers:10]_Sync_Data:55
		$fieldType:=Is BLOB:K8:12
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
		$fieldType:=Is BLOB:K8:12
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

