//%attributes = {}

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "reportTitle"; "Please Enter o Edit The Report Information")
		
		vFromDate:=Current date:C33(*)
		vToDate:=Current date:C33(*)
		
		READ ONLY:C145([Branches:70])
		READ ONLY:C145([Customers:3])
		READ ONLY:C145([Links:17])
		READ ONLY:C145([eWires:13])
		
		REDUCE SELECTION:C351([Registers:10]; 0)
		REDUCE SELECTION:C351([Invoices:5]; 0)
		REDUCE SELECTION:C351([Customers:3]; 0)
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getBranchID)
		reportingBranchName:=[Branches:70]BranchName:2
		
		operationMode:=1
		lct_report:=1
		remittance_report:=0
		
End case 

