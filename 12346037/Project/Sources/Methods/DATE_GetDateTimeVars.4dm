//%attributes = {}
// DATE_GetDateTimeVars
//
// assumes that all dates have been set beyond seed year date

C_BOOLEAN:C305($c050414; $u050414)
C_LONGINT:C283($dateTimeStamp)
C_POINTER:C301($2; $3)  // date var, time var
C_DATE:C307($dThisDate; $dStart)
C_LONGINT:C283($LNbrDays; $LSecondsPerDay; $LSecondsToday)
C_TIME:C306($thisTime)

$dateTimeStamp:=$1
$dStart:=DATE_GetSeedYearDate
$LSecondsPerDay:=(?24:00:00?-0)  // 86400

$LNbrDays:=Int:C8($dateTimeStamp/$LSecondsPerDay)
$2->:=$dStart+$LNbrDays
$3->:=$LSecondsPerDay*Dec:C9($dateTimeStamp/$LSecondsPerDay)
