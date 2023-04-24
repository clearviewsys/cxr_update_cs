//%attributes = {}

READ WRITE:C146([Registers:10])

If ((vRemainPaid>0) & (vToAmount>0))
	CREATE RECORD:C68([Registers:10])
	[Registers:10]InvoiceNumber:10:=[Invoices:5]InvoiceID:1
	[Registers:10]isReceived:13:=False:C215
	[Registers:10]RegisterType:4:="Cash"
	//[Registers]_:="N/A"
	[Registers:10]Credit:7:=vRemainPaid
	[Registers:10]AutoComments:12:=True:C214
	[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
	[Registers:10]RegisterDate:2:=[Invoices:5]invoiceDate:44  //Current date
	[Registers:10]AccountID:6:=makeCashAccountID([Invoices:5]toCurrency:8)
	//[Registers]CustomerBankInfo:=""
	SAVE RECORD:C53([Registers:10])
	UNLOAD RECORD:C212([Registers:10])
End if 

READ ONLY:C145([Registers:10])

relateManyRegisters