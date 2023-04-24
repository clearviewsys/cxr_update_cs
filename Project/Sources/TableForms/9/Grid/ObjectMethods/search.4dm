If (Form event code:C388=On Data Change:K2:15)
	SET TIMER:C645(-1)
	GOTO OBJECT:C206(*; "search")
End if 