//%attributes = {}
// selectInactiveCustomersDuring(fromDate;toDate)

C_DATE:C307($1; $fromDate)
C_DATE:C307($2; $toDate)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=!00-00-00!
		$toDate:=Current date:C33
		
	: (Count parameters:C259=1)
		$fromDate:=$1
		$toDate:=Current date:C33
		
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])
// find all activities during date range
QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)

// map them to customers

RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // map all active customers from registers
CREATE SET:C116([Customers:3]; "$activeSet")  // 
ALL RECORDS:C47([Customers:3])  // all customers
CREATE SET:C116([Customers:3]; "$allSet")  // 
DIFFERENCE:C122("$allSet"; "$activeSet"; "$inactiveSet")  // All customers minus the active customers should give the inactive customers
USE SET:C118("$inactiveSet")

CLEAR SET:C117("$activeSet")  // cleanup
CLEAR SET:C117("$allSet")  // cleanup
CLEAR SET:C117("$inactiveSet")  // cleanup

//displaySelectedRecords (->[Customers])

