//%attributes = {}
// cal_getBOM_MY (month, year) -> date

// returns the beginning of month date
// Unit test completed @Zoya

C_LONGINT:C283($1; $2; $month; $year)
$month:=$1
$year:=$2

C_DATE:C307($0)



$0:=cal_date(1; $month; $year)