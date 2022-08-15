//%attributes = {}
// finalizeeWireTransaction

// this method is called from the OK button of invoice entry

//  PRE: invoice must be loaded

// POST: eWire selection will be touched

C_TEXT:C284($1)

QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$1)
If (Records in selection:C76([eWires:13])=1)
	READ WRITE:C146([eWires:13])  // critical write
	
	LOAD RECORD:C52([eWires:13])  // lock the record for modification
	
	
	[eWires:13]isSettled:23:=True:C214
	[eWires:13]eWireStatus:121:=3
	[eWires:13]InvoiceNumber:29:=vInvoiceNumber
	SAVE RECORD:C53([eWires:13])
	UNLOAD RECORD:C212([eWires:13])  // release the record
	
	READ ONLY:C145([eWires:13])  // unlock the table
	
End if 