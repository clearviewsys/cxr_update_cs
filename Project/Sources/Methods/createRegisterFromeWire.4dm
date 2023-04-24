//%attributes = {}
READ WRITE:C146([Registers:10])
CREATE RECORD:C68([Registers:10])

[Registers:10]InvoiceNumber:10:=[eWires:13]InvoiceNumber:29
[Registers:10]isReceived:13:=False:C215
[Registers:10]RegisterType:4:="eWire"

[Registers:10]Credit:7:=[eWires:13]ToAmount:14
[Registers:10]AutoComments:12:=True:C214
[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
[Registers:10]RegisterDate:2:=[Invoices:5]invoiceDate:44  //Current date
[Registers:10]AccountID:6:=[eWires:13]AccountID:30


[Registers:10]SubAccountID:58:=[eWires:13]AgentID:26  // changed in  version 4.396
[Registers:10]ReferenceNo:57:=[eWires:13]AgentInternalRef:40+":"+[eWires:13]ReferenceNo:28


//[Registers]CustomerBankInfo:=[Links]CustomerBankInfo
[Registers:10]InternalRecordID:18:=[eWires:13]eWireID:1
[Registers:10]InternalTableNumber:17:=Table:C252(->[eWires:13])

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
