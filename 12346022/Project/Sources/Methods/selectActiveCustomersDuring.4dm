//%attributes = {}
// selectInactiveCustomersDuring (fromDate;toDate)

C_DATE:C307($fromDate; $toDate)
C_BOOLEAN:C305($inSelection)

$fromDate:=!00-00-00!
$toDate:=Current date:C33
$inSelection:=False:C215  // by default search within the whole data set

Case of 
	: (Count parameters:C259=0)
		// this case is necessary to prevent throwing assertion failure
		
	: (Count parameters:C259=1)
		$fromDate:=$1
		
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
		
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$inSelection:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])

If ($inSelection)
	// first map the customers into the registers
	RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)  // first finds all registers that are reated to current selection of customers
	// then withing those registers, filter the date range we are interested in
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
	// then map back the result into the customers
	RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  //
Else 
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
	RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // map all active customers from registers
End if 
