//%attributes = {}
// handleDD_selectCustomersByGroup (self: pointer ; inSelection: boolean ; formEvent: longint)
// handleDD_selectCustomersByGroup (self: pointer ; inSelection: boolean )
// handleDD_selectCustomersByGroup (self: pointer)

// this handler (controller method) handles the pulldown menu for filtering Customers by Group 
// if the 'inSelection' is true, it will filter within the current selection of records in Customers
// written by @viktor ; modified by @tiran

// PRE: 
// POST:  it doesn't re-order the customers

// Select records in a table by Group
// Takes no paramaters, is called inside dropdown menu Object Method

// Unit test is written

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)

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

If ($self#Null:C1517)
	
	If ($formEvent=On Load:K2:1)
		READ ONLY:C145([CustomerTypes:94])
		allRecordsCustomerTypes
		//ARRAY TEXT($Self->;0)
		SELECTION TO ARRAY:C260([CustomerTypes:94]CustomerTypeID:1; $Self->)
		INSERT IN ARRAY:C227($self->; 1; 1)  // we need to insert the first line so that we don't overwrite the first item (or create one in case it's empty)
		$Self->{1}:="Groups..."
		$Self->:=1
	End if 
	
	If ($formEvent=On Clicked:K2:4)
		C_TEXT:C284($customerGroup)
		If ($Self->>1)
			$customerGroup:=$Self->{$Self->}
			If ($customerGroup#$Self->{1})
				If ($inSelection)
					QUERY SELECTION:C341([Customers:3]; [Customers:3]GroupName:90=$customerGroup)
				Else 
					QUERY:C277([Customers:3]; [Customers:3]GroupName:90=$customerGroup)
				End if 
			End if 
		End if 
	End if 
End if 