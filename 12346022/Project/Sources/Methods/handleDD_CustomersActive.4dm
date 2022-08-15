//%attributes = {}
// handleDD_activeCustomers (self: pointer ; inSelection: bool ; formEvent: longint)
// this controller method is used in the Customers.ListBox dropdown menu that displays the active customers, etc

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)
C_LONGINT:C283($selectedRow; $n1; $n2; $n3)
C_DATE:C307($fromDate; $toDate)

$inSelection:=False:C215
$formEvent:=Form event code:C388

Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
		
	: (Count parameters:C259=1)
		$self:=$1
		
	: (Count parameters:C259=2)
		$self:=$1
		$inSelection:=$2
		
	: (Count parameters:C259=3)
		$self:=$1
		$inSelection:=$2
		$formEvent:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($formEvent=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	APPEND TO ARRAY:C911($self->; "Active...")
	APPEND TO ARRAY:C911($self->; "Active Today")
	APPEND TO ARRAY:C911($self->; "Active in the past month")
	APPEND TO ARRAY:C911($self->; "Active in the past 3 months")
	APPEND TO ARRAY:C911($self->; "Active in the past 6 months")
	APPEND TO ARRAY:C911($self->; "Active in the past year")
	APPEND TO ARRAY:C911($self->; "Active in the past 2 years")
	APPEND TO ARRAY:C911($self->; "Active since inception")
	APPEND TO ARRAY:C911($self->; "Active during Date Range...")
	APPEND TO ARRAY:C911($self->; "____________________________________")
	
	APPEND TO ARRAY:C911($self->; "Inactive Today")  //11
	APPEND TO ARRAY:C911($self->; "Inactive in the past month")  //12
	APPEND TO ARRAY:C911($self->; "Inactive in the past 3 months")  //13
	APPEND TO ARRAY:C911($self->; "Inactive in the past 6 months")  //14
	APPEND TO ARRAY:C911($self->; "Inactive in the past year")
	APPEND TO ARRAY:C911($self->; "Inactive in the past 2 years")
	APPEND TO ARRAY:C911($self->; "Inactive since inception")
	APPEND TO ARRAY:C911($self->; "Inactive during Date Range...")
	
	$self->:=1
End if 

If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$Self->
	
	Case of 
		: ($selectedRow=1)  // all time active
			//$fromDate:=nullDate 
			//$toDate:=Current date
			//selectActiveCustomersDuring ($fromDate;$toDate)
			
		: ($selectedRow=2)  // Today
			$fromDate:=Current date:C33
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=3)  // past 30 days
			$fromDate:=Add to date:C393(Current date:C33; 0; -1; 0)
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=4)  // past 3 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -3; 0)
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=5)  // past 6 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -6; 0)
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=6)  // past 1 year
			$fromDate:=Add to date:C393(Current date:C33; -1; 0; 0)
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=7)  // past 2 years
			$fromDate:=Add to date:C393(Current date:C33; -2; 0; 0)
			$toDate:=Current date:C33
			selectActiveCustomersDuring($fromDate; $toDate; $inSelection)
			
		: ($selectedRow=8)  // since inception
			selectActiveCustomersDuring(!00-00-00!; Current date:C33; $inSelection)
			
		: ($selectedRow=9)  // date range
			requestDateRange
			selectActiveCustomersDuring(vFromDate; vToDate; $inSelection)
			
		: ($selectedRow=10)  //
			
			
		: ($selectedRow=11)  // inactive today
			$fromDate:=Current date:C33
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=12)  // past month
			$fromDate:=Add to date:C393(Current date:C33; 0; -1; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=13)  // past 3 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -3; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=14)  // past 6 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -6; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=15)  // past 12 months
			$fromDate:=Add to date:C393(Current date:C33; -1; 0; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
			
		: ($selectedRow=16)  // past 24 months
			$fromDate:=Add to date:C393(Current date:C33; -2; 0; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=17)  // since inception
			selectInactiveCustomersDuring
			
		: ($selectedRow=18)  // in date range
			requestDateRange
			selectInactiveCustomersDuring(vFrom; vToDate)
		Else 
	End case 
	
	POST OUTSIDE CALL:C329(Current process:C322)
End if 

// getbuild