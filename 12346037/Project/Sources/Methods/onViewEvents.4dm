//%attributes = {}
C_BOOLEAN:C305($0)

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Load:K2:1))
	$0:=True:C214
Else 
	$0:=False:C215
	
End if 