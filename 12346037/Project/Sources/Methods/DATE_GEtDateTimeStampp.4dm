//%attributes = {}
// DATE_GetDateTimeStamp
//
// Purpose: Converts current date and time to long int
// by incrementing seconds from start date

C_BOOLEAN:C305($c040728; $u050414)
C_LONGINT:C283($0)
C_DATE:C307($1; $dThisDate; $dStart)
C_TIME:C306($2; $hThisTime)
C_LONGINT:C283($LNbrDays; $LSecondsPerDay; $LSecondsToday)

$dThisDate:=$1
$hThisTime:=$2
$dStart:=DATE_GetSeedYearDate

If ($dThisDate>=$dStart)
	
	$LSecondsPerDay:=(?24:00:00?-0)  // 86400
	$LNbrDays:=$dThisDate-$dStart
	$LSecondsToday:=($hThisTime-0)
	
	$0:=($LNbrDays*$LSecondsPerDay)+$LSecondsToday
	
Else 
	BEEP:C151
	myAlert("Date must be greater than 12/31/1999!")
	$0:=-1
End if 
