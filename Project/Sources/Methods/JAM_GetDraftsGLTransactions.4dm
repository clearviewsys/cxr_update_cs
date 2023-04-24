//%attributes = {}
// JAM_GetDraftsGLTransactions
// Query Transactions for GL Report

C_BOOLEAN:C305($1; $useBaseCurr; $2; $exported)
C_OBJECT:C1216($0; $registers; $r)
ARRAY TEXT:C222($arrRegID; 0)

Case of 
		
	: (Count parameters:C259=0)
		$useBaseCurr:=False:C215
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$useBaseCurr:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$useBaseCurr:=$1
		$exported:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$registers:=ds:C1482.Registers.query("RegisterDate >= :1 AND RegisterDate <= :2 "; fromDate; toDate)
If ($useBaseCurr)
	$registers:=$registers.query("Currency == :1"; <>baseCurrency)
Else 
	$registers:=$registers.query("Currency != :1"; <>baseCurrency)
End if 


$registers:=$registers.query("InternalTableNumber == :1 OR InternalTableNumber == :2"; 1; 8)
// $registers:=$registers.query("InternalTableNumber == :1";8)
// $registers:=$registers.query("InternalTableNumber == :1";1)

$registers:=$registers.query("isExported == :1"; $exported)
$registers:=$registers.query(" CreditLocal >0 OR DebitLocal > 0 ")

$registers:=$registers.query("isCash == false")
$registers:=$registers.query("isCancelled == false")
$registers:=$registers.query("isTransfer == false")
$registers:=$registers.orderBy("RegisterID")

// $registers:=$registers.query("InvoiceNumber == :1";"TTINV139917") // Cash and Check
// $registers:=$registers.query("InvoiceNumber == :1";"TTINV139916")  // 2 cash 1 Check
// $registers:=$registers.query("InvoiceNumber == :1";"TTINV139919")  // Wires 


// Get all invoces related to Registers selected
C_OBJECT:C1216($invoices)
$invoices:=$registers.invoice.orderBy("InvoiceID asc")

$0:=$invoices

//USE ENTITY SELECTION($registers)


If (True:C214)
	
	
	If (Not:C34($exported))
		REDUCE SELECTION:C351([Registers:10]; 0)
		
		For each ($r; $registers)
			APPEND TO ARRAY:C911($arrRegID; $r.RegisterID)
		End for each 
		
		
	End if 
End if 

READ ONLY:C145([Registers:10])
QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; $arrRegID)
