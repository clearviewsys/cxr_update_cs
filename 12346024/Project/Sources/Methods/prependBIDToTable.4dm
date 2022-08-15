//%attributes = {}
// prependBIDToTable (->table;->primaryKeyPtr;methodName)


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_TEXT:C284($TableName; $tablePrefix; $methodName; $3)

Case of 
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$tableName:=Table name:C256($tablePtr)
		$tablePrefix:=Substring:C12($tableName; 1; 3)  // e.g. INV@ for invoices since all invoice number start with INV
		$methodName:=$3
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
		$tableName:=Table name:C256($tablePtr)
		$tablePrefix:=Uppercase:C13(Substring:C12($tableName; 1; 3))  // e.g. INV@ for invoices since all invoice number start with INV
		$methodName:="prependBranchIDTo"+Substring:C12(Table name:C256($tablePtr); 1; Length:C16($tableName)-1)+"Rec"
		
	Else 
		$tablePtr:=->[Bookings:50]
		$fieldPtr:=->[Bookings:50]BookingID:1
		$tableName:=Table name:C256($tablePtr)
		$tablePrefix:=Uppercase:C13(Substring:C12($tableName; 1; 3))  // e.g. INV@ for invoices since all invoice number start with INV
		$methodName:="prependBranchIDToBookingRec"
		
End case 

QUERY:C277($tablePtr->; $fieldPtr->=$tablePrefix+"@")
updateTableUsingMethod($tablePtr; $methodName; False:C215)
