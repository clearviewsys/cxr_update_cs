//%attributes = {}
// newInvoiceObjFromRecord
// PRE: Invoices Record must be in memory

// this method returns an object (not an entity) that is compatible in terms of attributes with an Invoices entity
// however this object doesn't contain all the fields

C_OBJECT:C1216($invoiceObj; $0)
$invoiceObj:=New object:C1471
// the reason that we create the invoice Object from scratch (using new Object) is because this Invoice hasn't been saved in the database yet
// ... so there's no way we can run a query and load the record in an entity
// 
// the following naming is compatible with the naming of the Invoices table. 

$invoiceObj.InvoiceID:=[Invoices:5]InvoiceID:1
$invoiceObj.invoiceDate:=[Invoices:5]invoiceDate:44
$invoiceObj.CustomerID:=[Invoices:5]CustomerID:2


$invoiceObj.AMLPurposeOfTransaction:=[Invoices:5]AMLPurposeOfTransaction:85
$invoiceObj.SourceOfFund:=[Invoices:5]SourceOfFund:68
$invoiceObj.didAskIfThirdPartyIsInvolved:=[Invoices:5]didAskIfThirdPartyIsInvolved:96
$invoiceObj.ThirdPartyName:=[Invoices:5]ThirdPartyName:29

$invoiceObj.didAskIfCustomerIsPEP:=[Invoices:5]didAskIfCustomerIsPEP:65
$invoiceObj.CustomerPEPNotes:=[Invoices:5]CustomerPEPNotes:81

$0:=$invoiceObj