C_LONGINT:C283(vTodaysEvents; vTomorrowsEvents)

If (Form event code:C388=On Load:K2:1)
	C_DATE:C307(vEventCalendarDate)
	vEventCalendarDate:=Current date:C33
	
	SET TIMER:C645(600)
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Timer:K2:25))
	selectCalendarEventsByDate(vEventCalendarDate)
	fillCalendarEventMiniList
	vTodaysEvents:=countCalendarEventsinDate(vEventCalendarDate)
	vTomorrowsEvents:=countCalendarEventsinDate(vEventCalendarDate+1)
End if 