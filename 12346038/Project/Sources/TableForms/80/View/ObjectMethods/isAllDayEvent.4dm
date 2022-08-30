If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	
	setEnterableIff(([CalendarEvents:80]isAllDayEvent:3=False:C215); "fromTime")
	setEnterableIff(([CalendarEvents:80]isAllDayEvent:3=False:C215); "toTime")
	
	
End if 