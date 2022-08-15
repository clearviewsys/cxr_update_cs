//%attributes = {}







C_TEXT:C284($1; $tName)  //event name - informational
C_TEXT:C284($2; $tUser)  //user to assign this task to
C_DATE:C307($3; $dDate)  //date to execute the task - optional - if not sent current date
C_TIME:C306($4; $hTime)  //time to execute the task - optional - if not send current time
C_LONGINT:C283($5; $iRepeatDays)  //how often to repeat this in days
C_TEXT:C284($6; $tNotes)  //any notes about the task - optional
C_TEXT:C284($7; $tCalendarName)  //calendar name for "grouping" - optional

C_TEXT:C284($0; $tID)


If (Count parameters:C259>=1)
	$tName:=$1
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 


If (Count parameters:C259>=2)
	$tUser:=$2
Else 
	$tUser:=getSystemUserName
End if 


If (Count parameters:C259>=3)
	$dDate:=$3
Else 
	$dDate:=Current date:C33
End if 

If (Count parameters:C259>=4)
	$hTime:=$4
Else 
	$hTime:=Current time:C178
End if 

If (Count parameters:C259>=5)
	$iRepeatDays:=$5
Else 
	$iRepeatDays:=0
End if 

If (Count parameters:C259>=6)
	$tNotes:=$6
Else 
	$tNotes:=""
End if 

If (Count parameters:C259>=7)
	$tCalendarName:=$7
Else 
	$tCalendarName:=""
End if 

$tID:=""

CREATE RECORD:C68([CalendarEvents:80])

[CalendarEvents:80]UUID:26:=Generate UUID:C1066
[CalendarEvents:80]UID:1:=makeCalendarEventID
[CalendarEvents:80]isTask:7:=True:C214
[CalendarEvents:80]TargetUser:10:=$tUser  //user


[CalendarEvents:80]Date:4:=$dDate
[CalendarEvents:80]FromTime:5:=$hTime
[CalendarEvents:80]toTime:6:=$hTime

[CalendarEvents:80]EventHeading:2:=$tName
[CalendarEvents:80]Notes:8:=$tNotes
[CalendarEvents:80]CalendarName:9:=$tCalendarName


If ($iRepeatDays>0)
	[CalendarEvents:80]isRecurring:24:=True:C214
	[CalendarEvents:80]RepeatsEveryNDay:25:=$iRepeatDays
Else 
	[CalendarEvents:80]isRecurring:24:=False:C215
	[CalendarEvents:80]RepeatsEveryNDay:25:=0
End if 


// <>TODO maybe use this to alert the user at the time via Hola ???
//[CalendarEvents]executeMethod:=$tTask


[CalendarEvents:80]nextScheduledDate:27:=[CalendarEvents:80]Date:4
[CalendarEvents:80]nextScheduledTime:28:=[CalendarEvents:80]FromTime:5
[CalendarEvents:80]lastScheduledDate:29:=!00-00-00!
[CalendarEvents:80]lastScheduledTime:30:=?00:00:00?


[CalendarEvents:80]isScheduledEvent:31:=False:C215
[CalendarEvents:80]isAllDayEvent:3:=False:C215
[CalendarEvents:80]isCompleted:17:=False:C215
[CalendarEvents:80]isDismissed:18:=False:C215
[CalendarEvents:80]isFlagged:15:=False:C215



//<>TODO FUTURE CONFIG
[CalendarEvents:80]Target_BID:19:=""  //branch id

//[CalendarEvents]externalTableNo:=
//[CalendarEvents]externalTableRef:=
//[CalendarEvents]CreatedByUser:=
//[CalendarEvents]CreationDate:=
//[CalendarEvents]CreationTime:=
//[CalendarEvents]amount:=
//[CalendarEvents]Currency:=
//[CalendarEvents]AccountID:=


SAVE RECORD:C53([CalendarEvents:80])

$tID:=[CalendarEvents:80]UID:1

UNLOAD RECORD:C212([CalendarEvents:80])
READ ONLY:C145([CalendarEvents:80])
LOAD RECORD:C52([CalendarEvents:80])

$0:=$tID
