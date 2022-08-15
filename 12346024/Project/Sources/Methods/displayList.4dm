//%attributes = {"shared":true,"publishedWeb":true}
// Project Method: Shell_DisplayTable (->table)

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.


// If the table has already been displayed in a process by this method, it is
//   brought to the front.  Otherwise a new process is created to display the
//   table.


C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($processName)
C_LONGINT:C283($processNumber)
$tablePtr:=$1
$processName:="displayList_"+Table name:C256($tablePtr)

$processNumber:=Process number:C372($processName)
If ($processNumber>0)
	BRING TO FRONT:C326($processNumber)
Else 
	$processNumber:=New process:C317($processName; 0; $processName; $tablePtr)
End if 
