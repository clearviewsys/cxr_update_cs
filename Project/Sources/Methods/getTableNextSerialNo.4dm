//%attributes = {}
// getTableNextSerialNo (->table) -> serial no
// call this method only before saving a record
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
	// create a record
	READ WRITE:C146([SerialGenerator:67])
	CREATE RECORD:C68([SerialGenerator:67])
	[SerialGenerator:67]TableNo:1:=Table:C252($tablePtr)
	[SerialGenerator:67]LastSerialNo:2:=1
	SAVE RECORD:C53([SerialGenerator:67])
	UNLOAD RECORD:C212([SerialGenerator:67])
	
	$serialNo:=1
Else   // found a record
	
	// what if the record is locked???????????????
	READ WRITE:C146([SerialGenerator:67])
	LOAD RECORD:C52([SerialGenerator:67])
	[SerialGenerator:67]LastSerialNo:2:=[SerialGenerator:67]LastSerialNo:2+1
	$serialNo:=[SerialGenerator:67]LastSerialNo:2
	
	SAVE RECORD:C53([SerialGenerator:67])
	UNLOAD RECORD:C212([SerialGenerator:67])
	
End if 

$0:=$serialNo