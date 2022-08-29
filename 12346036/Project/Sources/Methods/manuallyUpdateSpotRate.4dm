//%attributes = {}
CONFIRM:C162("Do you want to update the spot rate now? (It may take a few seconds)")
If (OK=1)
	handleAutoUpdateRates
End if 
