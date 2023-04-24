C_BOOLEAN:C305($hide)

If (Records in set:C195("$Currencies_LBSet")=0)
	ALERT:C41("Please highlight some records first.")
Else 
	CONFIRM:C162("Hide or publish XML rates on the website?"; "Hide"; "Publish")
	If (ok=1)
		$hide:=True:C214
	Else 
		$hide:=False:C215
	End if 
	
	CONFIRM:C162("Are you sure you want to apply the changes to the records")
	If (OK=1)
		READ WRITE:C146([Currencies:6])
		USE SET:C118("$Currencies_LBSet")
		APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]isHiddenOnXML:36:=$hide)
		APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]isHiddenOnRatePanel:35:=$hide)
		READ ONLY:C145([Currencies:6])
	End if 
End if 