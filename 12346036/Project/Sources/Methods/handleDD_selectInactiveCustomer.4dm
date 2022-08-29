//%attributes = {}
// handleDD_selectInactiveCustomers (Self; inSelection:boolean ; formEvent: longint)
// this controller method is called from the misc pulldown menu in the 
// POST: the current seletion of records in the table will be affected

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)
C_TEXT:C284($selection)

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
	APPEND TO ARRAY:C911($self->; "Inactive...")
	APPEND TO ARRAY:C911($self->; "Not active in the past month")
	APPEND TO ARRAY:C911($self->; "Not active in the past 3 months")
	APPEND TO ARRAY:C911($self->; "Not active in the past 6 months")
	APPEND TO ARRAY:C911($self->; "Not active in the past 12 months")
	APPEND TO ARRAY:C911($self->; "Not active in the past 24 months")
	APPEND TO ARRAY:C911($self->; "Not active since inception")
	APPEND TO ARRAY:C911($self->; "Not active during Date Range")
	
	$self->:=1  // select the first item 
	
End if 


If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$self->
	$selection:=$Self->{$selectedRow}
	Case of 
		: ($selectedRow=1)  // all time active
			//$fromDate:=nullDate 
			//$toDate:=Current date
			//selectActiveCustomersDuring ($fromDate;$toDate)
			
		: ($selectedRow=2)  // past month
			$fromDate:=Add to date:C393(Current date:C33; 0; -1; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=3)  // past 3 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -3; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=4)  // past 6 months
			$fromDate:=Add to date:C393(Current date:C33; 0; -6; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=5)  // past 12 months
			$fromDate:=Add to date:C393(Current date:C33; -1; 0; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
			
		: ($selectedRow=6)  // past 24 months
			$fromDate:=Add to date:C393(Current date:C33; -2; 0; 0)
			$toDate:=Current date:C33
			selectInactiveCustomersDuring($fromDate; $toDate)
			
		: ($selectedRow=7)  // since inception
			selectInactiveCustomersDuring
			
		: ($selectedRow=8)
			requestDateRange
			selectInactiveCustomersDuring(vFrom; vToDate)
		Else 
	End case 
	
	POST OUTSIDE CALL:C329(Current process:C322)  // to update the screen (listbox)
	
End if 