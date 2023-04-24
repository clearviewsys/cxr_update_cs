//%attributes = {}
// browseTable_ (->table;formName)

// return the result of the pic in the returnVariable


C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($winRef)
C_TEXT:C284(vSearchText; $0; $formName)

Case of 
	: (Count parameters:C259=1)
		$formName:="browse"+Table name:C256($1)
		
	: (Count parameters:C259=2)
		$formName:=$2
End case 
$winRef:=Open form window:C675($1->; $formName; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
DIALOG:C40($1->; $formName)
