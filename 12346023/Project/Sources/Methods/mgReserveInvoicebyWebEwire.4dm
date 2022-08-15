//%attributes = {}
C_TEXT:C284($1; $customerID)
C_OBJECT:C1216($invoice; $saveStatus)
C_OBJECT:C1216($0)

$customerID:=$1
$0:=New object:C1471
$0.success:=False:C215

If (True:C214)  // use old commands because of Sequnce number is not increasing when record is created using ORDA
	
	CREATE RECORD:C68([Invoices:5])
	[Invoices:5]BranchID:53:=getBranchID
	[Invoices:5]CreatedByUserID:19:=getApplicationUser
	[Invoices:5]CreationDate:13:=Current date:C33
	[Invoices:5]CreationTime:14:=Current time:C178
	[Invoices:5]CustomerID:2:=$customerID
	[Invoices:5]invoiceDate:44:=[Invoices:5]CreationDate:13
	[Invoices:5]InvoiceID:1:=makeInvoiceID
	SAVE RECORD:C53([Invoices:5])
	
	$0.success:=True:C214
	$0.InvoiceID:=[Invoices:5]InvoiceID:1
	
Else 
	$invoice:=ds:C1482.Invoices.new()
	
	$invoice.InvoiceID:=makeInvoiceID
	
	$invoice.BranchID:=getBranchID
	
	$invoice.CreationDate:=Current date:C33
	$invoice.CreationTime:=Current time:C178
	$invoice.invoiceDate:=$invoice.CreationDate
	
	$invoice.CustomerID:=$customerID
	
	$saveStatus:=$invoice.save()
	
	If ($saveStatus.success)
		$0.success:=True:C214
	Else 
		$0.success:=False:C215
	End if 
End if 
