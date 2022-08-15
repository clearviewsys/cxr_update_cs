HandleEntryFormMethod(->[CalendarEvents:80])

If ([CalendarEvents:80]isTask:7)
	OBJECT SET VISIBLE:C603([CalendarEvents:80]isCompleted:17; True:C214)
Else 
	OBJECT SET VISIBLE:C603([CalendarEvents:80]isCompleted:17; False:C215)
End if 