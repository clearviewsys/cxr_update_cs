//%attributes = {}
// sendTodaysInvoiceToIM

// #ORDA
C_DATE:C307($date)

Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33
	: (Count parameters:C259=1)
		$date:=$1
	Else 
		
End case 

QUERY:C277([Invoices:5]; [Invoices:5]CreationDate:13=$date)

C_OBJECT:C1216($selection)
$selection:=Create entity selection:C1512([Invoices:5])
C_OBJECT:C1216($entities)
$entities:=$selection.om_registers
C_OBJECT:C1216($filled)
$filled:=ds:C1482.Registers.query("Link_92_return # null")
$entities:=$entities.minus($filled)
C_OBJECT:C1216($logs)
$logs:=IM_evaluateMoneyTransfers($entities; <>baseCurrency)