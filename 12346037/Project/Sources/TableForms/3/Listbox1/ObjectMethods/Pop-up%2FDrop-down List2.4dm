C_LONGINT:C283($selection)
$selection:=Self:C308->


Case of 
	: ($selection=0)
		allRecordsCustomers
	: ($selection=7)
		QUERY:C277([Customers:3]; [Customers:3]AML_isSuspicious:49=True:C214)
	Else 
		QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75=$selection-1)
		
End case 

orderbyCustomers
POST OUTSIDE CALL:C329(Current process:C322)

