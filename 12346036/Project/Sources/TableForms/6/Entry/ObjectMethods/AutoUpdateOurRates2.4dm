If (Form event code:C388=On Load:K2:1)
	If (Is new record:C668([Currencies:6]))
		[Currencies:6]doPreventShortSelling:54:=<>DOWARNONSHORTSELLING
	End if 
Else 
	// on click or on data change
	
End if 


