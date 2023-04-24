//%attributes = {}

C_LONGINT:C283($n; $i)
$n:=Records in selection:C76([CalendarEvents:80])
ARRAY TEXT:C222(arrEventID; $n)
ARRAY TEXT:C222(arrEvent; $n)
ARRAY TEXT:C222(arrTime; $n)
ARRAY TEXT:C222(arrTask; $n)

SELECTION TO ARRAY:C260([CalendarEvents:80]UID:1; arrEventID; [CalendarEvents:80]EventHeading:2; arrEvent)
READ ONLY:C145([CalendarEvents:80])
FIRST RECORD:C50([CalendarEvents:80])
For ($i; 1; $n)
	If ([CalendarEvents:80]isAllDayEvent:3)
		arrTime{$i}:=""
	Else 
		arrTime{$i}:=String:C10([CalendarEvents:80]FromTime:5; HH MM:K7:2)+"-"+String:C10([CalendarEvents:80]toTime:6; HH MM:K7:2)
	End if 
	If ([CalendarEvents:80]isTask:7)
		If ([CalendarEvents:80]isCompleted:17=True:C214)
			arrTask{$i}:="[X]"
		Else 
			arrTask{$i}:="[  ]"
		End if 
	Else 
		arrTask{$i}:=""
	End if 
	
	NEXT RECORD:C51([CalendarEvents:80])
End for 