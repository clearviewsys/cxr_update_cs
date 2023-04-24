//%attributes = {}
// returns internal time stamp - number of seconds since January 1st, 2000

C_DATE:C307($1; $date; $seeddate)
C_TIME:C306($2; $time)
C_LONGINT:C283($0)

$seeddate:=Add to date:C393(!00-00-00!; 2000; 1; 1)

If (Count parameters:C259=0)
	$date:=Current date:C33
	$time:=Current time:C178
Else 
	$date:=$1
	$time:=$2
End if 

$0:=(($date-$seeddate)*86400)+$time
