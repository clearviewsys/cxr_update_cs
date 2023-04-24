C_LONGINT:C283($i)
C_POINTER:C301($self)
$self:=Self:C308

$i:=$self->

Case of 
	: ($i=1)  // nothing
	: ($i=2)  // registers
		saveSelectedRecordsSetToDisk(->[Registers:10])
		
	: ($i=3)  // customers
		RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])
		saveSelectedRecordsSetToDisk(->[Customers:3])
		
		
	: ($i=4)  // Invoices
		RELATE ONE SELECTION:C349([Registers:10]; [Invoices:5])
		saveSelectedRecordsSetToDisk(->[Invoices:5])
		
	: ($i=5)  // Cheques
		RELATE ONE SELECTION:C349([Registers:10]; [Cheques:1])
		saveSelectedRecordsSetToDisk(->[Cheques:1])
		
	: ($i=6)  // Wires
		RELATE ONE SELECTION:C349([Registers:10]; [Wires:8])
		saveSelectedRecordsSetToDisk(->[Wires:8])
		
	: ($i=7)  // eWires
		RELATE ONE SELECTION:C349([Registers:10]; [eWires:13])
		saveSelectedRecordsSetToDisk(->[eWires:13])
		
	: ($i=8)  // Cash Transactions
		RELATE ONE SELECTION:C349([Registers:10]; [CashTransactions:36])
		saveSelectedRecordsSetToDisk(->[CashTransactions:36])
		
	: ($i=9)  // Account InOuts
		RELATE ONE SELECTION:C349([Registers:10]; [AccountInOuts:37])
		saveSelectedRecordsSetToDisk(->[AccountInOuts:37])
		
	: ($i=10)  // items
		RELATE ONE SELECTION:C349([Registers:10]; [ItemInOuts:40])
		saveSelectedRecordsSetToDisk(->[ItemInOuts:40])
	Else 
		
End case 