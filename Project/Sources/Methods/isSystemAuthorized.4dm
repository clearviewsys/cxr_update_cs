//%attributes = {}
C_TEXT:C284($mac)
C_BOOLEAN:C305($0)

If (Application type:C494=4D Server:K5:6)
	// Modified by: Barclay (2/2/2012) - temp fix to get server started as service
Else 
	READ ONLY:C145([MACs:18])
	$mac:=UTIL_getMacAddress
	QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=$mac)
	LOAD RECORD:C52([MACs:18])
	If (Records in selection:C76([MACs:18])=0)
		myAlert("This workstation is not authorized.")
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
	
	If (([MACs:18]ExpirationDate:2#!00-00-00!) & (Current date:C33>[MACs:18]ExpirationDate:2))  // if today's date is after the expire date -> license expired
		myAlert("Sorry, this license expired on "+String:C10([MACs:18]ExpirationDate:2))
		$0:=False:C215
	Else 
		If (([MACs:18]ExpirationDate:2#!00-00-00!) & ([MACs:18]ExpirationDate:2-Current date:C33<=15))  // less than 2 weeks to expiry
			myAlert("This license will expire on "+String:C10([MACs:18]ExpirationDate:2))
			
			If (<>administratorEmail="")
			Else 
				
				// commented out on 04/06/23 during tech support meeting because it was looping and slowing everything down @milan
				// sendNotificationByEmail(<>administratorEmail; "License expiration approaching"; getThisComputerBranchID+"-"+[MACs]ComputerName+" license will expire on "+String([MACs]ExpirationDate))
			End if 
		End if 
	End if 
	
	If ([MACs:18]LaunchLimit:3>0)  // if launch is still positive
		If ([MACs:18]LaunchLimit:3<=10)
			myAlert("This license will expire after "+String:C10([MACs:18]LaunchLimit:3)+" more launch. ")
		End if 
		READ WRITE:C146([MACs:18])
		LOAD RECORD:C52([MACs:18])
		[MACs:18]LaunchLimit:3:=[MACs:18]LaunchLimit:3-1
		SAVE RECORD:C53([MACs:18])
		UNLOAD RECORD:C212([MACs:18])
		READ ONLY:C145([MACs:18])
		
	Else   // launch is either 0 or negative; 0 means software expired; -1 is okay
		If ([MACs:18]LaunchLimit:3=0)
			myAlert("This license has been expired. Please contact the provider to extend your "+"license.")
			$0:=False:C215
		End if 
	End if 
	
	If ((Application type:C494#4D Remote mode:K5:5) & ([MACs:18]allowWebServing:21))
		WEB START SERVER:C617
	Else 
		WEB STOP SERVER:C618
	End if 
	
End if 