//If (Form event=On Load )
//cbAutoPublish:=Num(◊isRefreshRatesOnByDefault)
//End if 

If (Self:C308->=1)
	writeAndUploadXMLRates
End if 

If (Self:C308->=0)
	CONFIRM:C162("Are you sure you want to turn off automatic XML Publish?"; "Keep On"; "Turn Off")
	If (Ok=1)
		Self:C308->:=1
	Else 
		Self:C308->:=0
	End if 
End if 