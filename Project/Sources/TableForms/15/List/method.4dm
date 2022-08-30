C_TIME:C306(<>inactivityTimeAllowed)
handleListForm

If (Form event code:C388=On Load:K2:1)
	SET TIMER:C645(60*60)
End if 

// these line are removed because find by content wouldn't work properly

//If ((Form event=On Activate ) | (Form event=On Timer ))
//allRecordsACTIVE_USERS 
//End if 

If (Form event code:C388=On Display Detail:K2:22)
	If ((Current time:C178-[WebSessions:15]LastActivityTime:6)>?00:05:00?)
		// _O_OBJECT SET COLOR([WebSessions]webUsername;calcColour(Red;White))
		OBJECT SET RGB COLORS:C628([WebSessions:15]webUsername:2; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(White:K11:1))
	Else 
		// _O_OBJECT SET COLOR([WebSessions]webUsername;calcColour(Black;White))
		OBJECT SET RGB COLORS:C628([WebSessions:15]webUsername:2; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
		
	End if 
End if 