If (Form event code:C388=On Load:K2:1)
	SET TIMER:C645(-1)
End if 

If (Form event code:C388=On Timer:K2:25)
	BRING TO FRONT:C326(Current process:C322)
	SET TIMER:C645(500)
End if 