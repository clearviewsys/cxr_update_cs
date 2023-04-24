
If (Position:C15("Lotus"; <>COMPANYNAME)>0)
	writeLotusRatex
	writeAndUploadXMLRates
Else 
	writeAndUploadXMLRates
End if 

