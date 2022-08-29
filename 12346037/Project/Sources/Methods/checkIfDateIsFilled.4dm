//%attributes = {}
// checkIfDateIsFilled (->field; isStrict=true; fieldName)
// Checks if a date is filled 
// i.e: checkIfDateIsFilled (->[Customers]DOB;True) 
// Created by Jaime Alvarez on 2/26/2017

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $isStrict)
C_TEXT:C284($3; $fieldName; $msg)

Case of 
		
		
	: (Count parameters:C259=3)
		
		$fieldPtr:=$1
		$isStrict:=$2
		$fieldName:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($isStrict)
	$msg:="<X> Is required or missing"
	replaceXYZTags(->$msg; $fieldName)
	checkAddErrorIf(($fieldPtr->=!00-00-00!); $msg)
	colourizeField($fieldPtr)
	
Else 
	$msg:="It is recommended to enter a value for <X>"
	replaceXYZTags(->$msg; $fieldName)
	checkAddWarningIf(($fieldPtr->=!00-00-00!); $msg)
End if 


