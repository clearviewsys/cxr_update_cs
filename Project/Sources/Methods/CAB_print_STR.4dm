//%attributes = {}
// CAB_print_STR
// PRE: Registers should be already selected

C_TEXT:C284(footermsg; $note)
C_LONGINT:C283(chkisCompany; chkisIndividual)

$note:="Note: Employees in charge of reporting shall notify the compliance officer immediately by telephone and send this report by e-mail. Please send report to compliance officer as soon as possible. Attach all revelant document of client.\r"
footermsg:=getKeyValue("cab.str.footermsg"; $note)


PRINT SETTINGS:C106

FIRST RECORD:C50([Registers:10])
While (Not:C34(End selection:C36([Registers:10])))
	
	RELATE ONE:C42([Registers:10]CustomerID:5)  // Get the customer related to the invoice
	
	Print form:C5([Customers:3]; "Customer_STR")
	If (OK=1)
		// automatically resolve the AML_Alert. 
	End if 
	NEXT RECORD:C51([Registers:10])
	
End while 



