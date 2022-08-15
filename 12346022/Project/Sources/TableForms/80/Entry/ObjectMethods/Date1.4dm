handleDateWidget(Self:C308)

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		[CalendarEvents:80]nextScheduledDate:27:=[CalendarEvents:80]Date:4
		
		POST OUTSIDE CALL:C329(Current process:C322)
		
	Else 
		
End case 