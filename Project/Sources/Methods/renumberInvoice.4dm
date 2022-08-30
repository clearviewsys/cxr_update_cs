//%attributes = {}
C_TEXT:C284($from; $to)
C_LONGINT:C283($invoices; $registers; $ewires)

$from:=Request:C163("Change what number?")
$to:=Request:C163("To what number?")

If (OK=1)
	READ WRITE:C146([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=$from)
	$invoices:=Records in selection:C76([Invoices:5])
	APPLY TO SELECTION:C70([Invoices:5]; [Invoices:5]InvoiceID:1:=$to)
	READ ONLY:C145([Invoices:5])
	
	READ WRITE:C146([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$from)
	$registers:=Records in selection:C76([Registers:10])
	APPLY TO SELECTION:C70([Registers:10]; [Registers:10]InvoiceNumber:10:=$to)
	READ ONLY:C145([Registers:10])
	
	READ WRITE:C146([eWires:13])
	QUERY:C277([eWires:13]; [eWires:13]InvoiceNumber:29=$from)
	$eWires:=Records in selection:C76([eWires:13])
	APPLY TO SELECTION:C70([eWires:13]; [eWires:13]InvoiceNumber:29:=$to)
	READ ONLY:C145([eWires:13])
	
	myAlert(String:C10($invoices)+" Invoice changed. "+String:C10($registers)+" registers changed. "+String:C10($ewires)+" eWires changed")
End if 