//%attributes = {}
// countCalendarEventsForDate (date)

C_DATE:C307($date; $1)
$date:=$1

C_LONGINT:C283($n; $0)
SET QUERY DESTINATION:C396(Into variable:K19:4; $n)
QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]Date:4=$date)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$n