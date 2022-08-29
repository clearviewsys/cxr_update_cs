//%attributes = {}
//HTMLAppendToList (»table;»titleField; »valueField)

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($i)
C_TEXT:C284($0)

$0:=Char:C90(1)
For ($i; 1; Records in selection:C76($2->))
	$0:=$0+"<option value="+Quotify($3->)+">"+$2->+"</option>"
	NEXT RECORD:C51($1->)
End for 
