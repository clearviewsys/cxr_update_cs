//%attributes = {}
// selecteCalendarEventsByDate (date) : number of records 
// POST: this method changes the selection of records in 

C_DATE:C307($date; $1)
C_LONGINT:C283($n; $0)
$date:=$1

READ ONLY:C145([CalendarEvents:80])
QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]Date:4=$date)
orderByCalendarEvents
$n:=Records in selection:C76([CalendarEvents:80])
$0:=$n