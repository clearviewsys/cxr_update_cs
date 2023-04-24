//%attributes = {}

deleteRelatedFeeRegister
If ([Invoices:5]ThirdPartyisInvolved:22)
	// create a record in Registers for the fee paid in cash
	//read write([Registers])
	READ WRITE:C146([Registers:10])
	CREATE RECORD:C68([Registers:10])
	[Registers:10]InvoiceNumber:10:=[Invoices:5]InvoiceID:1+"-F"
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]RegisterType:4:="Cash"
	//[Registers]_:="N/A"
	[Registers:10]Debit:8:=[Invoices:5]feeLocal:6
	[Registers:10]AutoComments:12:=True:C214
	[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
	[Registers:10]RegisterDate:2:=[Invoices:5]invoiceDate:44  //Current date
	[Registers:10]AccountID:6:=makeCashAccountID(<>baseCurrency)
	//[Registers]CustomerBankInfo:=""
	SAVE RECORD:C53([Registers:10])
	UNLOAD RECORD:C212([Registers:10])
	READ ONLY:C145([Registers:10])
	
End if 
