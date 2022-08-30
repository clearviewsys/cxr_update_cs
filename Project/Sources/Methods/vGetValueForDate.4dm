//%attributes = {"publishedWeb":true}
// vGetValueForDate(->dateArray;-ValueArray;lookupDate) --> real
C_POINTER:C301($1; $2)
C_DATE:C307($3)
C_REAL:C285($0)
C_LONGINT:C283($index)

$index:=Find in array:C230($1->; $3)
If ($index>0)
	$0:=$2->{$index}
Else 
	$0:=0
End if 