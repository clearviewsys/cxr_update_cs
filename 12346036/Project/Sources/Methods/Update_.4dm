//%attributes = {}
// Update_ (->table)
//  // LAUNCH THE PROCESS FOR UPDATING TASKS

C_TEXT:C284($processName; $methodName; $tableName)
C_LONGINT:C283($id)
C_POINTER:C301($1; $tablePtr)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tableName:=Table name:C256($tablePtr)  //Get the name of the table and 
$methodName:="Update "+$tableName+"_M"  // append _M for method
handleProcess($tablePtr; $methodName; False:C215)  // LAUNCH THE PROCESS FOR UPDATING TASKS

