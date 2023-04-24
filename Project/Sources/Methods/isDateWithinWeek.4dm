//%attributes = {}
C_BOOLEAN:C305($0)

C_DATE:C307($date; $1)
$date:=$1

$0:=isDateWithinRange($date; 7)