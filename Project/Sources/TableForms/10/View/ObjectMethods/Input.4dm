

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217([Registers:10]metaData:66; *))
		iH_Notify("Copied"; "MetaData is on the clipboard.")
		
	Else 
		
End case 