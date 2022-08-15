//%attributes = {}
C_BOOLEAN:C305(<>previewBeforePrint)

If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(cbPreviewBeforePrint)
	cbPreviewBeforePrint:=booleanToNum(<>previewBeforePrint)
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	<>previewBeforePrint:=numToBoolean(cbPreviewBeforePrint)
End if 