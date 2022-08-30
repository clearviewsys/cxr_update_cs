//%attributes = {}
// assertField_Sync_Exception (->[table]; ->[field])


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Accounts:9]
		$fieldPtr:=->[Accounts:9]_Sync_Exception:30
		
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

// do not change the order of the following two assertions. First we need to make sure the name of the field is correct
// before checking the standard length of this field. 

ASSERT:C1129((Field name:C257($fieldPtr)="_Sync_Exception"); "Field name for _Sync_Exception is incorrect :"+Field name:C257($fieldPtr))
assertFieldType_boolean($tablePtr; $fieldPtr)

