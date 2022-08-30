//%attributes = {}
// searchTable (->table ; ->fieldPtr ; {->field2Ptr;...})


C_POINTER:C301($1; ${2})  // this means that 
C_TEXT:C284(vSearchString)
C_LONGINT:C283($i; $n)

$n:=Count parameters:C259
If ($n>1)
	READ ONLY:C145($1->)
	QUERY:C277($1->; $2->="@"+vSearchString+"@"; *)  // starting
	
	For ($i; 3; Count parameters:C259; 1)
		QUERY:C277($1->;  | ; ${$i}->="@"+vSearchString+"@"; *)  // in between
	End for 
	QUERY:C277($1->)
	
	//QUERY ($1->;|;${$n}->="@"+vSearchString+"@") // ending
End if 

