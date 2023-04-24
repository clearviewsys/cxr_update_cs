//%attributes = {"shared":true}
// displayLBox (formTable)


C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($methodName)
C_LONGINT:C283($processNumber)
$tablePtr:=$1
$methodName:="displayLBox_"+Table name:C256($tablePtr)

$processNumber:=Process number:C372($methodName)
If ($processNumber>0)
	BRING TO FRONT:C326($processNumber)
Else 
	$processNumber:=New process:C317($methodName; 0; $methodName)  //5/11/21 removed ; $tablePtr)
End if 

