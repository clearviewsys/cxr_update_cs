

If ([CalendarEvents:80]isRecurring:24)
	OBJECT SET VISIBLE:C603(*; "Repeat_@"; True:C214)
	If ([CalendarEvents:80]RepeatsEveryNDay:25<=0)
		[CalendarEvents:80]RepeatsEveryNDay:25:=1
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "Repeat_@"; False:C215)
	[CalendarEvents:80]RepeatsEveryNDay:25:=0  //reset
End if 