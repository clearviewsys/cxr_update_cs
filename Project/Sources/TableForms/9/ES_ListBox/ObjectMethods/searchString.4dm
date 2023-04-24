If (Form event code:C388=On Load:K2:1)
	Form:C1466.searchString:=""
End if 

If (Form event code:C388=On Data Change:K2:15)
	SET TIMER:C645(5)
	GOTO OBJECT:C206(*; "searchString")
End if 