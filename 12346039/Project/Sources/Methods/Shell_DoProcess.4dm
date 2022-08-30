//%attributes = {"publishedWeb":true}
// Project Method: Shell_DoProcess (method; process name) --> Number

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh), or the Help menu (PC running Windows). There you can
// find online help for this example database, as well as a listing of numerous 4D
// resources available to you.

// Created by Dave Batton, DataCraft

// This is where the New process function is called.
// It prevents processes from being created if the <>Shell_Quit flag exists.
// If the process already exists, it's just brought to the front.


C_LONGINT:C283($0; $processID; $stackSize)
C_TEXT:C284($1; $2; $methodName; $processName)

$stackSize:=256*1024  // The default stack size used by this method.

$methodName:=$1
$processName:=$2
$processID:=0

If (Not:C34(<>Shell_Quit))  // Don't start process if quitting
	$processID:=Process number:C372($processName)
	If ($processID#0)
		RESUME PROCESS:C320($processID)  // In case it was sleeping.
		BRING TO FRONT:C326($processID)
	Else 
		$processID:=New process:C317($methodName; $stackSize; $processName)
	End if 
	
Else 
	myAlert("Shutting down database.  Can't start a new process now.")
End if 

$0:=$processID