C_LONGINT:C283($i; $n1; $n2; $n3)
$i:=Self:C308->
C_DATE:C307($fromDate; $toDate)

Case of 
	: ($i=1)  // all time active
		$fromDate:=nullDate
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=2)  // Today
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=3)  // past 30 days
		$fromDate:=Add to date:C393(Current date:C33; 0; -1; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=4)  // past 3 months
		$fromDate:=Add to date:C393(Current date:C33; 0; -3; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=5)  // past 6 months
		$fromDate:=Add to date:C393(Current date:C33; 0; -6; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=6)  // past 9 months
		$fromDate:=Add to date:C393(Current date:C33; 0; -9; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	: ($i=7)  // past 1 year
		$fromDate:=Add to date:C393(Current date:C33; -1; 0; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
		
	: ($i=8)  // past 2 years
		$fromDate:=Add to date:C393(Current date:C33; -2; 0; 0)
		$toDate:=Current date:C33
		selectActiveCustomersDuring($fromDate; $toDate)
		
	Else 
End case 
orderbyCustomers
POST OUTSIDE CALL:C329(Current process:C322)
