C_BOOLEAN:C305($hide)

CONFIRM:C162("Hide or publish XML rates on the website?"; "Hide"; "Publish")
If (ok=1)
	$hide:=True:C214
Else 
	$hide:=False:C215
End if 

CONFIRM:C162("Are you sure you want to apply the changes to the records")
If (OK=1)
	USE SET:C118("$currencies_LBSet")
	
	READ WRITE:C146([Currencies:6])
	APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]isHiddenOnXML:36:=$hide)
	APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]isHiddenOnRatePanel:35:=$hide)
	READ ONLY:C145([Currencies:6])
End if 