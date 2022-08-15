//%attributes = {"shared":true,"publishedWeb":true}
// displayRecord(-> table, recordNumber, boolean)
// this generic method is called by the 'on double clicked' event for lists
// it opens a window showing the record information

C_TEXT:C284($processName; $methodName)
C_LONGINT:C283($processNumber)
C_POINTER:C301($1)
C_LONGINT:C283($2)

If (isUserAuthorizedToView($1))
	<>RecordNo:=$2
	If ($2>=0)
		$methodName:=Substring:C12("displayRecord_"+Table name:C256($1); 1; 31)
		$processName:=$methodName+String:C10($2)
		
		UNLOAD RECORD:C212($1->)
		
		$processNumber:=Process number:C372($processName)
		If ($processNumber>0)
			BRING TO FRONT:C326($processNumber)
			POST OUTSIDE CALL:C329($processNumber)
		Else 
			//$processNumber:=New process($methodName;0;$processName)
			$processNumber:=New process:C317($methodName; 0; $processName)
			BRING TO FRONT:C326($processNumber)
			
		End if 
	End if 
Else 
	myAlert("You are not authorized to view the details of this record.")
End if 