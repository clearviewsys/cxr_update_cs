//%attributes = {}
// checkIfPictureSizeIsLT (->field; {bound in KB} {isStrict=true}; {fieldTitle})
// Check if picture size is less thrna the bound
// i.e: checkIfPictureSizeIsLT (->[Customers]Picture;true)
// Created by JA on Feb 26/2017

C_POINTER:C301($1; $fieldPtr)
C_LONGINT:C283($2; $bound)
C_BOOLEAN:C305($3; $isStrict; $isBig)
C_TEXT:C284($4; $fieldTitle)

Case of 
		
	: (Count parameters:C259=1)
		
		$fieldPtr:=$1
		$bound:=1000*1024
		$isStrict:=True:C214
		$fieldTitle:=getLocalizedFieldName($1)
		
		
	: (Count parameters:C259=2)
		
		$fieldPtr:=$1
		$bound:=$2
		$isStrict:=True:C214
		$fieldTitle:=getLocalizedFieldName($1)
		
	: (Count parameters:C259=3)
		
		$fieldPtr:=$1
		$bound:=$2
		$isStrict:=$3
		$fieldTitle:=getLocalizedFieldName($1)
		
	: (Count parameters:C259=4)
		
		$fieldPtr:=$1
		$bound:=$2
		$isStrict:=$3
		$fieldTitle:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isBig:=((Picture size:C356($fieldPtr->)/1024)>=$bound)  // picture size is in bytes so needs to be converted to KB

If ($isStrict)
	checkAddErrorIf($isBig; "<X> size must be smaller than <Y>"; $fieldTitle; String:C10($bound))  //  // <X> must be less than <Y>
Else 
	checkAddWarningIf($isBig; GetLocalizedErrorMessage(4198; $fieldTitle))  // It is recommended that <X> be less than <Y>
End if 
