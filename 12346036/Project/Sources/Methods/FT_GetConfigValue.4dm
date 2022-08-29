//%attributes = {}
C_TEXT:C284($0; $1)
C_POINTER:C301($2; $3)
C_LONGINT:C283($p)

$p:=Find in array:C230($2->; $1)
If ($p>0)
	$0:=$3->{$p}
Else 
	$0:=""
End if 


