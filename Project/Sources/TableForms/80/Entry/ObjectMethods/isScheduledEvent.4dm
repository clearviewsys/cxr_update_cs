

Case of 
	: (Self:C308->=True:C214)
		FORM GOTO PAGE:C247(2)
		
		[CalendarEvents:80]CalendarName:9:="Scheduled"
		[CalendarEvents:80]nextScheduledDate:27:=[CalendarEvents:80]Date:4
		[CalendarEvents:80]nextScheduledTime:28:=[CalendarEvents:80]FromTime:5
		
	: (Self:C308->=False:C215)
		FORM GOTO PAGE:C247(1)
		//clear values related to scheduled events
		[CalendarEvents:80]CalendarName:9:=""
		[CalendarEvents:80]executeMethod:23:=""
		[CalendarEvents:80]nextScheduledDate:27:=!00-00-00!
		[CalendarEvents:80]nextScheduledTime:28:=?00:00:00?
		[CalendarEvents:80]lastScheduledDate:29:=!00-00-00!
		[CalendarEvents:80]lastScheduledTime:30:=?00:00:00?
		
	Else 
		
End case 