//%attributes = {}
// handleDD_Template (Self; inSelection:boolean ; formEvent: longint)
// this controller method is called from the misc pulldown menu in the 
// POST: the current seletion of records in the table will be affected

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)
C_TEXT:C284($selection)

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
	
	APPEND TO ARRAY:C911($self->; "Web Customers...")
	
	APPEND TO ARRAY:C911($self->; "Web Customers (Unassigned status)❓")
	APPEND TO ARRAY:C911($self->; "Web Customers (Approved) ✔")
	APPEND TO ARRAY:C911($self->; "Web Customers (Pending Approval Existing)")
	APPEND TO ARRAY:C911($self->; "Web Customers (Pending Approval New)")
	APPEND TO ARRAY:C911($self->; "Web Customers (Rejected) 🚫")
	
	$self->:=1  // select the first item 
End if 


If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$self->
	$selection:=$Self->{$selectedRow}
	
	If ($inSelection=False:C215)
		allRecordsCustomers
	End if 
	
	Case of 
		: ($selectedRow=1)  // default selection
			allRecordsCustomers
			
		: ($selectedRow=2)  // on hold 
			QUERY SELECTION:C341([Customers:3]; [Customers:3]approvalStatus:146=0)
			
		: ($selectedRow=3)  // approved from the web
			QUERY SELECTION:C341([Customers:3]; [Customers:3]approvalStatus:146=1)
			
		: ($selectedRow=4)  // existing customer - just registered on the web but pending approved
			QUERY SELECTION:C341([Customers:3]; [Customers:3]approvalStatus:146=2)
			
		: ($selectedRow=5)  // added from the web but pending approved
			QUERY SELECTION:C341([Customers:3]; [Customers:3]approvalStatus:146=3)
			
		: ($selectedRow=6)  //  the web rejected for web
			QUERY SELECTION:C341([Customers:3]; [Customers:3]approvalStatus:146=4)
			
		Else 
			myAlert("Invalid row selected!"+String:C10($selectedRow))
	End case 
	POST OUTSIDE CALL:C329(Current process:C322)  // to update the screen (listbox)
	
End if 
