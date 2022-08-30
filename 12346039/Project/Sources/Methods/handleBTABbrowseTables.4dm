//%attributes = {}
C_POINTER:C301(browseTablePtr)

Case of 
	: (FORM Get current page:C276=1)  // CUSTOMER

		browseTablePtr:=->[Customers:3]
		UNLOAD RECORD:C212([Customers:3])
		UNLOAD RECORD:C212([LinkedDocs:4])
	: (FORM Get current page:C276=2)  // INVOICES

		browseTablePtr:=->[Invoices:5]
		UNLOAD RECORD:C212([eWires:13])
		UNLOAD RECORD:C212([Customers:3])
		UNLOAD RECORD:C212([Invoices:5])
	: (FORM Get current page:C276=3)  // REGISTERS

		browseTablePtr:=->[Registers:10]
		UNLOAD RECORD:C212([Registers:10])
		UNLOAD RECORD:C212([Customers:3])
	: (FORM Get current page:C276=4)  // EWIRES

		browseTablePtr:=->[eWires:13]
		UNLOAD RECORD:C212([Links:17])
		UNLOAD RECORD:C212([Customers:3])
		UNLOAD RECORD:C212([eWires:13])
	: (FORM Get current page:C276=5)  // LINKS

		browseTablePtr:=->[Links:17]
		UNLOAD RECORD:C212([Links:17])
		UNLOAD RECORD:C212([Customers:3])
End case 
autoFillSearchTable(browseTablePtr)
//CALL PROCESS(Current process)

