//%attributes = {}
// checkIfDateIsBefore (->field; isStrict; date; fieldName)
// Checks if a date is before a reference date (current date)
// i.e: checkIfDateIsBefore (->[Customers]DOB;true;!1/31/2017!) )
// Created by Jaime Alvarez on 2/26/2017


C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $isStrict)
C_DATE:C307($3; $refDate)
C_TEXT:C284($4; $fieldName; $msg)

Case of 
		
	: (Count parameters:C259=4)
		
		$fieldPtr:=$1
		$isStrict:=$2
		$refDate:=$3
		$fieldName:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($isStrict)
	$msg:=" <X> Must be less or equal than <Y>"
	replaceXYZTags(->$msg; $fieldName; String:C10($refDate))
	checkAddErrorIf(($fieldPtr->>$refDate); $msg)
Else 
	$msg:="It is recommended that <X> be less or equal than <Y>"
	replaceXYZTags(->$msg; $fieldName; String:C10($refDate))
	checkAddWarningIf(($fieldPtr->>$refDate); $msg)
End if 


