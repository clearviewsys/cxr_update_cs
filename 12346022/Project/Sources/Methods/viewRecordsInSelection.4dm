//%attributes = {}
// viewRecordsInSelection(->[TABLE]{{;"viewForm"};"listForm"})

// displays the current records in selection of the table 

C_POINTER:C301($1)
C_TEXT:C284($2; $3; $listForm; $viewForm)
C_LONGINT:C283($param; $winRef)

$listForm:="List"
$viewForm:="View"

$Param:=Count parameters:C259

Case of 
		
	: ($Param=2)
		$viewForm:=$2
		
	: ($param=3)
		$viewForm:=$2
		$listForm:=$3
		
End case 
If (Records in selection:C76($1->)>0)
	FORM SET OUTPUT:C54($1->; $listForm)
	// change the input form
	
	$WinRef:=Open form window:C675($1->; $viewForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	FORM SET INPUT:C55($1->; $viewForm)
	// modify selection displays the output form with the selected records
	
	// then waits for double click to open record for modification using input form
	
	READ ONLY:C145($1->)
	DISPLAY SELECTION:C59($1->; *)
	CLOSE WINDOW:C154
End if 
