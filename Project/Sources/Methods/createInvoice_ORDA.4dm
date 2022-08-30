//%attributes = {}
// createInvoice (obj) -> boolean
// create a new Invoice
// #unfinished
// #ORDA

var $obj; $invoice; $line; $status; $1 : Object
var $lines; $2 : Collection
var $success : Boolean
var $InvoiceID : Text
var $0 : Boolean

$obj:=$1
$lines:=$2
ASSERT:C1129($obj#Null:C1517)
ASSERT:C1129($lines#Null:C1517)


/*
.invoiceID
.customerID
.date
.type
.lines
.notes // printable notes
.isFlagged
.isLCT
.isEFT
.isSTR : bool
.isThirdPartyInvoved : bool
.lines // each line has a register strucure
{
 registerLines
}
*/

$invoice:=ds:C1482.Invoices.new()
$InvoiceID:=makeInvoiceID

If ($obj#Null:C1517)
	$invoice.fromObject($obj)  // first we assign the fields; and then we overwrite them
End if 
$invoice.UUID:=Generate UUID:C1066
$Invoice.invoiceID:=$InvoiceID
$success:=True:C214

For each ($line; $lines)
	//$register:=ds.Registers.new()
	//$register.fromObject($line)  // copy all info from the $line object
	//$register.UUID:=Generate UUID
	//$register.InvoiceNumber:=$InvoiceID
	//$register.CustomerID:=$obj.CustomerID
	//$register.save()
	$line.InvoiceNumber:=$invoiceID
	
	$success:=($success & createRegister_ORDA($line))  // success becomes true if all createRegisters are successful
End for each 


$status:=$invoice.save()  // the status will be returned to the calling method
$success:=($success & $status.success)
$0:=$success  // returns true or false
