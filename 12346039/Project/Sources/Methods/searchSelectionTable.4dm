//%attributes = {}
// searchSelectionTable (->Table; ->field1...>field7)
//
C_POINTER:C301($1; ${2})  // this means that 
C_TEXT:C284(vSearchString)
C_LONGINT:C283($i)

QUERY SELECTION:C341($1->; $2->="@"+vSearchString+"@"; *)
For ($i; 3; Count parameters:C259; 1)
	QUERY SELECTION:C341($1->;  | ; ${$i}->="@"+vSearchString+"@"; *)
End for 
QUERY SELECTION:C341($1->)


