C_LONGINT:C283($i; $n1; $n2; $n3)
$i:=Self:C308->
C_DATE:C307($fromDate; $toDate)

Case of 
	: ($i=1)
		$fromDate:=!00-00-00!
		$toDate:=Current date:C33
		
	: ($i=2)  // Today
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		
	: ($i=3)  // this month
		$fromDate:=Add to date:C393(Current date:C33; 0; -1; 0)
		$toDate:=Current date:C33
		
	: ($i=4)  // this year
		$fromDate:=Add to date:C393(Current date:C33; -1; 0; 0)
		$toDate:=Current date:C33
		
	: ($i=5)  // past 2 years
		$fromDate:=Add to date:C393(Current date:C33; -2; 0; 0)
		$toDate:=Current date:C33
End case 
selectAccountsInDateRange($fromDate; $toDate; True:C214)
filterHiddenAccounts
orderByAccounts
POST OUTSIDE CALL:C329(Current process:C322)
