//%attributes = {}
// getTablePtrFromFieldPtr (->fieldPtr)

C_POINTER:C301($fieldPtr; $tablePtr; $1; $0)
C_TEXT:C284($temp)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Customers:3]FullName:40
		
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($tableNum; $fieldNo)
RESOLVE POINTER:C394($fieldPtr; $temp; $tableNum; $fieldNo)
$tablePtr:=Table:C252($tableNum)
ASSERT:C1129($tableNum>0; "Cannot resolve pointer to a table")
$0:=$tablePtr

