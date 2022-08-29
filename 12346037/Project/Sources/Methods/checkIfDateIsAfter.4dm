//%attributes = {}
// checkifDateIsAfter (->field; {isStrict=true}; date=system date; fieldName)
// Checks if a date is after a reference date 
// i.e: checkifDateIsAfter (->[Customers]DOB;true;!1/1/1900!) )
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
C_BOOLEAN:C305($condition)
$condition:=($fieldPtr-><=$refDate)

If ($isStrict)
	$msg:="<X> must be greater than <Y>"
	replaceXYZTags(->$msg; $fieldName; String:C10($refDate))
	checkAddErrorIf($condition; $msg)
Else 
	$msg:="It is recommended that <X> be greater than <Y>"
	replaceXYZTags(->$msg; $fieldName; String:C10($refDate))
	checkAddWarningIf($condition; $msg)  // 
End if 


