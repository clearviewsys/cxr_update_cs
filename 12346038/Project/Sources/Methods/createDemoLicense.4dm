//%attributes = {}

If (Application type:C494=4D Server:K5:6)  // Modified by: Barclay (1/26/2012)
	//don't run on server. GMA is not 64bit compatible
Else 
	READ ONLY:C145([MACs:18])
	QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=UTIL_getMacAddress)
	
	If (Records in selection:C76([MACs:18])=0)
		// create the self customer
		READ WRITE:C146([MACs:18])
		CREATE RECORD:C68([MACs:18])
		[MACs:18]ComputerName:19:=getCurrentMachineName
		[MACs:18]MACAddress:1:=UTIL_getMacAddress  //Get MAC address 
		If (Application type:C494=4D Remote mode:K5:5)
			[MACs:18]isServer:18:=False:C215
		Else 
			[MACs:18]isServer:18:=True:C214
		End if 
		setMACsVarsToDemoMode
		SAVE RECORD:C53([MACs:18])
		UNLOAD RECORD:C212([MACs:18])
		READ ONLY:C145([MACs:18])
		createRecordTableLimitations(0; True:C214; 200; Current date:C33+21)
		
	End if 
End if 