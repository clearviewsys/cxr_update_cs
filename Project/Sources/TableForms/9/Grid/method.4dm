// form method for [Accounts];"Grid" form
// see also: acc_displayGrid that opens the form

If (Form event code:C388=On Load:K2:1)
	
	GOTO OBJECT:C206(*; "search")
	acc_initGridFormVars
	acc_initGridArrays
	
	//SET TIMER(-1)
	
End if 

If (Form event code:C388=On Timer:K2:25)
	acc_refreshGrid
	SET TIMER:C645(0)
End if 

If (Form event code:C388=On Unload:K2:2)
	// clear the arrays
	acc_initGridArrays
End if 