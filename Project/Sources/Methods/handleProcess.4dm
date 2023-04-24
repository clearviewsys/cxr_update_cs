//%attributes = {"publishedWeb":true}
// handleProcess(->[table];method;boolean concat)
// eg: handleProcess(->[funds];"displayList")
// if concat = true the method called will be methodNameTableName
// you must hava a method called method_

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($processName; $methodName; $2)
C_LONGINT:C283($processNumber)
C_BOOLEAN:C305($concat; $3)

If (Count parameters:C259=3)
	$concat:=$3
Else 
	$concat:=False:C215
End if 

$methodName:=$2
$tablePtr:=$1
$processName:=$methodName+Table name:C256($tablePtr)
$processNumber:=Process number:C372($processName)

If ($processNumber>0)
	BRING TO FRONT:C326($processNumber)
	POST OUTSIDE CALL:C329($processNumber)
Else 
	
	If ($concat=True:C214)
		$processNumber:=New process:C317($processName; 0; $processName; $tablePtr)
	Else 
		$processNumber:=New process:C317($methodName; 0; $processName; $tablePtr)
	End if 
	
End if 

$0:=$processNumber