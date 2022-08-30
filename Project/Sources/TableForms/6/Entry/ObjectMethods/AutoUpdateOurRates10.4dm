//


setEnterableIff(Self:C308->=False:C215; "spotRate@")
If ((Form event code:C388=On Clicked:K2:4) & (Self:C308->=False:C215))
	GOTO OBJECT:C206(*; "spotRateLocal")
End if 