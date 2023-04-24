//%attributes = {}

If (getKeyValue("Settings.walkin"; "create")="create")  // by default the walking customer will be created except when ...
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=getWalkInCustomerID)
	
	If (Records in selection:C76([Customers:3])=0)
		// create the self customer
		READ WRITE:C146([Customers:3])
		CREATE RECORD:C68([Customers:3])
		[Customers:3]AML_ignoreKYC:35:=True:C214
		
		[Customers:3]isWalkin:36:=True:C214
		[Customers:3]CustomerID:1:=getWalkInCustomerID
		[Customers:3]isCompany:41:=False:C215
		[Customers:3]FirstName:3:=getWalkInCustomerName
		SAVE RECORD:C53([Customers:3])
		UNLOAD RECORD:C212([Customers:3])
		READ ONLY:C145([Customers:3])
	End if 
End if 

