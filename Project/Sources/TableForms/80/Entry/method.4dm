// [CalendarEvents]

C_POINTER:C301($ptrVar)

HandleEntryFormMethod(->[CalendarEvents:80])

Case of 
	: (Form event code:C388=On Load:K2:1)
		GOTO OBJECT:C206([CalendarEvents:80]EventHeading:2)
		If (Is new record:C668([CalendarEvents:80]))
			[CalendarEvents:80]UID:1:=makeCalendarEventID  //makeUID
			//[CalendarEvents]BID:=makeBranchUID
			//[CalendarEvents]WID:=makeWorkstationUID
		Else 
			If ([CalendarEvents:80]UID:1="")
				[CalendarEvents:80]UID:1:=makeCalendarEventID  //makeUID
			End if 
			//If ([CalendarEvents]BID="")
			//[CalendarEvents]BID:=makeBranchUID
			//End if 
			//If ([CalendarEvents]WID="")
			//[CalendarEvents]WID:=makeWorkstationUID
			//End if 
			
		End if 
		
		If ([CalendarEvents:80]isTask:7) | ([CalendarEvents:80]isScheduledEvent:31)
			OBJECT SET VISIBLE:C603([CalendarEvents:80]isCompleted:17; True:C214)
		Else 
			OBJECT SET VISIBLE:C603([CalendarEvents:80]isCompleted:17; False:C215)
		End if 
		
		If ([CalendarEvents:80]isScheduledEvent:31)
			FORM GOTO PAGE:C247(2)
			
			If ([CalendarEvents:80]isRecurring:24)
				OBJECT SET VISIBLE:C603(*; "Repeat_@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "Repeat_@"; False:C215)
			End if 
			
			POST OUTSIDE CALL:C329(Current process:C322)
			
		Else 
			FORM GOTO PAGE:C247(1)
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		$ptrVar:=OBJECT Get pointer:C1124(Object named:K67:5; "CalendarInfoText")
		$ptrVar->:="Created: "+String:C10([CalendarEvents:80]CreationDate:21)+" by "+[CalendarEvents:80]CreatedByUser:20
		$ptrVar->:=$ptrVar->+" Next: "+String:C10([CalendarEvents:80]nextScheduledDate:27)+" at "+String:C10([CalendarEvents:80]nextScheduledTime:28)
		$ptrVar->:=$ptrVar->+" Last: "+String:C10([CalendarEvents:80]lastScheduledDate:29)+" at "+String:C10([CalendarEvents:80]lastScheduledTime:30)
		
		
	Else 
		
End case 