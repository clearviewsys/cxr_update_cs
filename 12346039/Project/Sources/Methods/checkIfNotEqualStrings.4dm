//%attributes = {}
// checkIfNotEqualStrings (->field1Ptr; ->field2Ptr; fieldTitle; {$isStrict})
// Check if two string are identical

C_POINTER:C301($1; field1Ptr; $2; field2Ptr)
C_TEXT:C284($3; $fieldTitle)
C_BOOLEAN:C305($4; $isStrict)

Case of 
	: (Count parameters:C259=2)
		
		field1Ptr:=$1
		field2Ptr:=$2
		fieldTitle:="Field"
		$isStrict:=True:C214
		
	: (Count parameters:C259=3)
		
		field1Ptr:=$1
		field2Ptr:=$2
		fieldTitle:=$3
		$isStrict:=True:C214
		
		
	: (Count parameters:C259=4)
		field1Ptr:=$1
		field2Ptr:=$2
		fieldTitle:=$3
		$isStrict:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (field1Ptr->#field2Ptr->)
	If ($isStrict)
		checkAddError(fieldTitle+" don't match.")
	Else 
		checkAddWarning(fieldTitle+" don't match.")
	End if 
End if 

