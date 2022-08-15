//%attributes = {}
// method (month;year) -> number of days in that month

C_LONGINT:C283($month; $year; $1; $2; $0)
$month:=$1
$year:=$2
C_DATE:C307($BONextMonth; $EOMonth)

If ($month<12)
	$BONextMonth:=cal_getBOM_MY($month+1; $year)
Else 
	$BONextMonth:=cal_getBOM_MY(1; $year+1)
End if 

$EOMonth:=(Add to date:C393($boNextMonth; 0; 0; -1))
$0:=Day of:C23($EOMonth)