//%attributes = {}
CONFIRM:C162("Are you sure you want to update all the old registers?")
If (OK=1)
	ALL RECORDS:C47([Invoices:5])
	//QUERY SELECTION([Invoices];[Invoices]isNewVersion=False)  ` select older invoices only
	
	READ ONLY:C145([Invoices:5])
	FIRST RECORD:C50([Invoices:5])
	C_LONGINT:C283($i)
	For ($i; 1; Records in selection:C76([Invoices:5]))
		LOAD RECORD:C52([Invoices:5])
		relateManyRegisters
		fixOldRegistersLines
		NEXT RECORD:C51([Invoices:5])
	End for 
	UNLOAD RECORD:C212([Invoices:5])
	myAlert("Update completed")
End if 
