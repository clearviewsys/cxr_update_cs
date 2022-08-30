//%attributes = {}

RELATE ONE:C42([Registers:10]InvoiceNumber:10)

If (Records in selection:C76([Invoices:5])=0)
	
	CREATE RELATED ONE:C65([Registers:10]InvoiceNumber:10)
	[Invoices:5]CreatedByUserID:19:="system"
	[Invoices:5]CreationDate:13:=Current date:C33
	[Invoices:5]CreationTime:14:=Current time:C178
	[Invoices:5]invoiceDate:44:=[Registers:10]RegisterDate:2
	
	[Invoices:5]BranchID:53:=[Registers:10]BranchID:39
	[Invoices:5]InvoiceID:1:=[Registers:10]InvoiceNumber:10
	[Invoices:5]CustomerID:2:=[Registers:10]CustomerID:5
	[Invoices:5]printRemarks:16:="- automatically recreated from orphaned register"
	[Invoices:5]isFlagged:41:=True:C214
	
	//If ([Registers]Currency#<>BASECURRENCY)
	//If ([Registers]Debit>0)
	//[Invoices]fromAmount:=[Registers]Debit
	//[Invoices]fromCurrency:=[Registers]Currency
	//Else 
	//[Invoices]toAmount:=[Registers]credit
	//[Invoices]toCurrency:=[Registers]Currency
	//
	//end if
	//END IF
	
	SAVE RELATED ONE:C43([Registers:10]InvoiceNumber:10)
End if 