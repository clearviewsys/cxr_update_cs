//%attributes = {}
// Profix expects date in a dd.mm.yyyy format
// SOAP API expects datetime as dd.mm.yyyy HH:MM:SS

C_DATE:C307($1; $mydate)
C_TIME:C306($2; $mytime)
C_LONGINT:C283($d; $m; $y)
C_TEXT:C284($0)

$mydate:=$1

$d:=Day of:C23($mydate)
$m:=Month of:C24($mydate)
$y:=Year of:C25($mydate)

$0:=String:C10($d; "00")+"."+String:C10($m; "00")+"."+String:C10($y)

If (Count parameters:C259>1)
	
	$mytime:=$2
	
	$0:=$0+" "+String:C10($mytime; HH MM SS:K7:1)
	
End if 
