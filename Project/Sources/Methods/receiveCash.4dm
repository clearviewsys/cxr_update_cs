//%attributes = {}
READ WRITE:C146([Registers:10])

If ((vRemainReceive>0) & (vFromAmount>0))
	CREATE RECORD:C68([Registers:10])
	[Registers:10]InvoiceNumber:10:=[Invoices:5]InvoiceID:1
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]RegisterType:4:="Cash"
	//[Registers]_:="N/A"
	[Registers:10]Debit:8:=vRemainReceive
	[Registers:10]AutoComments:12:=True:C214
	[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
	[Registers:10]RegisterDate:2:=Current date:C33
	[Registers:10]AccountID:6:=makeCashAccountID([Invoices:5]fromCurrency:3)
	//[Registers]CustomerBankInfo:=""
	SAVE RECORD:C53([Registers:10])
	UNLOAD RECORD:C212([Registers:10])
End if 

READ ONLY:C145([Registers:10])
relateManyRegisters