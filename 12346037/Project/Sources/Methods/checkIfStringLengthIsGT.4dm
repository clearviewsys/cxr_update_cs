//%attributes = {}
// checkIfStringLengthIsGT (->field; length; {isStrict=true}; {fieldTitle})
// Check if string length is greatest than N chars
// Example: checkIfStringLengthIsGT (->[Country]Code;2)
// Created by Jaime A. on Feb 24/2017

C_POINTER:C301($1; $fieldPtr)
C_LONGINT:C283($2; $length)
C_BOOLEAN:C305($isStrict; $3)
C_TEXT:C284($4; $fieldTitle)

// Check if the number of parameters is correct
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
C_TEXT:C284($msg)

If ($isStrict)
	$msg:="Length of <X> must have minimal <Y> characters"
	replaceXYZTags(->$msg; $fieldTitle; String:C10($length))
	checkAddErrorIf((Length:C16($fieldPtr->)<$length); $msg)
Else 
	$msg:="It is recommended length of <X> be minimal <Y>"
	replaceXYZTags(->$msg; $fieldTitle; String:C10($length))
	checkAddWarningIf((Length:C16($fieldPtr->)<$length); $msg)
End if 
