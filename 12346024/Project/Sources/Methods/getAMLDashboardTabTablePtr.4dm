//%attributes = {}
//getAMLDashboardTabTablePtr ({pageNo})
// returns the tablePtr depending on which page number we are on the AML_Dashboard
// the page Number is the same as the Tab value

C_POINTER:C301($tablePtr; $0)
C_LONGINT:C283($page; $1)

Case of 
	: (Count parameters:C259=0)
		$page:=FORM Get current page:C276
	: (Count parameters:C259=1)
		$page:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($page=1)
		$tablePtr:=->[AML_Alerts:137]
		
	: ($page=2)
		$tablePtr:=->[Customers:3]
		
	: ($page=3)
		$tablePtr:=->[Invoices:5]
		
	: ($page=4)
		$tablePtr:=->[Registers:10]
		
	: ($page=5)
		$tablePtr:=->[CallLogs:51]
		
	: ($page=6)
		$tablePtr:=->[Registers:10]
		
	: ($page=6)
		$tablePtr:=->[CallLogs:51]
		
	: ($page=7)
		$tablePtr:=->[ExceptionsLog:75]
		
	: ($page=8)
		$tablePtr:=->[KYC_ReviewLog:124]
		
	: ($page=9)
		$tablePtr:=->[AML_ReviewLog:125]
		
	: ($page=10)
		$tablePtr:=->[AML_Reports:119]
		
	: ($page=11)
		$tablePtr:=->[AML_RiskTemplates:138]
		
	: ($page=12)
		$tablePtr:=->[AMLRules:74]
		
	: ($page=13)
		$tablePtr:=->[AML_AggrRules:150]
		
	: ($page=14)
		
	Else 
		myAlert("unhandled page")
End case 

$0:=$tablePtr