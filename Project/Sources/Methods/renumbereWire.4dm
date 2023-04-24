//%attributes = {}
C_TEXT:C284($from; $to)
C_LONGINT:C283($invoices; $registers; $ewires)

$from:=Request:C163("Change which eWire number?")
$to:=Request:C163("To what number?")
If (OK=1)
	READ WRITE:C146([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]eWireID:23=$from)
	$invoices:=Records in selection:C76([Invoices:5])
	APPLY TO SELECTION:C70([Invoices:5]; [Invoices:5]eWireID:23:=$to)
	READ ONLY:C145([Invoices:5])
	
	
	READ WRITE:C146([eWires:13])
	QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$from)
	$eWires:=Records in selection:C76([eWires:13])
	APPLY TO SELECTION:C70([eWires:13]; [eWires:13]eWireID:1:=$to)
	READ ONLY:C145([eWires:13])
	
	myAlert(String:C10($invoices)+" Invoice changed. "+String:C10($ewires)+" eWires changed")
End if 
