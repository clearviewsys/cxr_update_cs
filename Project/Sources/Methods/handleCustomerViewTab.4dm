//%attributes = {}
// handleCustomerViewTab (->tabWidget)
// getBuild

C_REAL:C285(vSumMarketValues)
C_POINTER:C301($tabPtr)
$tabPtr:=$1
If (Not:C34(Is nil pointer:C315($tabPtr)))  // always a good test
	Case of 
		: ($tabPtr->=1)  // picture ID
			relateMany(->[LinkedDocs:4]; ->[LinkedDocs:4]CustomerID:1; ->[Customers:3]CustomerID:1)
			orderByLinkedDocs
			
		: ($tabPtr->=2)  // summary of all invoices related to customer
			// getBuild
			relateMany(->[Invoices:5]; ->[Invoices:5]CustomerID:2; ->[Customers:3]CustomerID:1)
			relateMany(->[Registers:10]; ->[Registers:10]CustomerID:5; ->[Customers:3]CustomerID:1)
			orderByInvoices
			orderByRegisters
			UNLOAD RECORD:C212([Registers:10])
			UNLOAD RECORD:C212([Invoices:5])
			
		: ($tabPtr->=3)  // cheques
			relateMany(->[Cheques:1]; ->[Cheques:1]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderBycheques
			
			relateMany(->[CashTransactions:36]; ->[CashTransactions:36]CustomerID:10; ->[Customers:3]CustomerID:1)
			orderBycashTransactions
			
		: ($tabPtr->=4)  //wires & Wire Templates
			relateMany(->[Wires:8]; ->[Wires:8]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByWires
			
			relateMany(->[WireTemplates:42]; ->[WireTemplates:42]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByWireTemplates
			
		: ($tabPtr->=5)  //eWires & linkes
			selecteWiresForCustomer([Customers:3]CustomerID:1)  // first select the links
			relateMany(->[Links:17]; ->[Links:17]CustomerID:14; ->[Customers:3]CustomerID:1)
			orderByLinks
			
		: ($tabPtr->=6)  // Balance Due
			ARRAY TEXT:C222(arrDueType; 3)
			handleTabCustomerDue(arrDueType)
			
		: ($tabPtr->=7)  // Accounts
			relateMany(->[Accounts:9]; ->[Accounts:9]CustomerID:20; ->[Customers:3]CustomerID:1)
			orderByAccounts
			acc_fillAccouctsListBox
			vSumMarketValues:=Sum:C1(acc_arrMarketValues)
			
		: ($tabPtr->=8)  // Bookings
			relateMany(->[Bookings:50]; ->[Bookings:50]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByBOOKINGS
			
			
			
		: ($tabPtr->=9)  // other
			// nothing 
			
		: ($tabPtr->=10)  // KYC and sanctions & notes
			relateManySanctionChecklogRel(->[Customers:3]; [Customers:3]CustomerID:1)
			relateMany(->[CallLogs:51]; ->[CallLogs:51]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByCallLogs
			
		: ($tabPtr->=11)  // relations
			relateManyCSMRelations
			
		: ($tabPtr->=12)  // reviews for Profile and Risk 
			relateMany(->[KYC_ReviewLog:124]; ->[KYC_ReviewLog:124]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByKYC_ReviewLog
			relateMany(->[AML_ReviewLog:125]; ->[AML_ReviewLog:125]CustomerID:2; ->[Customers:3]CustomerID:1)
			orderByAML_ReviewLog
	End case 
End if 
