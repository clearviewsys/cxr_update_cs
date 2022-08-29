//%attributes = {}
// createeWireReceiveRegister(eWireID)

READ WRITE:C146([Registers:10])
CREATE RECORD:C68([Registers:10])
[Registers:10]InvoiceNumber:10:=[Invoices:5]InvoiceID:1
[Registers:10]isReceived:13:=True:C214
[Registers:10]RegisterType:4:="eWire"
//[Registers]_:=[eWires]eWireID
[Registers:10]Debit:8:=[eWires:13]FromAmount:13
[Registers:10]AutoComments:12:=True:C214
[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
[Registers:10]RegisterDate:2:=Current date:C33
If ([eWires:13]AccountID:30="")
	[Registers:10]AccountID:6:=[Accounts:9]AccountID:1
Else 
	[Registers:10]AccountID:6:=[eWires:13]AccountID:30
End if 

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])