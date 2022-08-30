//%attributes = {}
// checkIfStringLengthIsLT (->field; length; {isStrict=true}; {fieldTitle})
// Check if string length is less than N 
// i.e: checkIfStringLengthIsLT (->[Customers]Name;80)
// Created by JA on Feb 24/2017

C_POINTER:C301($1; $fieldPtr)
C_LONGINT:C283($2; $length)
C_BOOLEAN:C305($isStrict; $3)
C_TEXT:C284($4; $fieldTitle)


Case of 
	: (Count parameters:C259=2)
		
		$fieldPtr:=$1
		$length:=$2
		$isStrict:=True:C214
		$fieldTitle:=getLocalizedFieldName($1)
		
	: (Count parameters:C259=3)
		
		$fieldPtr:=$1
		$length:=$2
		$isStrict:=$3
		$fieldTitle:=getLocalizedFieldName($1)
		
	: (Count parameters:C259=4)
		$fieldPtr:=$1
		$length:=$2
		$isStrict:=$3
		$fieldTitle:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($isStrict)
	checkAddErrorIf((Length:C16($fieldPtr->)>=$length); GetLocalizedErrorMessage(4193; $fieldTitle; String:C10($length)))  // Length of <X> must be less than <Y>
Else 
	checkAddWarningIf((Length:C16($fieldPtr->)>=$length); GetLocalizedErrorMessage(4194; $fieldTitle; String:C10($length)))  // It is recommended length of <X> be less than <Y>
End if 
