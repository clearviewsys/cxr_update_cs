C_TEXT:C284(vMACAddress)
C_TEXT:C284(vComputerName)
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(arrMACAddresses; 0)
		ALL RECORDS:C47([MACs:18])
		If (Records in selection:C76([MACs:18])>0)
			SELECTION TO ARRAY:C260([MACs:18]MACAddress:1; arrMACAddresses)
		End if 
		vMACAddress:=UTIL_getMacAddress
		vComputerName:=Current machine:C483
	: (Form event code:C388=On Clicked:K2:4)
		If (arrMACAddresses>0)
			vMACAddress:=arrMACAddresses{arrMACAddresses}
			QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=vMACAddress)
			vComputerName:=[MACs:18]ComputerName:19
		End if 
End case 
