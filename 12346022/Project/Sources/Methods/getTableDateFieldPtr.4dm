//%attributes = {}
C_POINTER:C301($datePtr; $tablePtr; $1; $0)

$tablePtr:=$1

Case of 
	: ($tablePtr=->[AML_Alerts:137])
		$datePtr:=->[AML_Alerts:137]date:5
		
	: ($tablePtr=->[Customers:3])
		$datePtr:=->[Customers:3]CreationDate:54
		
	: ($tablePtr=->[Invoices:5])
		$datePtr:=->[Invoices:5]invoiceDate:44
		
	: ($tablePtr=->[Registers:10])
		$datePtr:=->[Registers:10]RegisterDate:2
		
	: ($tablePtr=->[AML_ReviewLog:125])
		$datePtr:=->[AML_ReviewLog:125]ReviewDate:3
		
	: ($tablePtr=->[KYC_ReviewLog:124])
		$datePtr:=->[KYC_ReviewLog:124]ReviewDate:3
		
	: ($tablePtr=->[SanctionCheckLog:111])
		$datePtr:=->[SanctionCheckLog:111]CheckDate:3
		
	: ($tablePtr=->[CallLogs:51])
		$datePtr:=->[CallLogs:51]CallDate:3
		
	: ($tablePtr=->[Cheques:1])
		$datePtr:=->[Cheques:1]DueDate:3
		
	: ($tablePtr=->[eWires:13])
		$datePtr:=->[eWires:13]creationDate:53
		
	: ($tablePtr=->[Links:17])
		$datePtr:=->[Links:17]CreationDate:20
		
	: ($tablePtr=->[ThirdParties:101])
		$datePtr:=->[ThirdParties:101]creationDate:34
		
	: ($tablePtr=->[Wires:8])
		$datePtr:=->[Wires:8]WireTransferDate:17
		
	: ($tablePtr=->[CashTransactions:36])
		$datePtr:=->[CashTransactions:36]Date:5
		
	: ($tablePtr=->[ItemInOuts:40])
		$datePtr:=->[ItemInOuts:40]Date:3
		
	: ($tablePtr=->[AccountInOuts:37])
		$datePtr:=->[AccountInOuts:37]Date:3
		
	: ($tablePtr=->[Bookings:50])
		$datePtr:=->[Bookings:50]BookingDate:3
		
	: ($tablePtr=->[ExceptionsLog:75])
		$datePtr:=->[ExceptionsLog:75]Date:2
		
		
	Else 
End case 

$0:=$datePtr