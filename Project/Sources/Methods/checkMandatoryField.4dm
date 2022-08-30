//%attributes = {}
// checkMandatoryField (->field; {strict=true}; {$fieldName})
// Checks if a field is Mandatory
// i.e: checkMandatoryField (->[Invoices]CustomerUID)
// Modified by Jaime Alvarez on 2/20/2017

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $isStrict)
C_TEXT:C284($3; $fieldName)

Case of 
	: (Count parameters:C259=1)
		
		$fieldPtr:=$1
		$isStrict:=True:C214
		$fieldName:=getLocalizedFieldName($fieldPtr)
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$isStrict:=$2
		$fieldName:=getLocalizedFieldName($fieldPtr)
		
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$isStrict:=$2
		$fieldName:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($fieldPtr->="")
	
	If ($isStrict)
		checkAddError($fieldName+"is Mandatory")
	Else 
		checkAddWarning("It is recommended to enter a value for "+$fieldName)  // It is recommended to enter a value for <X>.
	End if 
	
End if 