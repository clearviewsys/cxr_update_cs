//%attributes = {}
// modifyRECORDS (-> [TABLE] {{{ ;  modifyForm } )
// defaults: modifyForm = "MODIFY"
// defaults : searchForm = "SEARCH"
// OUTPUT FORM is always set to "List"

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283(bSearch; $totalRecords; $Param; $WinRef)
C_TEXT:C284($2; $3; $modifyForm; $searchForm; $listForm)
C_BOOLEAN:C305($4; $allRecords)
$Param:=Count parameters:C259

// set the default form
$listForm:="List"
$modifyForm:="Entry"
Case of 
		
	: ($param=2)
		$modifyForm:=$2
		
End case 

$tablePtr:=$1
//If (isUserAuthorizedToModify (->[Invoices]))
FORM SET INPUT:C55($1->; $modifyForm)
If (Records in selection:C76($1->)>0)
	$WinRef:=Open form window:C675($1->; $modifyForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	
	START TRANSACTION:C239  //11/30/17
	
	MODIFY RECORD:C57($1->; *)
	
	If (OK=1)
		VALIDATE TRANSACTION:C240  //11/30/17
		UNLOAD RECORD:C212($1->)
	Else 
		CANCEL TRANSACTION:C241  //11/30/17
	End if 
	
	CLOSE WINDOW:C154
End if 
//Else 
//ALERT("You are not authorized to modify any record in this Invoice.")
//End if 



