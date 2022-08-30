//%attributes = {}
// getCustomerLastInvoiceDate($customerID: TEXT) -> $lastInvoiceDate: DATE
// @viktor

C_TEXT:C284($customerID; $1)
C_DATE:C307($lastInvoiceDate; $0)
C_OBJECT:C1216($lastInvoice)

Case of 
	: (Count parameters:C259=1)
		$customerID:=$1
	Else 
		assertInvalidNumberOfParams
End case 

$lastInvoice:=ds:C1482.Invoices.query("CustomerID="+$customerID).orderBy("CreationDate desc").first()

If ($lastInvoice#Null:C1517)
	$lastInvoiceDate:=ds:C1482.Invoices.query("CustomerID="+$customerID).orderBy("CreationDate desc").first().CreationDate
End if 

$0:=$lastInvoiceDate