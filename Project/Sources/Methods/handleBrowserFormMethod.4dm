//%attributes = {}
C_TEXT:C284(vCurrentVersion)
C_PICTURE:C286(SYNC_picStatus)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		
		SET MENU BAR:C67(1; Current process:C322)
		//calcCountVars 
		
		vCurrentVersion:=getCurrentVersion
		
		//If (getClientAutoRefreshBrowser )
		//SET TIMER(-1)  // call the timer event immediately after everything loads
		//Else 
		//SET TIMER(0)  //disable the timer event
		//End if 
		
		OBJECT SET TITLE:C194(*; "bidWid"; getBranchID+" - "+getCurrentMachineName)
		
		If (Sync_Is_Status_On("enabled"))
			SYNC_statusProcess(Current process:C322)
		End if 
		
		SET TIMER:C645(-1)  // call the timer event immediately after everything loads
		
		
		
	: (Form event code:C388=On Timer:K2:25)  // & (getClientAutoRefreshBrowser )  //shouldn't need the autorefresh...
		
		//calcCountVars 
		If (getClientAutoRefreshBrowser)
			
			If (Sync_Is_Status_On("enabled"))
				SYNC_statusProcess(Current process:C322)
			End if 
			
			If (Current user:C182="designer")
				SET TIMER:C645(60*5)  //5 seconds
			Else 
				SET TIMER:C645(60*60*10)  // every 10 mins
			End if 
			
		Else 
			SET TIMER:C645(0)  //disable the timer event
		End if 
		
		
	: (Form event code:C388=On Close Box:K2:21)
		CONFIRM:C162("Are you sure you want to close the browser?")
		If (OK=1)
			CANCEL:C270
		End if 
		
	Else 
		
End case 