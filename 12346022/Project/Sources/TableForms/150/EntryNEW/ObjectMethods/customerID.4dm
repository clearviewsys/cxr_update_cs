C_TEXT:C284($customerID)
$customerID:=Form:C1466.customerID  // default value
Form:C1466.customerID:=pickCustomer(->$customerID)
Form:C1466.group:=[Customers:3]GroupName:90
C_OBJECT:C1216($e)
//[Invoices]InvoiceSerial
$e:=ds:C1482.Invoices.query("CustomerID = :1"; $customerID).orderBy("InvoiceSerial desc")
If ($e.length>0)
	Form:C1466.invoiceID:=$e[0].InvoiceID  // last invoice
End if 