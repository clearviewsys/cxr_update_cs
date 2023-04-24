// form method

If (Form event code:C388=On Load:K2:1)
	Form:C1466.fromDate:=Current date:C33
	Form:C1466.toDate:=Current date:C33
	Form:C1466.filter:=New object:C1471
	GOTO OBJECT:C206(*; "search")
	acc_initGridArrays
	SET TIMER:C645(-1)
	
End if 

If (Form event code:C388=On Timer:K2:25)
	acc_refreshGrid
	SET TIMER:C645(0)
End if 

If (Form event code:C388=On Unload:K2:2)
	acc_initGridArrays
End if 