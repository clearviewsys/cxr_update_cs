//%attributes = {}

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "reportTitle"; "Please Enter o Edit The Report Information")
		
		initialDate:=Current date:C33(*)
		finalDate:=Current date:C33(*)
		READ ONLY:C145([Branches:70])
		READ ONLY:C145([Customers:3])
		READ ONLY:C145([Links:17])
		READ ONLY:C145([eWires:13])  // added by TB to prevent locking of customers
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getBranchID)
		reportingBranchName:=[Branches:70]BranchName:2
		AUS_GetEntityAndContactInfo
		
		operationMode:=1
		lct_report:=1
		remittance_report:=0
		
End case 

