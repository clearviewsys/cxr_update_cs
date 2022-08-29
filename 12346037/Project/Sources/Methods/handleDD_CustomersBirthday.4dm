//%attributes = {}
// handleDD_CustomersBirthday (Self; inSelection:boolean ; formEvent: longint)
// see handleDD_template
// this controller method is called from the misc pulldown menu in the 
// POST: the current seletion of records in the table will be affected

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)

C_LONGINT:C283($selectedRow)

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
	
	APPEND TO ARRAY:C911($self->; "Birthday Filter")
	APPEND TO ARRAY:C911($self->; "Birthdays Today")
	APPEND TO ARRAY:C911($self->; "Birthdays Next 3 days")
	APPEND TO ARRAY:C911($self->; "Birthdays Next 7 days")
	APPEND TO ARRAY:C911($self->; "Birthdays Next 30 days")
	APPEND TO ARRAY:C911($self->; "Birthdays Next 60 days")
	APPEND TO ARRAY:C911($self->; "Birthdays Next 90 days")
	
	$self->:=1  // select the first item 
End if 

C_TEXT:C284($selection)

If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$self->
	$selection:=$Self->{$selectedRow}
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: ($selectedRow=1)
			//allRecordsCustomers 
			
		: ($selectedRow=2)
			//QUERY BY FORMULA([Customers];isDateWithinRange ([Customers]DOB;0))
			getCustomersWithUpcomingBday(1)
			
		: ($selectedRow=3)
			//QUERY BY FORMULA([Customers];isDateWithinRange ([Customers]DOB;1))
			getCustomersWithUpcomingBday(3)
			
		: ($selectedRow=4)  // next 7 days
			//QUERY BY FORMULA([Customers];isDateWithinWeek ([Customers]DOB))
			getCustomersWithUpcomingBday(7)
			
		: ($selectedRow=5)  // in 30 days
			//QUERY BY FORMULA([Customers];isDateWithinRange ([Customers]DOB;30))
			getCustomersWithUpcomingBday(30)
			
		: ($selectedRow=6)  // two months
			//QUERY BY FORMULA([Customers];isDateWithinRange ([Customers]DOB;60))
			getCustomersWithUpcomingBday(60)
			
		: ($selectedRow=7)  // three months
			//QUERY BY FORMULA([Customers];isDateWithinRange ([Customers]DOB;90))
			getCustomersWithUpcomingBday(90)
			
		Else 
			myAlert("Invalid Selection")
	End case 
	
	POST OUTSIDE CALL:C329(Current process:C322)  // to update the screen (listbox)
End if 
