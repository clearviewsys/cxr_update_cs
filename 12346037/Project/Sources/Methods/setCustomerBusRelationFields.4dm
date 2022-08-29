//%attributes = {}
// this method will set the following fields to the date of the second transaction over 3K
// [Customers]AML_BusinessRelationStarted
// [Customers]AML_isInBusinessRelation

// PRE: one customer is selected 
// POST: the 'business relationship status may become true ; the start of business relationship date may be affected


C_TEXT:C284($customerID; $1)
C_REAL:C285($limit; $value)
$limit:=3000

Case of 
	: (Count parameters:C259=0)
		$customerID:="QSCUS20431"
	: (Count parameters:C259=1)
		$customerID:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// find invoices with values over 3K
// find the date of the second invoice
// 
C_OBJECT:C1216($invoices; $invoice; $registers)
//[Invoices]invoiceDate
$invoices:=ds:C1482.Invoices.query("CustomerID=:1 order by invoiceDate asc"; $customerID)
$value:=0
C_LONGINT:C283($count)
$count:=0
For each ($invoice; $invoices) Until ($count>1)
	//[Registers]DebitLocal
	//[Registers]InvoiceNumber
	$value:=$invoice.om_registers.sum("DebitLocal")  // find registers that are related to this invoice and sum the value of debit local
	If ($value>=$limit)
		$count:=$count+1
	End if 
End for each 

If ($count=2)
	If ([Customers:3]AML_isInBusinessRelation:115=0)
		[Customers:3]AML_BusinessRelationStarted:119:=$invoice.invoiceDate
		[Customers:3]AML_isInBusinessRelation:115:=1
		createNoteForCustomer($customerID; "Auto-assigned Business Relationship status \r\nBased on Invoice:"+$invoice.InvoiceID; True:C214)
	End if 
End if 