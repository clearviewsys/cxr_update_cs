//%attributes = {}
// returns date and time from Profix dateTime variable

C_OBJECT:C1216($0)
C_TEXT:C284($1; $profixDateTime; $datePart; $timePart)
C_LONGINT:C283($pos; $y; $m; $d)

$profixDateTime:=$1

$pos:=Position:C15("+"; $profixDateTime)

If ($pos>0)
	
	$datePart:=Substring:C12($profixDateTime; 1; $pos-1)
	$timePart:=Replace string:C233(Substring:C12($profixDateTime; $pos+1); "%3a"; ":")
	
	$d:=Num:C11(Substring:C12($datePart; 1; 2))
	$m:=Num:C11(Substring:C12($datePart; 4; 2))
	$y:=Num:C11(Substring:C12($datePart; 7; 4))
	
	$0:=New object:C1471
	$0.date:=Add to date:C393(!00-00-00!; $y; $m; $d)
	$0.time:=Time:C179($timePart)
	
End if 

