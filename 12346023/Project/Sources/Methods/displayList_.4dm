//%attributes = {"shared":true,"publishedWeb":true}
// Project Method: Shell_DisplayTable2 (->table)

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft

// Called from Shell_DisplayTable to display an output form in a new window.


C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($winRef)

$tablePtr:=$1

MESSAGES OFF:C175
checkInit
checkAddErrorIf(Not:C34(isModuleAuthorized($tablePtr)); getElegantTableName($tablePtr)+" cannot be viewed with this license.")
checkAddErrorIf(Not:C34(isUserAuthorizedToView($tablePtr)); "Sorry, you are not authorized to view this module.")

If (isValidationConfirmed)
	SET MENU BAR:C67(1)
	//iLB_Init_NewProcess   // Modified by: barclay (4/16/2012)
	
	$winRef:=Open form window:C675($tablePtr->; "List"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	FORM SET OUTPUT:C54($tablePtr->; "List")
	READ ONLY:C145(*)
	allRecords($tablePtr)
	//UNLOAD RECORD($tablePtr->)
	
	DISPLAY SELECTION:C59($tablePtr->; *)
	CLOSE WINDOW:C154
	
End if 

MESSAGES ON:C181
