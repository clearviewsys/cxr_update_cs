//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $mgDateTime)

C_LONGINT:C283($twentyfourhours)
C_DATE:C307($mgTransactionDate)
C_TIME:C306($mgTransactionTime)

$twentyfourhours:=24*60*60
$mgDateTime:=$1

$mgTransactionDate:=mgGetDateFromProfixDateTime($mgDateTime)
$mgTransactionTime:=mgGetTimeFromProfixDateTime($mgDateTime)

$0:=UTIL_isDateTimeWithinLast(Current date:C33; Current time:C178; $twentyfourhours; $mgTransactionDate; $mgTransactionTime)
