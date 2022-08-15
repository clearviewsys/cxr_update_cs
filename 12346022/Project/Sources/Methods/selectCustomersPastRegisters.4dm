//%attributes = {}
// selectPastRegisterForCustomer (customerID; days; invoiceNumber ) -> returns the number of registers selected 
// POST: changes the selection on [registers] table


C_TEXT:C284($customerID; $1; $thisInvoiceNumber; $3)
C_LONGINT:C283($days; $2)
//C_LONGINT($0)
C_OBJECT:C1216($0)


Case of 
	: (Count parameters:C259=1)
		$customerID:=$1
		$days:=1
		$thisInvoiceNumber:=[Invoices:5]InvoiceID:1
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$days:=$2
		$thisInvoiceNumber:=[Invoices:5]InvoiceID:1
		
	: (Count parameters:C259=3)
		$customerID:=$1
		$days:=$2
		$thisInvoiceNumber:=$3
	Else 
		$customerID:=getWalkInCustomerID
		$days:=1
		$thisInvoiceNumber:=""
		
End case 

If ($days<=0)
	$days:=1  // min is 24 hours or 1 day 
End if 

C_DATE:C307($today; $fromDate)
$today:=Current date:C33
$fromDate:=Add to date:C393($today; 0; 0; -$days)

If (True:C214)
	$0:=ds:C1482.Registers.query("CustomerID == :1 AND RegisterDate >= :2 AND "+\
		"RegisterDate <= :3 AND InvoiceNumber # :4"; $customerID; $fromDate; $today; $thisInvoiceNumber)
	
Else 
	//SET QUERY DESTINATION(Into current selection)
	
	//QUERY([Registers];[Registers]CustomerID=$customerID;*)
	//QUERY([Registers]; & ;[Registers]RegisterDate>=$fromdate;*)
	//QUERY([Registers]; & ;[Registers]RegisterDate<=$today;*)
	//QUERY([Registers]; & ;[Registers]InvoiceNumber#$thisInvoiceNumber)
	
	
	//$0:=Records in selection([Registers])
End if 