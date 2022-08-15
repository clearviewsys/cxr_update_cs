//%attributes = {}
// checkIfDateIsInRange (->field; minDate; maxDate; fieldName)
// Checks if a date is in range between min and max date, including bounds
// i.e: checkIfDateIsInRange ([Invoices]CreationDate;!2017-01-01!;!2017-01-31!;True)
// Created by Jaime Alvarez on 2/26/2017

C_POINTER:C301($1; $fieldPtr)
C_DATE:C307($2; $3; $minDate; $maxDate)
C_BOOLEAN:C305($4; $isStrict; $dateNotInRange)
C_TEXT:C284($5; $fieldName)
C_TEXT:C284($msg)


Case of 
		
		
	: (Count parameters:C259=5)
		
		$fieldPtr:=$1
		$minDate:=$2
		$maxDate:=$3
		$isStrict:=$4
		$fieldName:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$dateNotInRange:=Not:C34(($fieldPtr->>=$minDate) & ($fieldPtr-><=$maxDate))

If ($isStrict)
	$msg:="<X> must be betweeen <Y> and <Z>"
	replaceXYZTags(->$msg; $fieldName; String:C10($minDate); String:C10($maxDate))
	checkAddErrorIf($dateNotInRange; $msg)
Else 
	$msg:="It is recommended that <X> be between <Y> and <Z>"
	replaceXYZTags(->$msg; $fieldName; String:C10($minDate); String:C10($maxDate))
	checkAddWarningIf($dateNotInRange; $msg)
End if 




