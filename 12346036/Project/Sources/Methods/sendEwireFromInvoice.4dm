//%attributes = {}
PUSH RECORD:C176([Invoices:5])
READ ONLY:C145([Links:17])
C_TEXT:C284(veWireID)
C_BOOLEAN:C305($0)


C_TEXT:C284(vCustomerID; vInvoiceID)
vCustomerID:=[Invoices:5]CustomerID:2
vInvoiceNumber:=[Invoices:5]InvoiceID:1

vInvoiceID:=[Invoices:5]InvoiceID:1
veWireID:=makeeWireID
newRecord(->[eWires:13]; False:C215; "sendeWire")
If (OK=1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 

READ ONLY:C145([eWires:13])
POP RECORD:C177([Invoices:5])
