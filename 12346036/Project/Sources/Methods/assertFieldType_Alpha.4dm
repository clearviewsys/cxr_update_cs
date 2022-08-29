//%attributes = {}
// assertFieldType_Alpha (->[table] ; ->[field]  {;length {;indexed {;isUnique}}})
// assert the field is of type alpha (with length {indexed {unique}}})


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_LONGINT:C283($length; $3)
C_BOOLEAN:C305($isIndexed; $4)
C_BOOLEAN:C305($isUnique; $5)

C_TEXT:C284($errorMsg)

Case of 
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
		assertFieldType($tablePtr; $fieldPtr; Is alpha field:K8:1)
		
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$length:=$3
		assertFieldType($tablePtr; $fieldPtr; Is alpha field:K8:1; $length)
		
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$fieldPtr:=$2
		$length:=$3
		$isIndexed:=$4
		assertFieldType($tablePtr; $fieldPtr; Is alpha field:K8:1; $length; $isIndexed)
		
	: (Count parameters:C259=5)
		$tablePtr:=$1
		$fieldPtr:=$2
		$length:=$3
		$isIndexed:=$4
		$isUnique:=$5
		assertFieldType($tablePtr; $fieldPtr; Is alpha field:K8:1; $length; $isIndexed; $isUnique)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

