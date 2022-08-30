//%attributes = {}
// getFieldPointer ($tablePtr; $fieldName)

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $fieldName)
C_POINTER:C301($0; $fieldPointer)

Case of 
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldName:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($field; $fieldNum)
$fieldNum:=0

ARRAY TEXT:C222($arrFields; Get last field number:C255($tablePtr))

For ($field; 1; Size of array:C274($arrFields))
	
	If (Is field number valid:C1000($tablePtr; $field))
		
		If (Field name:C257(Table:C252($tablePtr); $field)=$fieldName)
			$fieldNum:=$field
			$field:=Size of array:C274($arrFields)+1000  // Exit loop
		End if 
	End if 
	
End for 

// Check Again if it is a Valid Field
If (Is field number valid:C1000($tablePtr; $fieldNum))
	$fieldPointer:=Field:C253(Table:C252($tablePtr); $fieldNum)
Else 
	$fieldPointer:=Null:C1517
End if 

$0:=$fieldPointer


// getFieldPointer ($tablePtr; $fieldName)

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $fieldName)
C_POINTER:C301($0; $fieldPointer)

Case of 
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldName:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($field; $fieldNum)
$fieldNum:=0

ARRAY TEXT:C222($arrFields; Get last field number:C255($tablePtr))

For ($field; 1; Size of array:C274($arrFields))
	
	If (Is field number valid:C1000($tablePtr; $field))
		
		If (Field name:C257(Table:C252($tablePtr); $field)=$fieldName)
			$fieldNum:=$field
			$field:=Size of array:C274($arrFields)+1000  // Exit loop
		End if 
	End if 
	
End for 

// Check Again if it is a Valid Field
If (Is field number valid:C1000($tablePtr; $fieldNum))
	$fieldPointer:=Field:C253(Table:C252($tablePtr); $fieldNum)
Else 
	$fieldPointer:=Null:C1517
End if 

$0:=$fieldPointer