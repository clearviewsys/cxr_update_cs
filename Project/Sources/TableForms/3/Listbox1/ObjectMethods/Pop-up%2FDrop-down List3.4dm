ARRAY TEXT:C222(arrCustomerDOBs; 6)
C_LONGINT:C283($i; $n1; $n2; $n3)
$i:=arrCustomerDOBs
C_DATE:C307($date)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
Case of 
	: ($i=1)
		allRecordsCustomers
		
	: ($i=2)
		//QUERY([Customers];[Customers]DOB=Current date)
		QUERY BY FORMULA:C48([Customers:3]; isDateWithinRange([Customers:3]DOB:5; 1))
		
	: ($i=3)  // next 7 days
		//$date:=Add to date(Current date;0;0;8)
		//QUERY([Customers];[Customers]DOB<=$date;*)
		//QUERY([Customers]; & ;[Customers]DOB>=Current date)
		
		QUERY BY FORMULA:C48([Customers:3]; isDateWithinWeek([Customers:3]DOB:5))
		
	: ($i=4)  // in 30 days
		//$date:=Add to date(Current date;0;1;0)
		//QUERY([Customers];[Customers]DOB<=$date;*)
		//QUERY([Customers]; & ;[Customers]DOB>=Current date)
		QUERY BY FORMULA:C48([Customers:3]; isDateWithinRange([Customers:3]DOB:5; 30))
		
	: ($i=5)  // two months
		//$date:=Add to date(Current date;0;2;0)
		//QUERY([Customers];[Customers]DOB<=$date;*)
		//QUERY([Customers]; & ;[Customers]DOB>=Current date)
		QUERY BY FORMULA:C48([Customers:3]; isDateWithinRange([Customers:3]DOB:5; 60))
		
	: ($i=6)  // two months
		//$date:=Add to date(Current date;0;3;0)
		//QUERY([Customers];[Customers]DOB<=$date;*)
		//QUERY([Customers]; & ;[Customers]DOB>=Current date)
		QUERY BY FORMULA:C48([Customers:3]; isDateWithinRange([Customers:3]DOB:5; 90))
		
	Else 
End case 

orderbyCustomers
POST OUTSIDE CALL:C329(Current process:C322)
