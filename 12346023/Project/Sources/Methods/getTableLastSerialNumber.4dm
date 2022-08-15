//%attributes = {}
//   ` getTableLastSerialNumber (->table) -> serial no
// this method returns the lastserialnumber for a table
// POST: this method returns the next serial no for a table, and increases that last number

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($0; $serialNo)

If (Count parameters:C259=1)
	$tablePtr:=$1
Else 
	$tablePtr:=->[Invoices:5]
End if 

QUERY:C277([SerialGenerator:67]; [SerialGenerator:67]TableNo:1=Table:C252($tablePtr))

If (Records in selection:C76([SerialGenerator:67])=0)  // not found
	$serialNo:=0
Else   // found a record
	
	$serialNo:=[SerialGenerator:67]LastSerialNo:2
End if 

$0:=$serialNo