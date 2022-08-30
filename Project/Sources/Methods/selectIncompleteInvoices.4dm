//%attributes = {}
// selectIncompleteInvoices

// selects all the invoices that are not completed


ALL RECORDS:C47([Invoices:5])
READ ONLY:C145([Invoices:5])
READ ONLY:C145([Registers:10])
FIRST RECORD:C50([Invoices:5])
C_REAL:C285(vFromAmount; vToAmount; vFromBalance; vToBalance)
C_LONGINT:C283($i)
CREATE EMPTY SET:C140([Invoices:5]; "incompleteInvoices")
For ($i; 1; Records in selection:C76([Invoices:5]))
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[Invoices:5]InvoiceID:1)  // select all related REGISTERS (faster than relate many)
	
	calcInvoiceVars(->vFromAmount; ->vToAmount; ->vFromBalance; ->vToBalance)
	If ((vFromBalance#0) | (vToBalance#0))
		ADD TO SET:C119([Invoices:5]; "incompleteInvoices")
	End if 
	NEXT RECORD:C51([Invoices:5])
End for 
USE SET:C118("incompleteInvoices")
CLEAR SET:C117("incompleteInvoices")
FIRST RECORD:C50([Invoices:5])
