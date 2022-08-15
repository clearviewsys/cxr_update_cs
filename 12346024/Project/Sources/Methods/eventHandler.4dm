//%attributes = {}
C_LONGINT:C283($i)

For ($i; 1; 10)
	
	
	DELAY PROCESS:C323(Current process:C322; 600)  // every second
	
	READ ONLY:C145([CalendarEvents:80])
	QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]Date:4=Current date:C33; *)
	QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]FromTime:5<=Current time:C178; *)
	QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]toTime:6>=Current time:C178; *)
	QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]isCompleted:17=False:C215; *)  // incomplete task
	QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]isDismissed:18=False:C215)  // not dismissed
	
	If (Records in selection:C76([CalendarEvents:80])>0)
		displaySelectedRecords(->[CalendarEvents:80])
		
	End if 
	
End for 

myAlert("process ended")
