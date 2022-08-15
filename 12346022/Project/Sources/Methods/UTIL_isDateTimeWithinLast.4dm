//%attributes = {}
// is first $1 date  and $2 time within last $3 seconds since $4 date $5 time 
C_DATE:C307($1; $firstDate; $4; $secondDate)
C_TIME:C306($2; $firstTime; $5; $secondTime)
C_LONGINT:C283($3; $period; $difference)
C_BOOLEAN:C305($0)

$firstDate:=$1
$firstTime:=$2
$period:=$3
$secondDate:=$4
$secondTime:=$5

$difference:=UTIL_getDateTimeDIfference($secondDate; $secondTime; $firstDate; $firstTime)

If ($difference<=$period)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
