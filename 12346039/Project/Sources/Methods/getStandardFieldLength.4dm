//%attributes = {}
// getStandardFieldLength (->[fieldPtr])
// return the length of fields that are important in the schema of the database

C_POINTER:C301($fieldPtr; $1)
C_LONGINT:C283($0)


Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Invoices:5]InvoiceID:1
		
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

Case of 
	: ($fieldPtr=(->[Invoices:5]InvoiceID:1))
		$0:=13
		
	: ($fieldPtr=(->[Customers:3]CustomerID:1))
		$0:=15
		
	: ($fieldPtr=(->[Registers:10]RegisterID:1))
		$0:=16
		
	: ($fieldPtr=(->[Accounts:9]AccountID:1))
		$0:=50
		
	: ($fieldPtr=(->[Branches:70]BranchID:1))
		$0:=2
		
	: ($fieldPtr=(->[Currencies:6]ISO4217:31))
		$0:=3
		
	: (Field name:C257($fieldPtr)="_Sync_ID")
		$0:=16
		
	Else 
		$0:=0
End case 