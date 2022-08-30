

If (Form event code:C388=On Printing Detail:K2:18)
	// colorizeOnTrue (->object; boolean; foreTrue;backTrue;foreFalse;BackFalse)
	
	colorizeOnTrue(->[Currencies:6]SpotRateLocal:17; [Currencies:6]hasFailedUpdate:37; Red:K11:4; White:K11:1; Dark grey:K11:12; White:K11:1)
	
End if 
