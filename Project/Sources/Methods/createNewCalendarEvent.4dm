//%attributes = {}
// createNewCalendarEvent ( 

//  calendarName
//  eventName: alpha
//  isAllDay: boolean
//  date: 
//  fromTime
//  toTime
//  toDate
//  externalTableNo
//  externalTableRef
//  amount
//  currency 
// accountID 

// :---> returns eventID 

C_TEXT:C284($calendar; $1)
C_TEXT:C284($event; $2)
C_BOOLEAN:C305($isAllDay; $3)
C_DATE:C307($date; $4)
C_BOOLEAN:C305($isTask; $5)
C_TEXT:C284($notes; $6)

C_TIME:C306($fromTime; $7)
C_TIME:C306($toTime; $8)

C_LONGINT:C283($tableNo; $9)
C_TEXT:C284($tableRef; $10)

C_REAL:C285($amount; $11)
C_TEXT:C284($currency; $12)
C_TEXT:C284($accountID; $13)

C_TEXT:C284($eventID; $0)


$calendar:=$1
$event:=$2
$isAllDay:=$3
$date:=$4
$isTask:=$5
$notes:=$6

$fromTime:=$7
$toTime:=$8
$tableNo:=$9
$tableRef:=$10

$amount:=$11
$currency:=$12
$accountID:=$13



READ WRITE:C146([CalendarEvents:80])
CREATE RECORD:C68([CalendarEvents:80])
$eventID:=makeCalendarEventID

[CalendarEvents:80]UID:1:=$eventID
[CalendarEvents:80]CalendarName:9:=$calendar
[CalendarEvents:80]EventHeading:2:=$event
[CalendarEvents:80]isAllDayEvent:3:=$isAllDay

[CalendarEvents:80]Date:4:=$date
[CalendarEvents:80]FromTime:5:=$fromTime
[CalendarEvents:80]toTime:6:=$toTime
[CalendarEvents:80]isTask:7:=$isTask

[CalendarEvents:80]Notes:8:=$notes

[CalendarEvents:80]externalTableNo:11:=$tableNo
[CalendarEvents:80]externalTableRef:12:=$tableRef

[CalendarEvents:80]amount:13:=$amount
[CalendarEvents:80]Currency:14:=$currency
[CalendarEvents:80]AccountID:16:=$accountID
[CalendarEvents:80]TargetUser:10:=getApplicationUser

SAVE RECORD:C53([CalendarEvents:80])
UNLOAD RECORD:C212([CalendarEvents:80])
READ ONLY:C145([CalendarEvents:80])

$0:=$eventID
