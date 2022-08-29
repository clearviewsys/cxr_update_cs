If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206(*; "vSearchString")
End if 

If (Form event code:C388=On Timer:K2:25)
	SET TIMER:C645(0)  // reset the timer
	
End if 