//%attributes = {}
// viewRecordsInSelection(->[TABLE]{{;"modifyForm"};"listForm"})

// display the list form to modify the entries of the current selection 


C_POINTER:C301($1)
C_TEXT:C284($2; $3; $listForm; $modifyForm)
C_LONGINT:C283($param; $winRef)

$listForm:="List"
$modifyForm:="Modify"

$Param:=Count parameters:C259

Case of 
		
	: ($Param=2)
		$modifyForm:=$2
		
	: ($param=3)
		$modifyForm:=$2
		$listForm:=$3
		
End case 

FORM SET OUTPUT:C54($1->; $listForm)
// change the input form

$WinRef:=Open form window:C675($1->; $modifyForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
FORM SET INPUT:C55($1->; $modifyForm)
// modify selection displays the output form with the selected records

// then waits for double click to open record for modification using input form


MODIFY SELECTION:C204($1->; *)
CLOSE WINDOW:C154
