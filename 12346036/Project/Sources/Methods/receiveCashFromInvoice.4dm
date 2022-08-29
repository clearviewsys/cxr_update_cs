//%attributes = {}
PUSH RECORD:C176([Invoices:5])
C_BOOLEAN:C305($0)


C_TEXT:C284(vInvoiceID; vInvoiceNumber)
vInvoiceNumber:=[Invoices:5]InvoiceID:1
vInvoiceID:=[Invoices:5]InvoiceID:1  // maybe an error
veWireID:=makeeWireID
newRecord(->[eWires:13]; False:C215; "sendeWire")
If (OK=1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 

READ ONLY:C145([eWires:13])
POP RECORD:C177([Invoices:5])
