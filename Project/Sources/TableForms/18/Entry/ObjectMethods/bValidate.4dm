checkInit
validateMACs
If (isValidationConfirmed)
	If ([MACs:18]MACAddress:1=UTIL_getMacAddress)  // this computer
		If ([MACs:18]allowWebServing:21=True:C214)
			WEB START SERVER:C617
		Else 
			WEB STOP SERVER:C618
		End if 
	End if 
	//validatetransaction // disabled by: Barclay Berry (2/24/13) per Tiran
Else 
	REJECT:C38
End if 
