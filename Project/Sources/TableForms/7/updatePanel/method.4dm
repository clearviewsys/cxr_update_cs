C_LONGINT:C283(vMinutes)
C_TEXT:C284(vLastUpdate)

C_LONGINT:C283(<>updateFrequency)
C_BOOLEAN:C305(<>autoPublishXMLRates)

C_LONGINT:C283($seconds)

If (Form event code:C388=On Load:K2:1)
	
	vMinutes:=<>updateFrequency  // update every 10 minutes
	SET TIMER:C645(vMinutes*60*60)
	//SET VISIBLE(*;"updateSpot";False)
	cbAutoRefresh:=Num:C11(<>isRefreshRatesOnByDefault)  // load the default 
	cbAutoPublish:=Num:C11(<>autoPublishXMLRates)  // load the default
	
End if 

If (Form event code:C388=On Timer:K2:25)
	
	If (cbAutoRefresh=1)
		handleRefreshRatesNow
	End if 
	
	If (cbAutoPublish=1)
		writeAndUploadXMLRates
	End if 
	
End if 

If (Form event code:C388=On Close Box:K2:21)
	CONFIRM:C162("Closing this window will stop automatic updates."; "Close"; "Leave Open")
	If (ok=1)
		CANCEL:C270
	End if 
End if 