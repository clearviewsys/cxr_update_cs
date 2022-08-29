//%attributes = {}
// modifyRecordTable(->table;{modifyForm})

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($modifyForm; $2)

$modifyForm:="Entry"

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$modifyForm:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($WinRef)
If (isUserAuthorizedToModify($tablePtr))
	FORM SET INPUT:C55($tablePtr->; $modifyForm)
	// change the input form
	$WinRef:=Open form window:C675($1->; $modifyForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	
	START TRANSACTION:C239  // added by: Barclay Berry (2/24/13)
	
	TM_Add2Stack($tablePtr; Current method name:C684; Transaction level:C961)  //9/1/16
	
	READ WRITE:C146($tablePtr->)
	MODIFY RECORD:C57($tablePtr->; *)
	
	
	If (OK=1)
		VALIDATE TRANSACTION:C240
		//UNLOAD RECORD($tablePtr->) // Modified by: Tiran Behrouz (4/4/13)
	Else 
		CANCEL TRANSACTION:C241  // Modified by: Tiran Behrouz (2012-11-04)
	End if 
	
	TM_RemoveFromStack  //($tablePtr)  //9/1/16
	
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
	LOAD RECORD:C52($tablePtr->)
	
	CLOSE WINDOW:C154($WinRef)
Else 
	myAlert_AccessDenied
End if 