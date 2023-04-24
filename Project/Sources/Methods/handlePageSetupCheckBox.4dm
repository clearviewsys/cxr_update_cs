//%attributes = {}
C_BOOLEAN:C305(<>DisplayPageSetup)

If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(vPageSetup)
	vPageSetup:=booleanToNum(<>DisplayPageSetup)
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	<>DisplayPageSetup:=numToBoolean(vPageSetup)
End if 