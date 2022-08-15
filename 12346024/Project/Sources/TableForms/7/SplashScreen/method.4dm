If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(vApplicationName; vClientName; vStructureName; vCurrentVersion)
	vClientName:=Current machine:C483  // returns the name of the machine
	vApplicationName:="4D Standalone"
	vCurrentVersion:=getCurrentVersion
	Case of 
		: (Application type:C494=4D Server:K5:6)
			vApplicationName:="4D Server"
		: (Application type:C494=4D Remote mode:K5:5)
			vApplicationName:="4D Client"
		: (Application type:C494=4D Local mode:K5:1)
			vApplicationName:="4D Local mode"
		: (Application type:C494=4D Desktop:K5:4)
			vApplicationName:="4D Runtime Single User"
		: (Application type:C494=4D Volume desktop:K5:2)
			vApplicationName:="4D Runtime Volume License"
	End case 
	vStructureName:=Structure file:C489
	vDataFile:=Data file:C490
	
	WA OPEN URL:C1020(*; "spashscreenWebArea"; "http://www.clearviewsys.com/banners/Professional_Currency_Exchange_Software_CurrencyXchanger_4D_2.gif")
	
End if 